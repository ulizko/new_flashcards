RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true
  config.main_app_name = Proc.new {
    ["Flashcarder", "(#{Time.zone.now.to_s(:time)})"]
  }
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
      fields :created_at, :updated_at do          # adding and configuring
        label do
          "#{label} (timestamp)"
        end
      end
    end
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
