namespace :logs do
  desc "unicorn logs" 
  task :unicorn do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end
end
