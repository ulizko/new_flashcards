class Block < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :user

  validates :title, presence: { message: 'Необходимо заполнить поле.' }
  scope :default, -> { find_by(title: 'Default') }

  def current?
    id == user.current_block_id
  end
end
