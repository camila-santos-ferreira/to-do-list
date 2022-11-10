class TasksPresenter
  def initialize(tasks:)
    @tasks = tasks
  end

  def map_tasks_data
    {
      tasks: @tasks,
      pending_tasks: count_pending_tasks,
      done_tasks: count_done_tasks,
      total_tasks: @tasks.count
    }
  end

  private

  def count_pending_tasks
    @tasks.count(&:pending?)
  end

  def count_done_tasks
    @tasks.count(&:done?)
  end
end
