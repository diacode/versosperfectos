# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/home/rails/versosperfectos.com/current"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/rails/versosperfectos.com/shared/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/rails/versosperfectos.com/shared/log/unicorn.log"
stdout_path "/home/rails/versosperfectos.com/shared/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.versosperfectos.sock"

# Number of processes
# worker_processes 4
worker_processes 2

preload_app true

# Time-out
timeout 30

user "deploy"

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
