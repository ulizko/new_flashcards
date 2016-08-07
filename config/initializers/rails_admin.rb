RailsAdmin.config do |config|
  ## == Pundit ==
  config.authorize_with :pundit

  # config.authenticate_with do
  #   redirect_to main_app.root_path, error: 'You are not authorized to perform this action.' unless current_user.is_admin?
  # end
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
    list do
      exclude_fields :created_at, :updated_at
      field :user do
        pretty_value do
          value.email
        end
      end
    end
  end
  config.model 'Block' do
    label I18n.t('block')
  end
  config.model 'Role' do
    label I18n.t('role')
    list do
      field :user do
        pretty_value do
          value.email
        end
      end
    end
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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
