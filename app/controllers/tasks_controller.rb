class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy done]

  def index
    tasks = Task.all.order(:created_at)
    @mapped_tasks = TasksPresenter.new(tasks: tasks, status: status).map_tasks_data
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save!
    redirect_to root_path, notice: 'Tarefa criada'
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
    redirect_to root_path, alert: 'Tarefa já está feita' if @task.done?
  end

  def update
    @task.update!(task_params)
    redirect_to task_path(@task.id), notice: 'Tarefa atualizada'
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'Tarefa excluída'
  end

  def done
    return unless @task.pending?

    @task.done!
    redirect_to root_path, notice: 'Tarefa feita'
  rescue StandardError
    render :index, alert: 'Ocorreu um erro inesperado'
  end

  private

  def find_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Tarefa não encontrada'
  end

  def task_params
    params.require(:task).permit(:name)
  end

  def permitted_params
    params.permit(:status)
  end

  def status
    permitted_params[:status]
  end
end
