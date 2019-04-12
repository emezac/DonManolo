# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # Pick a unique cookie name to distinguish our session data from others'

  session :session_key => '_donmanolo_session_id'
  filter_parameter_logging :password

  private

  def authorize
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in"
      redirect_to(:controller => "login", :action => "login")
    end
  end

  def ensure_admin
    if ['list_users','add_user','delete_user','assign_user','update_user', 'edit_user', 'items_sold','items_sold_bydate','items_sold_bydate_calc','items_sold_byitem','items_sold_byitem_calc','allsales','inventoryv','edit','destroy','new'].include?(action_name)
      render :text=>("Admin priviledge required") unless session[:user_id].admin?
    end
  end


end
