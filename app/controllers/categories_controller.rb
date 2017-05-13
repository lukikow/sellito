class CategoriesController < ApplicationController
  before_action :fetch_category, only: %i[show edit update destroy]

  def index
    new
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    ## rzuca wyjatkiem, mozna podgladnac parametry
    # raise params.to_yaml

    #przypisanie do zmiennej aby mozna bylo operowac/sprawdzac dane
    @category = Category.create(category_params)
    @category.valid? ? create_category : handle_category_validation_failed
  end

  def show; end

  def edit; end

  def update
    @category.update_attributes(category_params)
    redirect_to @category
    # if @category.save
    #   flash[:notice] = 'Category updated.'
    #   redirect_to category_path(@category)
    # else
    #   flash[:alert] = @category.errors.full_messages
    #   redirect_to categories_path
    # end
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

  def create_category
    @category.save
    flash[:notice] = 'Category created.'
    # redirect_to category_path(@category) #przeniesienie do nowo utoworzonej kategorii, moza napisac tak: redirect_to @category
    redirect_to categories_path
  end

  def handle_category_validation_failed
    flash[:alert] = @category.errors.full_messages
    redirect_back(fallback_location: root_path)
  end
end
