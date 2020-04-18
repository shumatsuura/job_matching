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

    it 'アドミン用カンパニーnewへアクセスし、カンパニーを作成できること' do
      visit new_admin_company_path
      expect(page).to have_current_path new_admin_company_path

      fill_in 'company_email', with:'kaka@test.com'
      fill_in 'company_password', with:'password'
      fill_in 'company_password_confirmation', with:'password'

      click_on 'Create Company'

      expect(page).to have_content "successfully"
    end

    it 'アドミン用カンパニーindexへアクセスできること' do
      visit admin_companies_path
      expect(page).to have_current_path admin_companies_path
    end

    it 'アドミン用カンパニーeditへアクセスでき、更新できること' do
      visit edit_admin_company_path(@company)
      expect(page).to have_current_path edit_admin_company_path(@company)
      fill_in 'company_email', with:'admintest@test.com'
      click_on 'Update'

      expect(page).to have_content 'successfully'
    end

    it 'アドミン用カンパニーindexからカンパニーを削除できること' do
      visit admin_companies_path
      click_on 'Edit', match: :first
      accept_alert do
        click_link 'Delete'
      end
      expect(page).to have_content 'successfully'
    end

    it 'アドミン用ユーザーnewへのアクセスでき、ユーザーを作成できること' do
      visit new_admin_user_path
      expect(page).to have_current_path new_admin_user_path

      fill_in 'user_email', with:'kaka@test.com'
      fill_in 'user_password', with:'password'
      fill_in 'user_password_confirmation', with:'password'

      click_on 'Create User'

      expect(page).to have_content "successfully"

    end

    it 'アドミン用ユーザーindexへアクセスできること' do
      visit admin_users_path
      expect(page).to have_current_path admin_users_path
    end

    it 'アドミン用ユーザーeditへアクセスでき、編集できること' do
      visit edit_admin_user_path(@user)
      expect(page).to have_current_path edit_admin_user_path(@user)

      fill_in 'user_email', with:'testfdsafdsa@dfksaj.com'

      click_on 'Update'
      expect(page).to have_content 'successfully'
    end

    it 'アドミン用ユーザーindexからユーザーを削除できること' do
      visit admin_users_path
      all(".dropdown-toggle")[5].click
      accept_alert do
        click_link 'Delete'
      end

      expect(page).to have_content 'successfully'
    end

    it 'アドミン用ポストindexへアクセスできること' do
      visit admin_posts_path

      expect(page).to have_current_path admin_posts_path
    end

    it 'アドミン用ポストindexからポストを削除できること' do
      visit admin_posts_path
      click_on 'Edit', match: :first
      accept_alert do
        click_link 'Delete'
      end

      expect(page).to have_content 'successfully'
    end

    it 'アドミン用スカウトindexへアクセスできること' do
      visit admin_scouts_path
      expect(page).to have_current_path admin_scouts_path
    end

    it 'アドミン用スカウトindexからスカウトを削除できること' do
      visit admin_scouts_path
      accept_alert do
        click_link 'Delete', match: :first
      end
      expect(page).to have_content 'successfully'
    end

    it 'アドミン用スカウトメッセージindex_allページへアクセスできること' do
      visit index_all_admin_scout_messages_path

      expect(page).to have_current_path index_all_admin_scout_messages_path
    end

    it 'アドミン用スカウトメッセージindex_allページからメッセージを削除できること' do
      visit index_all_admin_scout_messages_path
      accept_alert do
        click_link 'Delete', match: :first
      end
      expect(page).to have_content 'successfully'
    end

    it 'アドミン用スカウトメッセージページへアクセスできること' do
      visit admin_scout_scout_messages_path(@scout)
      expect(page).to have_current_path admin_scout_scout_messages_path(@scout)
    end

    it 'アドミン用スカウトメッセージページからメッセージを削除できること' do
      visit admin_scout_scout_messages_path(@scout)

      accept_alert do
        click_link 'Delete', match: :first
      end

      expect(page).to have_content 'successfully'
    end

    it 'アドミン用アプライindexへアクセスできること' do
      visit admin_applies_path
      expect(page).to have_current_path admin_applies_path
    end

    it 'アドミン用アプライメッセージindex_allページへアクセスできること' do
      visit index_all_admin_apply_messages_path
      expect(page).to have_current_path index_all_admin_apply_messages_path
    end

    it 'アドミン用アプライメッセージページへアクセスできること' do
      visit admin_apply_apply_messages_path(@scout)
      expect(page).to have_current_path admin_apply_apply_messages_path(@scout)
    end
  end
end
