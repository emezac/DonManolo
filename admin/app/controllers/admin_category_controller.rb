class AdminCategoryController < ApplicationController

  before_filter :authorize
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @category_pages, @categories = paginate :categories, :per_page => 6
  end

  def show
    @category = Category.find(params[:id])
    @items = Item.find(:all, :conditions => ["category_id = ?", params[:id]])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def edit_item
    @item = Item.find(params[:id])
  end


  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category was successfully updated.'
      redirect_to :action => 'show', :id => @category
    else
      render :action => 'edit'
    end
  end

  def update_item
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item was successfully updated.'
      redirect_to :action => 'show', :id => @item.category_id
    else
      render :action => 'edit_item'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def do_search
    @phr = params[:searchtext]
    a1 = "%"
    a2 = "%"
    @searchphrase = a1 + @phr + a2
    @categories = Category.search(@searchphrase)
    @number_match = @categories.length
  end

end
