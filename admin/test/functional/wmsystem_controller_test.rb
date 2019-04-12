require File.dirname(__FILE__) + '/../test_helper'
require 'wmsystem_controller'

# Re-raise errors caught by the controller.
class WmsystemController; def rescue_action(e) raise e end; end

class WmsystemControllerTest < Test::Unit::TestCase
  fixtures :wmsystems

  def setup
    @controller = WmsystemController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = wmsystems(:first).id
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

    assert_not_nil assigns(:wmsystems)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:wmsystem)
    assert assigns(:wmsystem).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:wmsystem)
  end

  def test_create
    num_wmsystems = Wmsystem.count

    post :create, :wmsystem => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_wmsystems + 1, Wmsystem.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:wmsystem)
    assert assigns(:wmsystem).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Wmsystem.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Wmsystem.find(@first_id)
    }
  end
end
