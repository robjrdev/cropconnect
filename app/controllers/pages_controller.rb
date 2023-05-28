class PagesController < ApplicationController

  def farmer
   @user_rice = current_user.rices
  end

  def buyer
    @rice = Rice.all
  end

  def admin
    
  end
end
