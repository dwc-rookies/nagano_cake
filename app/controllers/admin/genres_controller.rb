class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice]="successfully"
       redirect_to request.referer
    else
      @genres=Genre.all
      redirect_to request.referer
    end
  end

  def edit
  end

  def update

  end

end
