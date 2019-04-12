class AdminItemaliasController < ApplicationController
  before_filter :authorize
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @item_alias_pages, @item_aliases = paginate :item_aliases, :per_page => 10
  end

  def show
    @item_alias = ItemAlias.find(params[:id])
  end

  def new
    @item_alias = ItemAlias.new
  end

  def create
    @item_alias = ItemAlias.new(params[:item_alias])
    if @item_alias.save
      flash[:notice] = 'ItemAlias was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @item_alias = ItemAlias.find(params[:id])
  end

  def update
    @item_alias = ItemAlias.find(params[:id])
    if @item_alias.update_attributes(params[:item_alias])
      flash[:notice] = 'ItemAlias was successfully updated.'
      redirect_to :action => 'show', :id => @item_alias
    else
      render :action => 'edit'
    end
  end

  def destroy
    ItemAlias.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
