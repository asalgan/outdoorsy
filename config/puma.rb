# frozen_string_literal: true

environment ENV.fetch('RAILS_ENV', 'development')
# Specify the bind host and environment.
port ENV.fetch('PORT', 3000)

pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
