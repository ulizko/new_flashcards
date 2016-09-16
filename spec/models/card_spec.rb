require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:user) { create(:user) }
  let(:block) { create(:block, user: user) }
  let(:card) { create(:card, user: user, block: block) }

  before do
    travel_to Time.zone.now
  end

  after { travel_back }

  describe '#set_review_date_as_now' do
    it 'setting review date' do
      expect(card.review_date).to eq(Time.zone.now)
    end
  end

  describe '#check_translation' do
    context 'when right translation' do
      context 'and after first review' do
        before { card.check_translation('house') }

        it { expect(card.review_date).to eq(Time.zone.now + 1.day) }
        it { expect(card.quality).to eq(5) }
      end

      context 'and after twice review' do
        before { 2.times { card.check_translation('house') } }

        it { expect(card.review_date).to eq(Time.zone.now + 6.days) }
      end

      context 'and after third review' do
        before { 3.times { card.check_translation('house') } }

        it { expect(card.review_date).to eq(Time.zone.now + 16.days) }
      end

      context 'and after fifth review' do
        before { 5.times { card.check_translation('house') } }

        it { expect(card.review_date).to eq(Time.zone.now + 131.days) }
      end
    end

    context 'when wrong translation' do
      context 'and after first review' do
        before { card.check_translation('haus') }

        it { expect(card.review_date).to eq(Time.zone.now) }
      end

      context 'and after twice correct answer and next wrong answer' do
        before do
          2.times { card.check_translation('house') }
          card.check_translation('haus')
        end

        it { expect(card.review_date).to eq(Time.zone.now + 6.days) }
      end
    end
  end
end
