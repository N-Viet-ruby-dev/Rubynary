# frozen_string_literal: true

set :output, error: "log/cron_error_log.log", standard: "log/cron_log.log"

every 1.day do
  rake "list_tasks:auto_destroy"
end
