RailsAdmin.config do |config|
  ## == Pundit ==
  # config.authorize_with :pundit

  config.authenticate_with do
    redirect_to main_app.root_path unless current_user.is_admin?
  end
  config.current_user_method(&:current_user)
  config.model 'Authentication' do
    visible false
  end
  config.model 'User' do
    label I18n.t('user')
    list do
      field :email
      field :locale
      field :cards
    end
  end
  config.model 'Card' do
    label I18n.t('card')
  end
  config.model 'Block' do
    label I18n.t('block')
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
