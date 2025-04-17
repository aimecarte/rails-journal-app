class CategoriesController < AuthenticatedController
  before_action :set_category_id, except: [ :index, :create ]

  rescue_from ActiveRecord::RecordNotFound, with: :no_record_found
  def index
    @categories = current_user.categories
    @category = Category.new

    @today = current_user.tasks.where(due_date: Date.current)
  end

  def show
    @tasks = @category.tasks
    @task = @category.tasks.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to @category, notice: "Category #{@category.name} saved successfully."
    else
      flash.alert = "Failed to save category."
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_path, notice: "Category deleted successfully"
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category_id
    @category = current_user.categories.find(params[:id])
  end

  def no_record_found
    redirect_to categories_path, alert: "No category found"
  end
end
