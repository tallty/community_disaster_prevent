# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "./log/cron_log.log"
set :job_template, "/usr/bin/timeout -s 30 /bin/bash -l -c ':job'"
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

every 1.minutes do
  runner "Warning.new.process"
end

every 10.minutes do
  runner "Lightning.process"
end

every 5.minutes do
  runner "MonitorStation.new.process"
end
