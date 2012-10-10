require "#{File.dirname(__FILE__)}/../../vendor/plugins/moonshine/lib/moonshine.rb"
require "#{File.dirname(__FILE__)}/lib/configuration_builders.rb"

class BaseManifest < Moonshine::Manifest::Rails

  include Moonshine::MultiServer
  include ConfigurationBuilders

  on_stage :production do
    recipe :scout
    recipe :scout_dependencies
  end

  recipe :ssh
  recipe :denyhosts

  def application_packages
  end

  def scout_dependencies
  end
end
