class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy done]

  def index
    tasks = Task.all.order(:created_at)
    @mapped_tasks = TasksPresenter.new(tasks: tasks).map_tasks_data
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save!
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
    redirect_to root_path if @task.done?
  end

  def update
    @task.update!(task_params)
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def destroy
    @task.destroy
    redirect_to root_path
  end

  private

  def find_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def task_params
    params.require(:task).permit(:name)
  end
end
