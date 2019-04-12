require File.dirname(__FILE__) + '/../test_helper'
require 'admin_itemalias_controller'

# Re-raise errors caught by the controller.
class AdminItemaliasController; def rescue_action(e) raise e end; end

class AdminItemaliasControllerTest < Test::Unit::TestCase
  fixtures :item_aliases

  def setup
    @controller = AdminItemaliasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = item_aliases(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:item_aliases)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:item_alias)
    assert assigns(:item_alias).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:item_alias)
  end

  def test_create
    num_item_aliases = ItemAlias.count

    post :create, :item_alias => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_item_aliases + 1, ItemAlias.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:item_alias)
    assert assigns(:item_alias).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      ItemAlias.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ItemAlias.find(@first_id)
    }
  end
end
