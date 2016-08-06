class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    @user.is_admin?
  end

  def new?
    create?
  end

  def update?
    @user.is_admin?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def owner?
    @user.id == @record.user_id
  end

  def method_missing(method_name)
    raise super unless actions.include? method_name[0..-2].to_sym
    @user.is_admin?
  end

  def respond_to_missing?(method_name)
    actions.include? method_name[0..-2].to_sym || super
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def actions
    RailsAdmin::Config::Actions.all.map(&:action_name)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_admin?
        scope.all
      else
        scope.where(user_id: user)
      end
    end
  end
end
