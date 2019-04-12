class AdminProviderController < ApplicationController
  before_filter :authorize
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @provider_pages, @providers = paginate :providers, :per_page => 10
  end

  def show
    @provider = Provider.find(params[:id])
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(params[:provider])
    if @provider.save
      flash[:notice] = 'Provider was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @provider = Provider.find(params[:id])
  end

  def update
    @provider = Provider.find(params[:id])
    if @provider.update_attributes(params[:provider])
      flash[:notice] = 'Provider was successfully updated.'
      redirect_to :action => 'show', :id => @provider
    else
      render :action => 'edit'
    end
  end

  def destroy
    Provider.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
