class Card < ApplicationRecord
  belongs_to :user
  belongs_to :block

  before_validation :set_review_date_as_now, on: [:create]
  validate :texts_are_not_equal
  validates :original_text, :translated_text, :review_date,
            presence: { message: 'Необходимо заполнить поле.' }
  validates :block_id,
            presence: { message: 'Выберите колоду из выпадающего списка.' }

  mount_uploader :image, CardImageUploader

  scope :pending, -> { where('review_date <= ?', Time.now).order('RANDOM()') }
  scope :repeating, -> { where('quality < ?', 4).order('RANDOM()') }

  def check_translation(user_translation)
    distance = Levenshtein.distance(full_downcase(translated_text),
                                    full_downcase(user_translation))
    sm_hash = SuperMemo.algorithm(interval, repeat, efactor, attempt, distance)
    state = if distance <= SuperMemo::DISTANCE_LIMIT
              sm_hash[:review_date] = Time.now + interval.days
              sm_hash[:attempt] = 1
              true
            else
              sm_hash[:attempt] = [attempt + 1, 5].min
              false
            end
    update_attributes(sm_hash)
    { state: state, distance: distance }
  end

  def self.pending_cards_notification
    users = User.where.not(email: nil)
    users.each do |user|
      if user.cards.pending
        CardsMailer.pending_cards_notification(user.email).deliver_now
      end
    end
  end

  protected

  def set_review_date_as_now
    self.review_date = Time.now
  end

  def texts_are_not_equal
    if full_downcase(original_text) == full_downcase(translated_text)
      errors.add(:original_text, 'Вводимые значения должны отличаться.')
    end
  end

  def full_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').strip
  end
end
