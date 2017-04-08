class ButtonRadioInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input(wrapper_options)
    out = '<div class="btn-group" data-toggle="buttons">'
    label_method, value_method = detect_collection_methods
    object_value = object.send(attribute_name)
    collection.each do |item|
      value = item.send(value_method)
      label = item.send(label_method)
      active = ''
      active = ' active' unless
          out =~ / active/ ||
          value != object_value &&
          (item != collection.last || object_value != nil)
      value = object_value unless active.empty?
      btn = 'btn btn-default'
      btn = "btn btn-#{item.third}" unless item.third.nil?
      out << <<-HTML
        <label class="#{btn} #{active}">
          <input type="radio" value="#{value}" name="#{object_name}[#{attribute_name}]">#{label}</input>
        </label>
HTML
    end
    out << "</div>"
    out.html_safe
  end
end