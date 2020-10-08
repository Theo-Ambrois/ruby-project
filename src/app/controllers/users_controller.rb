class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :confirm_signed_in
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def list
    #récupère les films qui appartiennent au user
    @movies = Movie.joins(:users).where("users.id = ?", current_user.id)
  end

  def show
    @user = User.find(current_user.id)
  end


  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def return
    @movie = Movie.find(params[:id])

    @movie.quantity += 1
    @movie.update(quantity: @movie.quantity)

    @movie_user = MoviesUser.where("movie_id = ? AND user_id = ?", @movie.id, current_user.id).first
    MoviesUser.delete(movie_id: @movie.id, user_id: current_user.id)

    respond_to do |format|
      format.html { redirect_to list_movie_user_path, notice: 'The movie "' + @movie.title + '" was successfully returned' }
    end
  end

  private

  def confirm_signed_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :name, :firstname)
  end

end

