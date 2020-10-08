json.extract! movie, :id, :title, :description, :duree, :borrowed, :created_at, :updated_at
json.url movie_url(movie, format: :json)
