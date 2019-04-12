class AccountController < ApplicationController
  gal_scaffold :user,:columns=>'login first_name last_name',:admin_only=>true
  before_filter { |controller| controller.ensure_admin unless controller.session[:user].nil? || controller.params[:id].to_i == controller.session[:user].id.to_i }

  def login
    case request.method
      when :post
        if session[:user] = User.authenticate(params[:user_login], params[:user_password])
          language=session[:user].language
          language= :default if language.nil? or language == 'en_EN'
          Localization.lang = language
          flash[:notice]  = _'Welcome, %s',session[:user].login
          redirect_back_or_default '/home'
        else
          flash.now[:notice]  = _'Login failed'
          @login = params[:user_login]
        end
    end
  end
  
  def signup
    @user = User.new(params[:user])

    if request.post? and @user.save
      session[:user] = User.authenticate(@user.login, params[:user][:password])
      flash[:notice]  = _"New user %s signup",@user.login
      redirect_to '/home'
    end
  end
  
  def logout
    reset_session
    flash[:notice] =  _'Logout done'
    redirect_to "/"
    
  end
    
  def welcome
  end
  
  private
  
  def load_deps
    @user.password=''
  end
  
end
