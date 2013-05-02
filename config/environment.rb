# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Snipstock::Application.initialize!

require 'acts-as-taggable-on'
require 'will_paginate'
