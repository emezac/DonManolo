require File.dirname(__FILE__) + '/../test_helper'
require 'historicsale_controller'

# Re-raise errors caught by the controller.
class HistoricsaleController; def rescue_action(e) raise e end; end

class HistoricsaleControllerTest < Test::Unit::TestCase
  def setup
    @controller = HistoricsaleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
