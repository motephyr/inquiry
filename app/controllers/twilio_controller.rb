require 'twilio-ruby'

class TwilioController < ApplicationController
  # Before we allow the incoming request to connect, verify
  # that it is a Twilio request
  before_action :authenticate_twilio_request, :only => [
    :connect
  ]
  skip_before_action :verify_authenticity_token, :only => [ :voice ]

  # Define our Twilio credentials as instance variables for later use
  @@twilio_sid = Setting.TWILIO_ACCOUNT_SID
  @@twilio_token = Setting.TWILIO_ACCOUNT_TOKEN
  @@twilio_number = Setting.TWILIO_NUMBER
  @@api_host = Setting.domain

  # Render home page
  def index
    render 'index'
  end

  # Handle a POST from our web form and connect a call via REST API
  def call
    # contact = Contact.new
    # contact.user_phone  = "(256) 980-1023"
    # contact.sales_phone = params[:salesPhone]

    # # Validate contact
    # if contact.valid?

      @client = Twilio::REST::Client.new @@twilio_sid, @@twilio_token
      # Connect an outbound call to the number submitted
      @call = @client.calls.create(
        :from => @@twilio_number,
        :to => params[:salesPhone],
        :url => "#{@@api_host}/twilio/connect/#{params[:salesPhone]}" # Fetch instructions from this URL when the call connects
      )

      # Let's respond to the ajax call with some positive reinforcement
      @msg = { :message => 'Phone call incoming!', :status => 'ok' }

    # else

    #   # Oops there was an error, lets return the validation errors
    #   @msg = { :message => contact.errors.full_messages, :status => 'ok' }
    # end
    respond_to do |format|
      format.json { render :json => @msg }
    end
  end

  # This URL contains instructions for the call that is connected with a lead
  # that is using the web form.
  def connect
    # Our response to this request will be an XML document in the "TwiML"
    # format. Our Ruby library provides a helper for generating one
    # of these documents
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Thanks for contacting our sales department. Our ' +
        'next available representative will take your call.', :voice => 'alice'
      r.Dial params[:id]
    end
    render text: response.text
  end

  def token
    # Create a random username for the client
    identity = current_user.id.to_s

    capability = Twilio::Util::Capability.new @@twilio_sid, @@twilio_token
    # Create an application sid at 
    # twilio.com/console/phone-numbers/dev-tools/twiml-apps and use it here
    capability.allow_client_outgoing Setting.TWILIO_TWIML_APP_SID
    capability.allow_client_incoming identity
    token = capability.generate
    
    # Generate the token and send to client
    render json: { :identity => identity, :token => token}
  end

  def voice
    twiml = Twilio::TwiML::Response.new do |r|
      if params['To'] and params['To'] != ''
        r.Dial callerId: @@twilio_number do |d|
          # wrap the phone number or client name in the appropriate TwiML verb
          # by checking if the number given has only digits and format symbols
          if params['To'] =~ /^[\d\+\-\(\) ]+$/
            d.Number params['To']
          else
            d.Client params['To']
          end
        end
      else
        r.Say "Thanks for calling!"
      end
    end
    render xml: twiml.text
  end


  # Authenticate that all requests to our public-facing TwiML pages are
  # coming from Twilio. Adapted from the example at
  # http://twilio-ruby.readthedocs.org/en/latest/usage/validation.html
  # Read more on Twilio Security at https://www.twilio.com/docs/security
  private
  def authenticate_twilio_request
    twilio_signature = request.headers['HTTP_X_TWILIO_SIGNATURE']
    # Helper from twilio-ruby to validate requests.
    @validator = Twilio::Util::RequestValidator.new(@@twilio_token)

    # the POST variables attached to the request (eg "From", "To")
    # Twilio requests only accept lowercase letters. So scrub here:
    post_vars = params.reject {|k, v| k.downcase == k}

    is_twilio_req = @validator.validate(request.url, post_vars, twilio_signature)

    unless is_twilio_req
      render :xml => (Twilio::TwiML::Response.new {|r| r.Hangup}).text, :status => :unauthorized
      false
    end
  end

end