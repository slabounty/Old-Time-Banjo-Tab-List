require 'csv'
require 'sequel'

require './model/init'

source_file = ARGV[0]
tunes_file  = ARGV[1]

puts "sources = #{source_file} tunes = #{tunes_file}"
all_books = {}
CSV.foreach(source_file, :headers => true) do |book_csv|
    puts "Title: #{book_csv["Title"]} Author: #{book_csv["Author_Fname"]} #{book_csv["Author_Surname"]}"
    title = book_csv["Title"]
    date = book_csv["Date"]
    isbn = book_csv["Intl. Std. Book No."]
    publisher = book_csv["Publisher"]
    address = book_csv["Address"]
    citation = book_csv["Citation"]
    book = Book.find_or_create(:title => title, :date => date, :isbn => isbn, :publisher => publisher, :address => address, :citation => citation)
    all_books[citation] = book

    first_name = book_csv["Author_Fname"]
    last_name = book_csv["Author_Surname"]
    book.add_author(Author.find_or_create(:first_name => first_name, :last_name => last_name))
end

all_books.each do |b|
    puts "b = #{b}"
end

CSV.foreach(tunes_file, :headers => true) do |tune_csv|
    book_id = tune_csv["Book ID"]
    citation = tune_csv["Citation"]
    page = tune_csv["Page"]
    tuning_string = tune_csv["Tuning"]
    title = tune_csv["Title"]
    book = all_books[citation]

    puts "citation = #{citation} tune = #{title} tuning = #{tuning_string}"

    if book
        tune = Tune.find_or_create(:title => title)
        tuning = Tuning.find_or_create(:tuning => tuning_string)

        all_books[citation].add_book_tune_tuning(:tune => tune, :tuning => tuning, :page => page)
    else
        puts "Could not find book with ID: #{book_id} title: #{title} citation: #{citation}"
    end
end
