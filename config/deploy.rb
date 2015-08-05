# config valid only for current version of Capistrano
lock '3.3.3'

set :application, 'versosperfectos'
set :scm, :git
set :repo_url, 'git@github.com:diacode/versosperfectos.git'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('.env')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'public/uploads', 'public/system')

namespace :deploy do
end

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
