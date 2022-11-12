require 'rails_helper'

RSpec.describe TasksPresenter, type: :presenter do
  let(:presenter) { described_class.new(tasks: tasks, status: status) }

  let!(:first_task) { create(:task) }
  let!(:second_task) { create(:task) }
  let!(:third_task) { create(:task, :done) }
  let!(:fourth_task) { create(:task, :done) }
  let(:tasks) { [first_task, second_task, third_task, fourth_task] }

  describe '#map_tasks_data' do
    context 'when status is nil' do
      let(:status) { nil }
      let(:expected_mapped_tasks) do
        {
          tasks: tasks,
          pending_tasks: 2,
          done_tasks: 2,
          total_tasks: 4
        }
      end

      it 'returns all tasks mapped' do
        expect(presenter.map_tasks_data).to eq(expected_mapped_tasks)
      end
    end

    context 'when status is pending' do
      let(:status) { 'pending' }
      let(:expected_mapped_tasks) do
        {
          tasks: [first_task, second_task],
          pending_tasks: 2,
          done_tasks: 2,
          total_tasks: 4
        }
      end

      it 'returns pending tasks mapped' do
        expect(presenter.map_tasks_data).to eq(expected_mapped_tasks)
      end
    end

    context 'when status is done' do
      let(:status) { 'done' }
      let(:expected_mapped_tasks) do
        {
          tasks: [third_task, fourth_task],
          pending_tasks: 2,
          done_tasks: 2,
          total_tasks: 4
        }
      end

      it 'returns done tasks mapped' do
        expect(presenter.map_tasks_data).to eq(expected_mapped_tasks)
      end
    end
  end
end
