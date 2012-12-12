require "#{File.dirname(__FILE__)}/base_manifest.rb"
class AppManifest < BaseManifest
  recipe :standalone_application_stack

  recipe :application_packages
  recipe :cronjobs

<% if sphinx? %>
  configure :sphinx => build_sphinx_client_configuration
  recipe :sphinx_config_only
<% end %>

  def cronjobs
  end
end
