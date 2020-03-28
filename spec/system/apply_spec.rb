require 'rails_helper'

RSpec.describe 'Apply Test', type: :system, js: true do
  before do
    @user = User.create(email: 'user@sample.com', password: "password", password_confirmation: "password")
    @user_other = User.create(email: 'user1@sample.com', password: "password", password_confirmation: "password")
    @company = Company.create!(name: "sample_company", :email => 'test@example.com', :password => 'f4k3p455w0rd')
    @post = FactoryBot.create(:post, title: "post_test", company_id: @company.id)
    @apply = @user.applies.create(post_id: @post.id)
    @company_other = Company.create(email: 'company1@sample.com', password: "password", password_confirmation: "password")
    @post_other = FactoryBot.create(:post, title: "post_test_other", company_id: @company_other.id)
    @apply_other = @user_other.applies.create(post_id: @post_other.id)
    JobCategory.create(name: "test_category")
    Industry.create(name: "test_industry")
  end

  describe 'カンパニーの権限' do
    before do
      login_as(@company, :scope => :company)
    end

    it 'マネージページでApplyの件数を把握できる' do
      visit manage_post_path(@post.id)
      expect(page).to have_current_path manage_post_path(@post.id)
      expect(page).to have_content @post.applies.count.to_s
    end

    it '自社のポストへのアプライメッセージページにアクセスできる' do
      visit apply_apply_messages_path(@apply.id)
      expect(page).to have_current_path apply_apply_messages_path(@apply.id)
    end

    it '他社のポストへのアプライメッセージページにアクセスできない' do
      visit apply_apply_messages_path(@apply_other.id)

      expect(page).to have_content "No Access Right."
      expect(page).to have_current_path root_path
    end

    it 'メッセージページからメッセージを送信できる' do
      visit apply_apply_messages_path(@apply.id)
      fill_in 'apply_message_body', with: 'test message'
      click_on 'Send message'

      expect(page).to have_content 'test message'
      expect(page).to have_content '未読'
    end

    it 'マネージページに未読メッセージ数が表示され、アクセスすると未読メッセージ数が0になる' do
      @apply.apply_messages.create(user_id: @apply.user_id, body: "test1")
      @apply.apply_messages.create(user_id: @apply.user_id, body: "test2")
      visit manage_post_path(@post.id)

      expect(page).to have_content 2
      visit apply_apply_messages_path(@apply.id)

      expect(page).to have_content 0
    end
  end

  describe 'ログインユーザーの権限' do
    before do
      login_as(@user, :scope => :user)
    end

    it 'アプライインデックスページにアクセスできる' do
      visit applies_path
      expect(page).to have_current_path applies_path
      expect(page).to have_content 'post_test'
      expect(page).not_to have_content 'post_test_other'
    end

    it 'カンパニーのマネージページにはアクセスできない' do
      visit manage_post_path(@post.id)
      expect(page).to have_current_path new_company_session_path
    end

    it '自分がアプライしたポストへのアプライメッセージページにアクセスできる' do
      visit apply_apply_messages_path(@apply.id)
      expect(page).to have_current_path apply_apply_messages_path(@apply.id)
    end

    it '他人のアプライメッセージページにアクセスできない' do
      visit apply_apply_messages_path(@apply_other.id)

      expect(page).to have_content "No Access Right."
      expect(page).to have_current_path root_path
    end

    it 'メッセージページからメッセージを送信できる' do
      visit apply_apply_messages_path(@apply.id)
      fill_in 'apply_message_body', with: 'test message'
      click_on 'Send message'

      expect(page).to have_content 'test message'
      expect(page).to have_content '未読'
    end

    it 'アプライインデックスに未読メッセージ数が表示され、アクセスすると未読メッセージ数が0になる' do
      @apply.apply_messages.create(company_id: @apply.post.company_id, body: "test1")
      @apply.apply_messages.create(company_id: @apply.post.company_id, body: "test2")
      visit applies_path
      expect(page).to have_content 2
      visit apply_apply_messages_path(@apply.id)
      expect(page).to have_content 0
    end

    it 'ダッシュボードに未読メッセージ数が表示され、アクセスすると未読メッセージ数が0になる' do
      @apply.apply_messages.create(company_id: @apply.post.company_id, body: "test1")
      @apply.apply_messages.create(company_id: @apply.post.company_id, body: "test2")
      visit dashboard_user_path(@user.id)
      expect(page).to have_content 2
      visit apply_apply_messages_path(@apply.id)
      expect(page).to have_content 0
    end
  end

  describe '未ログインユーザーの権限' do
    it 'アプライメッセージページにアクセスできない' do
      visit apply_apply_messages_path(@apply.id)
      expect(page).to have_current_path root_path

      visit apply_apply_messages_path(@apply_other.id)

      expect(page).to have_current_path root_path
    end

    it 'アプライインデックスページにアクセスできない' do
      visit applies_path
      expect(page).to have_current_path root_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
