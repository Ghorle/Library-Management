json.extract! book, :id, :title, :published_at, :language, :library_id, :author_id, :created_at, :updated_at
json.url book_url(book, format: :json)
