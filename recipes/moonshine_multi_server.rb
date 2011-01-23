namespace :moonshine do
  desc 'Apply the Moonshine manifest for this application'
  task :apply do
    apply_db_manifest
    apply_app_manifest
    apply_web_manifest
  end
end

task :apply_db_manifest, :roles => [:db] do
  sudo "RAILS_ROOT=#{latest_release} DEPLOY_STAGE=#{fetch(:stage, "production")} RAILS_ENV=#{fetch(:rails_env, "production")} shadow_puppet #{latest_release}/app/manifests/database_manifest.rb"
end

task :apply_app_manifest, :roles => [:app] do
  sudo "RAILS_ROOT=#{latest_release} DEPLOY_STAGE=#{fetch(:stage, "production")} RAILS_ENV=#{fetch(:rails_env, "production")} shadow_puppet #{latest_release}/app/manifests/application_manifest.rb"
end

task :apply_web_manifest, :roles => [:web] do
  sudo "RAILS_ROOT=#{latest_release} DEPLOY_STAGE=#{fetch(:stage, "production")} RAILS_ENV=#{fetch(:rails_env, "production")} shadow_puppet #{latest_release}/app/manifests/web_manifest.rb"
end
