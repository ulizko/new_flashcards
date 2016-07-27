module Dashboard
  class CardsController < BaseController
    before_action :set_card, only: [:destroy, :edit, :update]

    def index
      @cards = current_user.cards.all.order('review_date')
    end

    def new
      @card = Card.new
    end

    def edit
    end

    def create
      @card = current_user.cards.build(card_params)
      if @card.save
        redirect_to cards_path
      else
        render 'new'
      end
    end

    def update
      if @card.update(card_params)
        redirect_to cards_path
      else
        respond_with @card
      end
    end

    def destroy
      @card.destroy
      redirect_to cards_path
    end

    private

    def set_card
      @card = current_user.cards.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date,
                                   :image, :image_cache, :remove_image, :block_id)
    end
  end
end
