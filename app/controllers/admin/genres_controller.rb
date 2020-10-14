class Admin::GenresController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).per(10)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice]="新たなジャンルを作成しました。"
      redirect_to request.referer
    else
      @genres=Genre.all
      flash.now[:error]="入力内容に誤りがあります。"
      render 'index'
    end
  end

  def edit
    @genre=Genre.find(params[:id])
  end

  def update
    @genre=Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice]="ジャンルを編集しました。"
      redirect_to admin_genres_path
    else
      flash.now[:error]="入力内容に誤りがあります。"
      render :edit
  end
end
  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end
end
