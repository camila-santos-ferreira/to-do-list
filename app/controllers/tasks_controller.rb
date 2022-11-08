class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  private

  def find_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
