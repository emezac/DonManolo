class LoginController < ApplicationController

  before_filter :authorize, :ensure_admin,  :except => :login
  
  def index
    logger.info 'informational message'
  end
  
  def show
    @user = User.find(params[:id])
    @uemployees  = Uemployee.find(:all, :conditions => ["id = ? ", params[:id]])
  end

  # just display the form and wait for user to
  # enter a name and password
  
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = User.authenticate(params[:name], params[:password])
        flash[:notice]  = 'Welcome, %s',session[:user_id].name
        redirect_to(:action => "index")
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end
  
  def add_user
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash.now[:notice] = "User #{@user.name} created"
      @user = User.new
      redirect_to :action => 'list_users'
    end
  end

  def delete_user
    if request.post?
      user = User.find(params[:id])
      begin
        user.destroy
        if Uemployee.find(:first, :conditions => ["id = ?", params[:id]])
           Uemployee.find(:first, :conditions => ["id = ?", params[:id]]).destroy
        end
        flash[:notice] = "User #{user.name} deleted"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_users)
  end
  
  def assign_user
    @total_sales = Historicsale.count
  end

  def assign_user_exec
      @employee = params[:employee][:employee_id]
      @user   =   params[:user][:user_id]
      @relat = Uemployee.new
      @relat.id = @user
      @relat.employee_id = @employee
      @relat.save
      redirect_to(:action => "list_users")
  end

  def list_users
    @user_pages, @users = paginate :users, :per_page => 10
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def update_user
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'list_users', :id => @user
    else
      render :action => 'list_users'
    end
  end

end
