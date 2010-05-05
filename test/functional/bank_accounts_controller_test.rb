require 'test_helper'

class BankAccountsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_account" do
    assert_difference('BankAccount.count') do
      post :create, :bank_account => { }
    end

    assert_redirected_to bank_account_path(assigns(:bank_account))
  end

  test "should show bank_account" do
    get :show, :id => bank_accounts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bank_accounts(:one).to_param
    assert_response :success
  end

  test "should update bank_account" do
    put :update, :id => bank_accounts(:one).to_param, :bank_account => { }
    assert_redirected_to bank_account_path(assigns(:bank_account))
  end

  test "should destroy bank_account" do
    assert_difference('BankAccount.count', -1) do
      delete :destroy, :id => bank_accounts(:one).to_param
    end

    assert_redirected_to bank_accounts_path
  end
end
