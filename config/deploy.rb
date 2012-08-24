set :gateway, tvserienonline.megiteam.pl
set :application, "tvserienonline"
set :repository,  "https://wlodi83@github.com/wlodi83/tv-serienonline.git"
set :deploy_to, "/public_html/#{application}"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "localhost"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
role :db,  "localhost", :primary => true # This is where Rails migrations will run

namespace :deploy do
  desc "Restart aplikacji przy pomocy skryptu Megiteam"
  task :restart, :role => :app do
    run "restart-app #{application}"
  end
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
