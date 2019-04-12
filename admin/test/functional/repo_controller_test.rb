require File.dirname(__FILE__) + '/../test_helper'
require 'repo_controller'

# Re-raise errors caught by the controller.
class RepoController; def rescue_action(e) raise e end; end

class RepoControllerTest < Test::Unit::TestCase
  fixtures :historicsales

  def setup
    @controller = RepoController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = historicsales(:first).id
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

    assert_not_nil assigns(:historicsales)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:historicsale)
    assert assigns(:historicsale).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:historicsale)
  end

  def test_create
    num_historicsales = Historicsale.count

    post :create, :historicsale => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_historicsales + 1, Historicsale.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:historicsale)
    assert assigns(:historicsale).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Historicsale.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Historicsale.find(@first_id)
    }
  end
end
