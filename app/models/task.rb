class Task < ApplicationRecord
  validates :name, presence: true

  def pending?
    status == 'pending'
  end

  def done?
    status == 'done'
  end

  def done!
    self.update!(status: 'done')
  end
end
