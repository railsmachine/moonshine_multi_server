require "#{File.dirname(__FILE__)}/../../vendor/plugins/moonshine/lib/moonshine.rb"
require "#{File.dirname(__FILE__)}/lib/configuration_builders.rb"

class BaseManifest < Moonshine::Manifest::Rails

  include Moonshine::MultiServer
  include ConfigurationBuilders


  def application_packages
  end
end
