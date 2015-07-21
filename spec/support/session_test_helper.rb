#
module SessionTestHelpers
  # Command: Creates a user and sets the user_id in session to the user's id
  #
  # @param [Hash]
  # @return [self]
  #
  def log_in(user)
    page.set_rack_session(user_id: user.id)
    user
  end

  def create_current_user(params = {})
    @_current_user = create(:user, params)
    page.set_rack_session(user_id: @_current_user.id)
    @_current_user
  end

  def create_current_admin(params = {})
    @_current_user = create(:admin, params)
    page.set_rack_session(user_id: @_current_user.id)
    @_current_user
  end
end
