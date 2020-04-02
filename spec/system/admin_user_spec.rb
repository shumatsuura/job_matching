require 'rails_helper'

RSpec.describe 'Admin Function Test', type: :system, js: true do
  before do
    @user = User.create(email: 'user@sample.com', password: "password", password_confirmation: "password")
    @user_other = User.create(email: 'user1@sample.com', password: "password", password_confirmation: "password")
    @company = Company.create!(name: "sample_company", :email => 'test@example.com', :password => 'f4k3p455w0rd')
    @post = FactoryBot.create(:post, title: "post_test", company_id: @company.id)

    @apply = @user.applies.create(post_id: @post.id)
    @apply.apply_messages.create(user_id: @apply.user_id, body: "test1")
    @apply.apply_messages.create(user_id: @apply.user_id, body: "test2")
    @apply.apply_messages.create(company_id: @apply.post.company_id, body: "test1")
    @apply.apply_messages.create(company_id: @apply.post.company_id, body: "test2")

    @scout = @company.scouts.create(user_id: @user.id)
    @scout.scout_messages.create(user_id: @scout.user_id, body: "test1")
    @scout.scout_messages.create(user_id: @scout.user_id, body: "test2")
    @scout.scout_messages.create(company_id: @scout.company_id, body: "test1")
    @scout.scout_messages.create(company_id: @scout.company_id, body: "test2")

    @company_other = Company.create(email: 'company1@sample.com', password: "password", password_confirmation: "password")
    @post_other = FactoryBot.create(:post, title: "post_test_other", company_id: @company_other.id)
    @apply_other = @user_other.applies.create(post_id: @post_other.id)
    JobCategory.create(name: "test_category")
    Industry.create(name: "test_industry")
  end

  describe 'ユーザーの権限' do
    before do
      login_as(@user, :scope => :user)
    end

    it 'アドミン用ダッシュボードへアクセスできないこと' do
      visit dashboard_admin_users_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーnewへアクセスできないこと' do
      visit new_admin_company_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーindexへアクセスできないこと' do
      visit admin_companies_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーeditへアクセスできないこと' do
      visit edit_admin_company_path(@company)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーnewへのアクセス' do
      visit new_admin_user_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーindexへアクセスできないこと' do
      visit admin_users_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーeditへアクセスできないこと' do
      visit edit_admin_user_path(@user)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーeditへアクセスできないこと' do
      visit edit_admin_company_path(@company)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ポストindexへアクセスできないこと' do
      visit admin_posts_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトindexへアクセスできないこと' do
      visit admin_scouts_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトメッセージindex_allページへアクセスできないこと' do
      visit index_all_admin_scout_messages_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトメッセージページへアクセスできないこと' do
      visit admin_scout_scout_messages_path(@scout)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライindexへアクセスできないこと' do
      visit admin_applies_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライメッセージindex_allページへアクセスできないこと' do
      visit index_all_admin_apply_messages_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライメッセージページへアクセスできないこと' do
      visit admin_apply_apply_messages_path(@scout)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end
  end

  describe 'カンパニーの権限' do
    before do
      login_as(@company, :scope => :company)
    end

    it 'アドミン用ダッシュボードへアクセスできないこと' do
      visit dashboard_admin_users_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーnewへアクセスできないこと' do
      visit new_admin_company_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーindexへアクセスできないこと' do
      visit admin_companies_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーeditへアクセスできないこと' do
      visit edit_admin_company_path(@company)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーnewへのアクセス' do
      visit new_admin_user_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーindexへアクセスできないこと' do
      visit admin_users_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーeditへアクセスできないこと' do
      visit edit_admin_user_path(@user)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ポストindexへアクセスできないこと' do
      visit admin_posts_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトindexへアクセスできないこと' do
      visit admin_scouts_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトメッセージindex_allページへアクセスできないこと' do
      visit index_all_admin_scout_messages_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトメッセージページへアクセスできないこと' do
      visit admin_scout_scout_messages_path(@scout)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライindexへアクセスできないこと' do
      visit admin_applies_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライメッセージindex_allページへアクセスできないこと' do
      visit index_all_admin_apply_messages_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライメッセージページへアクセスできないこと' do
      visit admin_apply_apply_messages_path(@scout)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end
  end

  describe '未ログインの権限' do
    it 'アドミン用ダッシュボードへアクセスできないこと' do
      visit dashboard_admin_users_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーnewへアクセスできないこと' do
      visit new_admin_company_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーindexへアクセスできないこと' do
      visit admin_companies_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーeditへアクセスできないこと' do
      visit edit_admin_company_path(@company)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーnewへのアクセス' do
      visit new_admin_user_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーindexへアクセスできないこと' do
      visit admin_users_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーeditへアクセスできないこと' do
      visit edit_admin_user_path(@user)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ポストindexへアクセスできないこと' do
      visit admin_posts_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトindexへアクセスできないこと' do
      visit admin_scouts_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトメッセージindex_allページへアクセスできないこと' do
      visit index_all_admin_scout_messages_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトメッセージページへアクセスできないこと' do
      visit admin_scout_scout_messages_path(@scout)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライindexへアクセスできないこと' do
      visit admin_applies_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライメッセージindex_allページへアクセスできないこと' do
      visit index_all_admin_apply_messages_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライメッセージページへアクセスできないこと' do
      visit admin_apply_apply_messages_path(@scout)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end
  end

  describe 'アドミンユーザーの権限' do
    before do
      @admin_user = User.create(email: "admin@admin.com", password: "password", password_confirmation: "password", admin: true)
      login_as(@admin_user, :scope => :user)
    end

    it 'アドミン用ダッシュボードへアクセスできないこと' do
      visit dashboard_admin_users_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーnewへアクセスできないこと' do
      visit new_admin_company_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーindexへアクセスできないこと' do
      visit admin_companies_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用カンパニーeditへアクセスできないこと' do
      visit edit_admin_company_path(@company)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーnewへのアクセス' do
      visit new_admin_user_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーindexへアクセスできないこと' do
      visit admin_users_path
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ユーザーeditへアクセスできないこと' do
      visit edit_admin_user_path(@user)
      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用ポストindexへアクセスできないこと' do
      visit admin_posts_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトindexへアクセスできないこと' do
      visit admin_scouts_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトメッセージindex_allページへアクセスできないこと' do
      visit index_all_admin_scout_messages_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用スカウトメッセージページへアクセスできないこと' do
      visit admin_scout_scout_messages_path(@scout)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライindexへアクセスできないこと' do
      visit admin_applies_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライメッセージindex_allページへアクセスできないこと' do
      visit index_all_admin_apply_messages_path

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end

    it 'アドミン用アプライメッセージページへアクセスできないこと' do
      visit admin_apply_apply_messages_path(@scout)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."
    end
  end
end
