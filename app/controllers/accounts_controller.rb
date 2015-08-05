class AccountsController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_attributes(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to edit_account_path, notice: 'Cuenta actualizada correctamente.'
    else
      render "edit"
    end
  end

  def connections
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    params[:user][:password].present?
  end
end
