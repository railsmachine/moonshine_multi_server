# Moonshine Multi Server

## A plugin for Moonshine[http://github.com/railsmachine/moonshine]

A plugin for deploying one app to multiple servers

## Instructions

* Install the [Moonshine](http://github.com/railsmachine/moonshine)
* Configure servers for capistrano setting the appropriate role(s).  Here is an example `config/deploy.rb`:

<pre>
  server 'web.example.com', :web, :primary => true
  server 'app.example.com', :app, :primary => true
  server 'db.example.com', :db, :primary => true
</pre>

* Install the Moonshine Multi Server plugin:

<pre>
script/plugin install git://github.com/railsmachine/moonshine_multi_server.git
</pre>

* create a manifest for each role:
  * `app/manifests/application_manifest_.rb`
  * `app/manifests/database_manifest_.rb`
  * `app/manifests/web_manifest_.rb`
* Add the stacks you need to each manifest.  Here is an example `app/manifests/application_manifest.rb`:
    
<code><pre>
require "#{File.dirname(__FILE__)}/../../vendor/plugins/moonshine/lib/moonshine.rb"
class ApplicationManifest < Moonshine::Manifest::Rails
  include Moonshine::MultiServer
  recipe :standalone_app_stack
end
</pre></code>

* Add one bit to your capistrano `config/deploy.rb`

<pre>
namespace :moonshine do
  task :apply do
    moonshine.multi_server_apply
  end  
end
</pre>