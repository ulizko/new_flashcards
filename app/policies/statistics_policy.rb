class StatisticsPolicy < Struct.new(:user, :statistics)
  def index?
    user.is_admin?
  end
end
