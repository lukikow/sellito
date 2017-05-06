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

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
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
    @category = Category.find(params[:id])
    @category.destroy!
    if @category.save
      flash[:notice] = "Category #{@category.name} deleted."
      redirect_to categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
