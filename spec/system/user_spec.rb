require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system, js: true do
  before do
    @user1 = User.create(email: 'user1@sample.com', password: "password", password_confirmation: "password")
    @user2 = User.create(email: 'user2@sample.com', password: "password", password_confirmation: "password")
    @company1 = Company.create(email: 'company1@sample.com', password: "password", password_confirmation: "password")
  end

  describe 'ユーザー登録' do
    context '新規ユーザーのサインアップ' do
      it '登録でき、詳細ページにリダイレクトされること' do
        visit root_path

        click_on 'Sign Up'

        fill_in 'Email', with: 'shunsukE@sample.com'
        fill_in 'Password', with: "password"
        fill_in 'Password confirmation', with: "password"
        click_button 'Sign up'

        expect(page).to have_current_path root_path
        expect(page).to have_content 'successfully'
      end

      it 'ログインして詳細ページにリダイレクトされること' do
        visit new_user_session_path
        fill_in 'Email', with: 'user1@sample.com'
        fill_in 'Password', with: "password"
        click_on "Log in"

        expect(page).to have_current_path root_path
        expect(page).to have_content 'successfully'
      end
    end
  end

  describe '未ログインユーザーのアクセス権限' do
    it '未ログインではユーザーダッシュボードページにアクセスできないこと' do
      visit dashboard_user_path(@user1.id)
      expect(page).to have_current_path new_user_session_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    it '未ログインではユーザーインデックスにアクセスできないこと' do
      visit users_path
      expect(page).to have_current_path new_company_session_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'カンパニーのアクセス権限' do
    before do
      company = Company.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
      login_as(company, :scope => :company)
    end

    it 'ユーザー詳細ページにアクセスできること' do
      visit user_path(@user1.id)
      expect(page).to have_current_path user_path(@user1.id)
    end

    it 'ユーザーインデックスページにアクセスできること' do
      visit users_path
      expect(page).to have_current_path users_path
    end

    it 'ユーザーダッシュボードにアクセスできないこと' do
      visit dashboard_user_path(@user1.id)
      expect(page).to have_current_path new_user_session_path
    end

    it 'ユーザー編集ページにアクセスできないこと' do
      visit edit_user_path(@user1.id)
      expect(page).to have_current_path new_user_session_path
    end
  end

  describe 'ログインユーザーの機能' do
    before do
      user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
      login_as(user, :scope => :user)
      @user = user
    end

    context 'ログアウト機能' do
      it 'ログアウトできる' do
        visit dashboard_user_path(@user)
        click_on "Dropdown"
        click_on "Log-out"
        expect(page).to have_content "Signed out successfully."
        expect(page).to have_current_path root_path
      end
    end

    context 'アクセス権限' do
      it '自分のユーザー詳細ページにアクセスできること' do
        visit user_path(@user.id)
        expect(page).to have_current_path user_path(@user.id)
      end

      it '他ユーザーの詳細ページにアクセスできないこと' do
        visit user_path(@user1.id)
        expect(page).to have_current_path root_path
        expect(page).to have_content "No Access Right."
      end

      it 'ユーザーインデックスページにアクセスできないこと' do
        visit users_path
        expect(page).to have_current_path new_company_session_path
      end

      it '自分のダッシュボードにアクセスできること' do
        visit dashboard_user_path(@user.id)
        expect(page).to have_current_path dashboard_user_path(@user.id)
        expect(page).to have_content @user.email
      end

      it '他ユーザーのダッシュボードにアクセスできないこと' do
        visit dashboard_user_path(@user1.id)
        expect(page).to have_current_path root_path
        expect(page).to have_content "No Access Right."
      end

      it '自分のプロフィール編集ページにアクセスできること' do
        visit edit_user_path(@user.id)
        expect(page).to have_current_path edit_user_path(@user.id)
      end

      it '自分のアカウント編集ページにアクセスできること' do
        visit edit_user_registration_path(@user.id)
        expect(page).to have_current_path edit_user_registration_path(@user.id)
      end

      it '他ユーザーのプロフィール編集ページにアクセスできないこと' do
        visit edit_user_path(@user1.id)
        expect(page).to have_current_path root_path
      end

      it 'ログイン後ユーザー登録ページにアクセスできない' do
        visit new_user_registration_path
        expect(page).to have_current_path root_path
        expect(page).to have_content "You are already signed in."
      end

      context '編集' do
      end

    end

    # context 'アドミン管理画面へのアクセス権限' do
    #   it 'アドミン管理一覧画面にアクセスできない' do
    #     visit admin_users_path
    #     expect(page).to have_current_path tasks_path
    #     expect(page).to have_content "権限がありません。"
    #   end
    #
    #   it 'アドミン管理ユーザー詳細画面にアクセスできない' do
    #     visit admin_user_path(@user2.id)
    #     expect(page).to have_current_path tasks_path
    #     expect(page).to have_content "権限がありません。"
    #   end
    #
    #   it 'アドミン管理ユーザー編集画面にアクセスできない' do
    #     visit edit_admin_user_path(@user2.id)
    #     expect(page).to have_current_path tasks_path
    #     expect(page).to have_content "権限がありません。"
    #   end
    # end
  end
end
