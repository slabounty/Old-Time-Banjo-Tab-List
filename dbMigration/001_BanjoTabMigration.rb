# dbMigration/001_BanjoTab.rb
#
# This is the "new" way to do migrations by using the Class.new form. 
# It means that a new class name is not required and so there is no chance
# of creating a second class in the migration files that is the same as the 
# first causing problems.
Class.new(Sequel::Migration) do
    def up
        create_table(:books) do
            primary_key :id
            String :title 
            String :date
            String :publisher
            String :isbn
            String :address
            String :citation
        end

        create_table(:authors) do
            primary_key :id
            String :first_name 
            String :last_name
        end

        create_table(:authors_books) do
            primary_key :id
            foreign_key :author_id, :authors
            foreign_key :book_id, :books
        end

        create_table(:tunes) do
            primary_key :id
            String :title
        end

        create_table(:tunings) do
            primary_key :id
            String :tuning
        end

        create_table(:books_tunes_tunings) do
            primary_key :id
            Integer :page
            foreign_key :book_id, :books
            foreign_key :tuning_id, :tunings
            foreign_key :tune_id, :tunes
        end

    end

    def down
        drop_table(:authors_books, :books, :authors, :books_tunes, :tunes, :books_tunes_tunings)
    end
end
