class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
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

  def edit; end

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
