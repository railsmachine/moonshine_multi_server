require "#{File.dirname(__FILE__)}/base_manifest.rb"

class MongodbManifest < BaseManifest

  recipe :non_rails_recipes

  recipe :mongodb

  configure :iptables => build_mongodb_iptables_configuration
  recipe :iptables

end
