require "test_helper"

class GameGenreControllerTest < ActionDispatch::IntegrationTest
  test "should get game:references" do
    get game_genre_game:references_url
    assert_response :success
  end

  test "should get genre:references" do
    get game_genre_genre:references_url
    assert_response :success
  end
end
