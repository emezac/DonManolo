require File.dirname(__FILE__) + '/../test_helper'
require 'admin_provider_controller'

# Re-raise errors caught by the controller.
class AdminProviderController; def rescue_action(e) raise e end; end

class AdminProviderControllerTest < Test::Unit::TestCase
  fixtures :providers

  def setup
    @controller = AdminProviderController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = providers(:first).id
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

    assert_not_nil assigns(:providers)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:provider)
    assert assigns(:provider).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:provider)
  end

  def test_create
    num_providers = Provider.count

    post :create, :provider => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_providers + 1, Provider.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:provider)
    assert assigns(:provider).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Provider.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Provider.find(@first_id)
    }
  end
end
