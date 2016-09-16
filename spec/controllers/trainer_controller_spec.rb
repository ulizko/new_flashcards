require 'rails_helper'
require 'support/helpers/trainer_helper.rb'

include TrainerHelper

module Dashboard
  RSpec.describe TrainerController, type: :controller do

    describe 'review_card' do
      let!(:user) { create(:user) }
      let!(:block) { create(:block, user: user) }
      let!(:card) { create(:card, user: user, block: block) }
      before(:each) { @controller.send(:auto_login, user) }

      context 'when correct translation' do
        let(:right) { I18n.t(:correct_translation_notice) }

        it "returned message about correct answer" do
          allow(card).to receive(:check_translation).and_return(state: true, distance: 0)
          put :review_card, params: { card_id: card.id, user_translation: card.translated_text }
          expect(flash[:notice]).to eq(right)
        end
      end

      context 'when did typo, but translation is correct' do
        let(:typo) do I18n.t('translation_from_misprint_alert', user_translation: 'houce',
                              original_text: card.original_text, translated_text: card.translated_text)
        end
        it "returned message with typo" do
          allow(card).to receive(:check_translation).and_return(state: true, distance: 1)
          put :review_card, params: { card_id: card.id, user_translation: 'houce' }
          expect(flash[:alert]).to eq(typo)
        end
      end

      context 'when translation is not correct' do
        let(:wrong) { I18n.t(:incorrect_translation_alert) }
        it "returned message about wrong answer" do
          allow(card).to receive(:check_translation).and_return(state: false)
          put :review_card, params: { card_id: card.id, user_translation: 'hauces' }
          expect(flash[:alert]).to eq(wrong)
        end
      end
    end
  end
end
