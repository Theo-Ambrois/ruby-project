module MoviesHelper
  def movie_categories_label(categories)
    raw categories.map  {|cat| "<span style='color:#{cat.color}'>#{cat.name}</span>" } .join(', ')
  end
end
