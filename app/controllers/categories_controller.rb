class CategoriesController < ApplicationController
  before_action :fetch_category, only: [:show, :edit, :update, :destroy]

  def index
    new
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
      # redirect_to category_path(@category) #przeniesienie do nowo utoworzonej kategorii, moza napisac tak: redirect_to @category
      redirect_to categories_path
    else
      flash[:alert] = 'Could not create category!'
      redirect_back(fallback_location: root_path)
    end

    ##po utworzeniu kategorii przekieruje do strony glownej
    #redirect_to root_path
  end

  def show; end

  def edit; end

  def update
    @category.update_attributes(category_params)
    if @category.save
      flash[:notice] = 'Category updated.'
      redirect_to category_path(@category)
    else
      flash[:alert] = 'Category NOT updated.'
      redirect_to categories_path
    end
  end

  def destroy
    @category.destroy!
    flash[:notice] = "Category #{@category.name} deleted."
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end


  def fetch_category
    @category = Category.find(params[:id])
  end
end
