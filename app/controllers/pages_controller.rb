class PagesController < ApplicationController

  def farmer
   @user_rice = current_user.rices
  end

  def buyer
    @rice = Rice.all
  end

  def admin
    @rice = Rice.includes(:user, :ratings).all
  end
end
