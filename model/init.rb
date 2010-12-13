# Here goes your database connection and options:
require 'rubygems'
require 'sequel'

# Open database. This must be done before we access the models
# that use it.
Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://banjotab.sqlite')

# Here go your requires for models:
# require_relative 'models'
require './model/models'
