require 'rails_helper'

RSpec.describe 'カンパニー機能', type: :system, js: true do
  before do
    @user1 = User.create(email: 'user1@sample.com', password: "password", password_confirmation: "password")
    @user2 = User.create(email: 'user2@sample.com', password: "password", password_confirmation: "password")
    @company1 = Company.create(email: 'company1@sample.com', password: "password", password_confirmation: "password")
  end

  describe 'カンパニー登録' do
    context '新規カンパニーのサインアップ' do
      it '登録でき、詳細ページにリダイレクトされること' do
        visit root_path

        click_on 'For Employer'
        click_on 'C Sign-Up'

        fill_in 'Email', with: 'shunsukE@sample.com'
        fill_in 'Password', with: "password"
        fill_in 'Password confirmation', with: "password"
        click_button 'Sign up'

        expect(page).to have_current_path root_path
        expect(page).to have_content 'successfully'
      end

      it 'ログインして詳細ページにリダイレクトされること' do
        visit new_company_session_path
        fill_in 'Email', with: 'company1@sample.com'
        fill_in 'Password', with: "password"
        click_on "Log in"

        expect(page).to have_current_path root_path
        expect(page).to have_content 'successfully'
      end
    end
  end

  describe '未ログインでのアクセス権限' do
    it '未ログインではカンパニーダッシュボードページにアクセスできないこと' do
      visit dashboard_company_path(@company1.id)
      expect(page).to have_current_path new_company_session_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    it '未ログインではプロフィール編集ページにアクセスできないこと' do
      visit edit_company_path(@company1.id)
      expect(page).to have_current_path new_company_session_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    # it '未ログインではアカウント編集ページにアクセスできないこと' do
    #   visit edit_company_registration_path(@company1.id)
    #   expect(page).to have_current_path new_company_session_path
    #   expect(page).to have_content 'You need to sign in or sign up before continuing.'
    # end

    it 'カンパニーインデックスページにアクセスできること' do
      visit companies_path
      expect(page).to have_current_path companies_path
    end

    it 'カンパニー詳細ページにアクセスできること' do
      visit company_path(@company1.id)
      expect(page).to have_current_path company_path(@company1.id)
      expect(page).to have_content @company1.name
    end
  end

  describe 'カンパニーのアクセス権限' do
    before do
      company = Company.create!(name: "sample_company", :email => 'test@example.com', :password => 'f4k3p455w0rd')
      login_as(company, :scope => :company)
      @company = company
    end

    it '自社のダッシュボードページにアクセスできること' do
      visit dashboard_company_path(@company.id)
      expect(page).to have_current_path dashboard_company_path(@company.id)
      expect(page).to have_content @company.name
    end

    it '他社のダッシュボードページにアクセスできないこと' do
      visit dashboard_company_path(@company1.id)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right"
    end

    it '自社の詳細ページにアクセスできること' do
      visit company_path(@company.id)
      expect(page).to have_current_path company_path(@company.id)
      expect(page).to have_content @company.name
    end

    it '他社の詳細ページにアクセスできること' do
      visit company_path(@company1.id)
      expect(page).to have_current_path company_path(@company1.id)
    end

    it '自社のプロフィール編集ページにアクセスできること' do
      visit edit_company_path(@company.id)
      expect(page).to have_current_path edit_company_path(@company.id)
    end

    it '自社のアカウント編集ページにアクセスできること' do
      visit edit_company_registration_path(@company.id)
      expect(page).to have_current_path edit_company_registration_path(@company.id)
    end

    it '他社のプロフィール編集ページにアクセスできないこと' do
      visit edit_company_path(@company1.id)
      expect(page).to have_current_path root_path
      expect(page).to have_content 'No Access Right.'
    end

    # it '他社のアカウント編集ページにアクセスできないこと' do
    #   visit edit_company_registration_path(@company1.id)
    #   expect(page).to have_current_path new_company_session_path
    #   expect(page).to have_content 'You need to sign in or sign up before continuing.'
    # end

    it 'カンパニーインデックスページにアクセスできること' do
      visit companies_path
      expect(page).to have_current_path companies_path
    end

  end

  describe 'ログインユーザー' do
    before do
      user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
      login_as(user, :scope => :user)
      @user = user
    end

    context 'アクセス権限' do

      it 'ダッシュボードページにアクセスできないこと' do
        visit dashboard_company_path(@company1.id)
        expect(page).to have_current_path new_company_session_path
      end

      it '他社の詳細ページにアクセスできること' do
        visit company_path(@company1.id)
        expect(page).to have_current_path company_path(@company1.id)
      end

      it 'プロフィール編集ページにアクセスできないこと' do
        visit edit_company_path(@company1.id)
        expect(page).to have_current_path new_company_session_path
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end

      # it 'アカウント編集ページにアクセスできないこと' do
      #   visit edit_company_registration_path(@company1.id)
      #   expect(page).to have_current_path new_company_session_path
      #   expect(page).to have_content 'You need to sign in or sign up before continuing.'
      # end

      it 'カンパニーインデックスページにアクセスできること' do
        visit companies_path
        expect(page).to have_current_path companies_path
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
