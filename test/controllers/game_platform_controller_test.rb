require "test_helper"

class GamePlatformControllerTest < ActionDispatch::IntegrationTest
  test "should get game:references" do
    get game_platform_game:references_url
    assert_response :success
  end

  test "should get platform:references" do
    get game_platform_platform:references_url
    assert_response :success
  end
end
