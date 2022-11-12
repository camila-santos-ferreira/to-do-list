class TasksPresenter
  def initialize(tasks:, status:)
    @tasks = tasks
    @status = status
  end

  def map_tasks_data
    {
      tasks: filtered_tasks,
      pending_tasks: count_pending_tasks,
      done_tasks: count_done_tasks,
      total_tasks: @tasks.count
    }
  end

  private

  def filtered_tasks
    return @tasks unless @status.present?

    @tasks.select { |task| task.status == @status }
  end

  def count_pending_tasks
    @tasks.count(&:pending?)
  end

  def count_done_tasks
    @tasks.count(&:done?)
  end
end
