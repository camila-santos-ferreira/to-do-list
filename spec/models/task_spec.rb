require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:name) }

  describe '#pending?' do
    let!(:task) { create(:task) }

    context 'when the task status is pending' do
      it 'returns true' do
        expect(task.pending?).to be(true)
      end
    end

    context 'when the task status is not pending' do
      before do
        task.update_column(:status, :done)
      end

      it 'returns false' do
        expect(task.pending?).to be(false)
      end
    end
  end

  describe '#done?' do
    let!(:task) { create(:task, :done) }

    context 'when the task status is done' do
      it 'returns true' do
        expect(task.done?).to be(true)
      end
    end

    context 'when the task status is not done' do
      before do
        task.update_column(:status, :pending)
      end

      it 'returns false' do
        expect(task.done?).to be(false)
      end
    end
  end
end
