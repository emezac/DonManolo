class WmsystemController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @wmsystem_pages, @wmsystems = paginate :wmsystems, :per_page => 10
  end

  def show
    @wmsystem = Wmsystem.find(params[:id])
  end

  def new
    @wmsystem = Wmsystem.new
  end

  def create
    @wmsystem = Wmsystem.new(params[:wmsystem])
    if @wmsystem.save
      flash[:notice] = 'Wmsystem was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @wmsystem = Wmsystem.find(params[:id])
  end

  def update
    @wmsystem = Wmsystem.find(params[:id])
    if @wmsystem.update_attributes(params[:wmsystem])
      flash[:notice] = 'Wmsystem was successfully updated.'
      redirect_to :action => 'show', :id => @wmsystem
    else
      render :action => 'edit'
    end
  end

  def destroy
    Wmsystem.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
