require 'rails_helper'

RSpec.describe TasksPresenter, type: :presenter do
  let(:presenter) { described_class.new(tasks: tasks) }

  let!(:first_task) { create(:task) }
  let!(:second_task) { create(:task) }
  let!(:third_task) { create(:task, :done) }
  let!(:fourth_task) { create(:task, :done) }
  let(:tasks) { [first_task, second_task, third_task, fourth_task] }

  describe '#map_tasks_data' do
    let(:expected_mapped_tasks) do
      {
        tasks: tasks,
        pending_tasks: 2,
        done_tasks: 2,
        total_tasks: 4
      }
    end

    it 'returns the expected mapped tasks' do
      expect(presenter.map_tasks_data).to eq(expected_mapped_tasks)
    end
  end
end
