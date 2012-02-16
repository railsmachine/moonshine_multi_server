require "#{File.dirname(__FILE__)}/base_manifest.rb"
class AppManifest < BaseManifest
  recipe :standalone_application_stack

  recipe :application_packages
  recipe :cronjobs

  def cronjobs
  end
end
