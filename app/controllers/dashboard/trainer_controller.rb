class Dashboard::TrainerController < Dashboard::BaseController
  before_filter :find_card, only: [:review_card]

  def index
    block = current_user.current_block
    @card = if block
              block.cards.pending.first || block.cards.repeating.first
            else
              current_user.cards.pending.first || current_user.cards.repeating.first
            end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def review_card
    check_result = @card.check_translation(user_translation)
    if check_result[:state] && check_result[:distance] == 0
      flash[:notice] = t(:correct_translation_notice)
    elsif check_result[:state]
      flash[:alert] = t 'translation_from_misprint_alert',
                        user_translation: user_translation,
                        original_text: @card.original_text,
                        translated_text: @card.translated_text
    else
      flash[:alert] = t(:incorrect_translation_alert)
    end
    redirect_to trainer_path
  end

  private

  def user_translation
    params[:user_translation]
  end

  def find_card
    @card = Card.find(params[:card_id])
  end
end
