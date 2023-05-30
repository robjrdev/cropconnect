class NotificationsController < ApplicationController
    def index
        @user = current_user
        @notifications = @user.notifications.all
    end

    def update
        
    end
end
  