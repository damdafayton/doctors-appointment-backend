require 'test_helper'

class V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get v1_users_create_url
    assert_response :success
  end

  test 'should get update' do
    get v1_users_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get v1_users_destroy_url
    assert_response :success
  end
end
