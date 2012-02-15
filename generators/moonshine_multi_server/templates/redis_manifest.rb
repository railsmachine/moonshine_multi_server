require "#{File.dirname(__FILE__)}/base_manifest.rb"
class RedisManifest < BaseManifest
  recipe :non_rails_recipes

  configure :iptables => build_redis_iptables_configuration
  recipe :iptables

  configure(:sysctl => {:'vm.overcommit_memory' => 1})
  recipe :sysctl

  configure :redis => build_redis_configuration
  recipe :redis
end
