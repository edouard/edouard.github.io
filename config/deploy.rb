set :application,       'foo'
set :repository,        '_site'
set :scm,               :none
set :deploy_via,        :copy
set :copy_compression,  :gzip
set :use_sudo,          false
set :host,              'gandalf.atelierconvivialite.com'

role :web,  host
role :app,  host
role :db,   host, :primary => true

set :user,    'edouard'
set :group,   user

set :deploy_to,    "/web/sites/edouardbriere.fr/"

before 'deploy:update', 'deploy:update_jekyll'

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

namespace :deploy do

  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do ; end
  end
  
  desc 'Run jekyll to update site before uploading'
  task :update_jekyll do
    %x(rm -rf _site/* && jekyll build)
  end
  
end
