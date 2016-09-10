module Dashboard
  class FillController < ApplicationController
    def index
      @cards = policy_scope(Card).recent
    end

    def add
    end

    def scrap
      FillJob.perform_later(current_user, fill_params)
      flash[:notice] = t('.job_started')
      redirect_to recent_path
    end

    def fill_params
      params.require(:fill).permit(:url, :original_text_selector, :translated_text_selector).to_h.symbolize_keys
    end
  end
end
