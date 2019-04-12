require File.dirname(__FILE__) + '/../test_helper'
require 'alias_controller'

# Re-raise errors caught by the controller.
class AliasController; def rescue_action(e) raise e end; end

class AliasControllerTest < Test::Unit::TestCase
  fixtures :aliases

  def setup
    @controller = AliasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = aliases(:first).id
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

    assert_not_nil assigns(:aliases)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:alias)
    assert assigns(:alias).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:alias)
  end

  def test_create
    num_aliases = Alias.count

    post :create, :alias => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_aliases + 1, Alias.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:alias)
    assert assigns(:alias).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Alias.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Alias.find(@first_id)
    }
  end
end
