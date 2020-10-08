class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :category_list, only: [:new, :edit, :show]
  before_action :authenticate_user!

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    if current_user.has_role? :admin 
      respond_to do |format|
        if @movie.update(movie_params)
          format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
          format.json { render :show, status: :ok, location: @movie }
        else
          format.html { render :edit }
          format.json { render json: @movie.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back
    end 
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def borrow
    @movie = Movie.find(params[:id])
    @userMovie = Movie.joins(:users).where("users.id = ? AND movie_id = ?", current_user.id, @movie.id)

    if @movie.quantity > 0
      if @userMovie.empty?
        @movie.quantity -= 1
        
        @movie.update(quantity: @movie.quantity)
        @movie_user = MoviesUser.create(movie_id: @movie.id, user_id: current_user.id)
        @movie_user.save

        respond_to do |format|
          format.html { redirect_to movies_path, notice: 'The movie "' + @movie.title + '" was successfully borrowed' }
        end
      else
        respond_to do |format|
          format.html { redirect_to movies_path, notice: 'You already have the movie "' + @movie.title + '" in your list' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to movies_path, notice: 'There is no more copy of the movie "' + @movie.title + '"' }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :description, :duree, :quantity, category_ids: [])
    end

    def category_list
      @categories = Category.all
    end
end
