class StoreController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @store_pages, @stores = paginate :stores, :per_page => 10
  end

  def show
    @store = Store.find(params[:id])
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(params[:store])
    if @store.save
      flash[:notice] = 'Store was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(params[:store])
      flash[:notice] = 'Store was successfully updated.'
      redirect_to :action => 'show', :id => @store
    else
      render :action => 'edit'
    end
  end

  def destroy
    Store.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def demogruff
    require 'gruff'
    g = Gruff::Line.new
    g.title = "My Graph"
    g.data("Apples", [1, 2, 3, 4, 4, 3])
    g.data("Oranges", [4, 8, 7, 9, 8, 9])
    g.data("Watermelon", [2, 3, 1, 5, 6, 8])
    g.data("Peaches", [9, 9, 10, 8, 7, 9])
    g.labels = {0 => '2003', 2 => '2004', 4 => '2005'}
    filename = 'my_fruity_graph.png'
    # this writes the file to the hard drive for caching
    # and then writes it to the screen.
    g.write(filename)
    send_file filename, :type => 'image/png', :disposition => 'inline'
  end

end
