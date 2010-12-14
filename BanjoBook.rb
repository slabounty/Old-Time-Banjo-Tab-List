require 'csv'
require 'sequel'

require './model/init'

source_file = ARGV[0]
tunes_file  = ARGV[1]

puts "sources = #{source_file} tunes = #{tunes_file}"
all_books = {}
CSV.foreach(source_file, :headers => true) do |book_csv|
    # puts "Title: #{book_csv["Title"]} Author: #{book_csv["Author_Fname"]} #{book_csv["Author_Surname"]}"
    title = book_csv["Title"]
    date = book_csv["Date"]
    isbn = book_csv["Intl. Std. Book No."]
    publisher = book_csv["Publisher"]
    address = book_csv["Address"]
    citation = book_csv["Citation"]
    book = Book.create(:title => title, :date => date, :isbn => isbn, :publisher => publisher, :address => address, :citation => citation)
    all_books[citation] = book

    first_name = book_csv["Author_Fname"]
    last_name = book_csv["Author_Surname"]
    if author = Author.find(:first_name => first_name, :last_name => last_name)
        book.add_author(author)
    else
        book.add_author(Author.create(:first_name => first_name, :last_name => last_name))
    end
end

CSV.foreach(tunes_file, :headers => true) do |tune_csv|
    book_id = tune_csv["Book ID"]
    citation = tune_csv["Citation"]
    page = tune_csv["Page"]
    tuning_string = tune_csv["Tuning"]
    title = tune_csv["Title"]
    book = all_books[citation]

    if book
        tune = Tune.find(:title => title)
        tune = Tune.create(:title => title)  if !tune

        tuning = Tuning.find(:tuning => tuning_string)
        tuning = Tuning.create(:tuning => tuning_string) if !tuning

        all_books[citation].add_book_tune_tuning(:tune => tune, :tuning => tuning, :page => page)
    else
        puts "Could not find book with ID: #{book_id} title: #{title} citation: #{citation}"
    end
end
