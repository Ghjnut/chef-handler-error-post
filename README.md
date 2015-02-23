Description
===========

This is a Chef report handler that posts failures as JSON to a specified 
endpoint.

* http://wiki.opscode.com/display/chef/Exception+and+Report+Handlers

Requirements
============

Only tested on Chef >= 11.0

Usage
=====

There are two ways to use Chef Handlers.

### Method 1 (recommended)

Use the
[chef_handler cookbook by Opscode](http://community.opscode.com/cookbooks/chef_handler).
Create a recipe with the following:

    include_recipe "chef_handler"

    # Install `chef-handler-error-post` gem during the compile phase
    chef_gem "chef-handler-error-post"

    # load the gem here so it gets added to the $LOAD_PATH, otherwise chef_handler
    # will fail.
    require 'chef/handler/error_post'

    # Activate the handler immediately during compile phase
    chef_handler "Chef::Handler::ErrorPost" do
      source "chef/handler/error_post"
      action :nothing
    end.run_action(:enable)


### Method 2

Install the gem ahead of time, and configure Chef to use
them:

    gem install chef-handler-error-post

Then add to the configuration (`/etc/chef/solo.rb` for chef-solo or
`/etc/chef/client.rb` for chef-client):

    require "chef/handler/error_post"
    report_handlers << Chef::Handler::ErrorPost.new
    exception_handlers << Chef::Handler::ErrorPost.new


### Example output

See `report_data.json.failure`

Todo
====

License and Author
==================

Author:: Jake Pelletier <https://github.com/Ghjnut>
