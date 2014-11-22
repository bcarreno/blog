require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  setup do
    @controller = ApplicationController.new
  end

  test "should return full path" do
    assert_equal File.join(PRIVATE_ASSETS_PATH, 'test'), @controller.instance_eval{ full_private_filename('test') }
  end

  test "should raise exception when trying to break outside of private asset path" do
    assert_raises(ActionController::MissingFile) do
      @controller.instance_eval { full_private_filename('../test') }
    end
  end
end
