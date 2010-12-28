# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class MainController < Controller

    # The index action is called automatically when no other action is specified.
    def index
        @title = "Welcome to Banjo Tab!"
        @books = Book.select.order(:title).all
    end

    def view_book(book_id)
        @title = "View Book!"
        @book = Book[book_id]
    end

    def view_tunes
        @title = "View Tunes!"
        @tunes = Tune.select.order(:title).all
    end

    def view_tune(tune_id)
        @title = "View Tune!"
        @tune = Tune[tune_id]
    end

    def view_authors
        @title = "View Authors!"
        @authors = Author.select.order(:last_name).all
    end

    def view_author(author_id)
        @title = "View Author!"
        @author = Author[author_id]
    end

    def view_tunings
        @title = "View Tunings!"
        @tunings = Tuning.select.order(:tuning).all
    end

    def view_tuning(tuning_id)
        @title = "View Tuning!"
        @tuning = Tuning[tuning_id]
    end

end
