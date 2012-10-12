namespace :moonshine do
  desc 'Apply the Moonshine manifest for this application'
  task :multi_server_apply do
    apply_db_manifest
    apply_memcached_manifest
    apply_redis_manifest
    apply_sphinx_manifest
    apply_app_manifest
    apply_dj_manifest
    apply_web_manifest
  end

  [:memcached, :redis, :sphinx, :app, :dj, :web, :mongodb, :haproxy].each do |role|
    task :"apply_#{role}_manifest", :roles => [role] do
      sudo "RAILS_ROOT=#{latest_release} DEPLOY_STAGE=#{fetch(:stage, "production")} RAILS_ENV=#{fetch(:rails_env, "production")} shadow_puppet #{latest_release}/app/manifests/#{role}_manifest.rb"
    end
  end

  task :apply_db_manifest, :roles => [:db] do
    sudo "RAILS_ROOT=#{latest_release} DEPLOY_STAGE=#{fetch(:stage, "production")} RAILS_ENV=#{fetch(:rails_env, "production")} shadow_puppet #{latest_release}/app/manifests/database_manifest.rb"
  end

end
