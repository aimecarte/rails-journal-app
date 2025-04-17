class TasksController < AuthenticatedController
  before_action :set_category_id
  before_action :set_task_id, except: :create

  rescue_from ActiveRecord::RecordNotFound, with: :no_record_found
  def create
    @task = @category.tasks.new(task_params)
    if @task.save
      redirect_to category_path(@category), notice: "Task added successfully"
    else
      @tasks = @category.tasks
      flash.alert = "Failed to create a new task"
      render "categories/show", status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to @category, notice: "Task updated successfully"
    else
      flash.alert = "Failed to update the task"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to @category, notice: "Task deleted successfully"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :completed)
  end

  def set_category_id
    @category = current_user.categories.find(params[:category_id])
  end

  def set_task_id
    @task = @category.tasks.find(params[:id])
  end

  def no_record_found
    redirect_to categories_path, alert: "No task found"
  end
end
