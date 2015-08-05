namespace :rails do
  desc 'Open a rails console `cap [staging] rails:console [server_index default: 0]`'
  task :console do
    on roles(:app) do |server|
      server_index = ARGV[2].to_i
      return if server != roles(:app)[server_index]
      puts "Opening a console on: #{host}...."
      cmd = "ssh #{server.user}@#{host} -t 'source /etc/profile && cd #{fetch(:deploy_to)}/current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"
      exec cmd
    end
  end

  desc 'Open a rails console `cap [staging] rails:dbconsole [server_index default: 0]`'
  task :dbconsole do
    on roles(:app) do |server|
      server_index = ARGV[2].to_i
      return if server != roles(:app)[server_index]
      puts "Opening a dbconsole on: #{host}...."
      cmd = "ssh #{server.user}@#{host} -t 'source /etc/profile && cd #{fetch(:deploy_to)}/current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails dbconsole'"
      exec cmd
    end
  end
end