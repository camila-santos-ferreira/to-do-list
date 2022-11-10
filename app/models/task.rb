class Task < ApplicationRecord
  validates :name, presence: true

  def pending?
    status == 'pending'
  end

end
