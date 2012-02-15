require "#{File.dirname(__FILE__)}/base_manifest.rb"

class SphinxManifest < BaseManifest
  recipe :rails_recipes
  recipe :sphinx

  configure :iptables => { :rules => build_sphinx_iptables_rules }
  recipe    :iptables

  recipe :sysctl
end
