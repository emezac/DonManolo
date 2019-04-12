require File.dirname(__FILE__) + '/../test_helper'
require 'item_alias_controller'

# Re-raise errors caught by the controller.
class ItemAliasController; def rescue_action(e) raise e end; end

class ItemAliasControllerTest < Test::Unit::TestCase
  def setup
    @controller = ItemAliasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
