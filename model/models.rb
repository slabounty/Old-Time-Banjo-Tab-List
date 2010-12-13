# models/models.rb
require 'rubygems'
require 'sequel'

class Author < Sequel::Model
    many_to_many :books
end

class Book < Sequel::Model
end
class Tune < Sequel::Model
end
class Tuning < Sequel::Model
end

class Book < Sequel::Model
    many_to_many :authors
    one_to_many :book_tune_tunings
    many_to_many :tunes, :join_table=>:books_tunes_tunings
    many_to_many :tunings, :join_table=>:books_tunes_tunings
end
class Tune < Sequel::Model
    one_to_many :book_tune_tunings
    many_to_many :books, :join_table=>:books_tunes_tunings
    many_to_many :tunings, :join_table=>:books_tunes_tunings
end
class Tuning < Sequel::Model
    one_to_many :book_tune_tunings
    many_to_many :books, :join_table=>:books_tunes_tunings
    many_to_many :tunes, :join_table=>:books_tunes_tunings
end

class BookTuneTuning < Sequel::Model(:books_tunes_tunings)
 many_to_one :book
 many_to_one :tune
 many_to_one :tuning
end
