class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @latest_chronotype = @user.user_chronotypes.order(created_at: :desc).first
  end
end
