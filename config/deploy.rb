require "mina/bundler"
require "mina/rails"
require "mina/git"
require "mina/rvm"

set :forward_agent, true
set :term_mode, nil

set :keep_releases, "1"
set :bundle_gemfile, "app/Gemfile"

set :user, "ubuntu"
set :rvm_path, "/home/ubuntu/.rvm/bin/rvm"

set :repository, "git@github.com:elevatecnologia/eventos-ranking.git"
set :name_deploy, "eventos-ranking"
set :shared_dirs, fetch(:shared_dirs, []).push("log", "shared/pids", "shared/sockets", "shared/log", "importation_report")
set :shared_paths, fetch(:shared_paths, []).push("log", "shared/pids", "shared/sockets", "shared/log", "importation_report")

set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
# set :shared_files, fetch(:shared_files, []).push( 'config/database.yml', 'config/secrets.yml')

task :remote_environment do
  # invoke :'rvm:use', "ruby 2.6.0"
  command "source $HOME/.profile"
  command "source $HOME/.bashrc"
end

# # Task de configs de deploy no server de staging
# task :staging => :remote_environment do
#   set :domain, "3.88.225.78" # IP Staging
#   set :rails_env, "staging"
#   set :branch, "master"
#   set :deploy_to, "/home/ubuntu/apps/eleva"
# end

# Task de configs de deploy no server de produção
task :production => :remote_environment do
  set :domain, "3.229.198.7" # IP de Produção
  set :rails_env, "production"
  set :branch, "master"
  set :deploy_to, "/home/ubuntu/apps/eventos-ranking"
end

# # Task de configs de deploy no server de staging
# task :staging => :remote_environment do
#   set :domain, "107.22.106.133" # IP Staging
#   set :rails_env, "staging"
#   set :branch, "master"
#   set :deploy_to, "/home/ubuntu/apps/eventos-ranking"
# end

task :logx do
  run :remote do
    in_path(fetch(:current_path)) do
      command %{RAILS_ENV=#{fetch(:rails_env)} && tail -f log/production.log }
    end
  end
end

task :setup do
  # deploy do
  #   # command "RAILS_ENV=production bundle exec rake db:setup"
  # end
end

task :first_deploy => :remote_environment do
  deploy do
    command "source $HOME/.profile"
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    command "bundle install"

    comment "Removing self libs with conflicts."
    command %{rm -rf lib/templates}
    command %{rm -rf lib/generators/rails/stimulus_scaffold}
    # invoke :'bundle:install'
    # command "RAILS_ENV=#{fetch(:rails_env)} bundle exec rake db:setup"
    # invoke :'rails:db_migrate'
    # invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      command "source $HOME/.profile"
      command %{mkdir -p tmp/}
    end
  end
end

task :deploy => :remote_environment do
  comment "Backuping Public Assets."
  command %{cp -r #{fetch(:current_path)}/public/packs #{fetch(:deploy_to)}/ }
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    command "bundle install"
    # invoke :'bundle:install'
    # command "RAILS_ENV=production bundle exec rake db:setup"
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      command "source $HOME/.profile"
      command "source $HOME/.bashrc"
      
      comment "Restoring Public Assets."
      command %{cp -r #{fetch(:deploy_to)}/packs #{fetch(:current_path)}/public/ }

      comment "Assets Precompile."
      #command %{bundle exec rake assets:precompile}

      command %{mkdir -p tmp/}

      # comment "Whenever Contab File Update"
      # command %{bundle exec whenever --update-crontab}

      comment "Removing self libs with conflicts."
      command %{rm -rf lib/templates}
      command %{rm -rf lib/generators/rails/stimulus_scaffold}

      comment "Restarting Services."
      #command %{sudo service eleva_production stop}
      #command %{sudo service eleva_production stop}
      #command %{sudo service eleva_production start}

      # command %{bin/delayed_job -n 2 restart}
      # command %{/home/ubuntu/apps/eleva/current/bin/delayed_job -n 2 restart}
      # command "sudo stop  puma app=/home/ubuntu/fv/mavericks/current &> /dev/null"
      # command "sudo start puma app=/home/ubuntu/fv/mavericks/current"
    end
  end
end


task :light_deploy => :remote_environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    command "bundle install"
    # invoke :'bundle:install'
    # command "RAILS_ENV=production bundle exec rake db:setup"
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      command "source $HOME/.profile"
      command "source $HOME/.bashrc"
      # in_path(fetch(:current_path)) do
      #   # invoke :'rvm:use', 'ruby 2.6.0'
      # end
      # invoke :'rails:assets_precompile'
      comment "Assets Precompile."
      # command %{bundle exec rails assets:precompile}

      command %{mkdir -p tmp/}

      # comment "Whenever Contab File Update"
      # command %{bundle exec whenever --update-crontab}

      comment "Removing self libs with conflicts."
      command %{rm -rf lib/templates}
      command %{rm -rf lib/generators/rails/stimulus_scaffold}

      # comment "Restarting Services."
      # command %{sudo service eleva_production stop}
      # command %{sudo service eleva_production stop}
      # command %{sudo service eleva_production start}

      # command %{bin/delayed_job -n 2 restart}
      # command %{/home/ubuntu/apps/eleva/current/bin/delayed_job -n 2 restart}
      # command "sudo stop  puma app=/home/ubuntu/fv/mavericks/current &> /dev/null"
      # command "sudo start puma app=/home/ubuntu/fv/mavericks/current"
    end
  end
end

# AKIAVRHGGLZE75I42BVH
