class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    ## rzuca wyjatkiem, mozna podgladnac parametry
    #raise params.to_yaml

    #przypisanie do zmiennej aby mozna bylo operowac/sprawdzac dane
    @category = Category.create(category_params)
    if @category.save
      flash[:notice] = 'Category created.'
      redirect_to category_path(@category) #przeniesienie do nowo utoworzonej kategorii, moza napisac tak: redirect_to @category
    else
      flash[:alert] = 'Could not create category!'
      redirect_back(fallback_location: root_path)
    end

    ##po utworzeniu kategorii przekieruje do strony glownej
    #redirect_to root_path
  end

  def show
    @category = Category.find(params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
