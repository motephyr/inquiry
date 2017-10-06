# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#
set :output, 'log/cron.log'

if @environment == "production"
  every 3.hours, :roles => [:app] do
    rake "send_notification:unlogin"
  end

  every :friday, :at => '11:30am', :roles => [:app] do # Use any day of the week or :weekend, :weekday
	  rake "send_notification:newworks"
	end
end