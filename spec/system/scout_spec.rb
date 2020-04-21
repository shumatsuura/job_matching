require 'rails_helper'

RSpec.describe 'Scout Test', type: :system, js: true do
  before do
    @user = User.create(email: 'user@sample.com', password: "password", password_confirmation: "password")
    @user_other = User.create(email: 'user1@sample.com', password: "password", password_confirmation: "password")
    @company = Company.create(name: "sample_company", :email => 'test@example.com', :password => 'f4k3p455w0rd')

    @scout = @company.scouts.create(user_id: @user.id)
    @scout.scout_messages.create(user_id: @scout.user_id, body: "test1")
    @scout.scout_messages.create(user_id: @scout.user_id, body: "test2")
    @scout.scout_messages.create(company_id: @scout.company_id, body: "test1")
    @scout.scout_messages.create(company_id: @scout.company_id, body: "test2")

    @company_other = Company.create(name: "sample_other_company", email: 'company1@sample.com', password: "password", password_confirmation: "password")
    @scout_other = @company_other.scouts.create(user_id: @user_other.id)
    JobCategory.create(name: "test_category")
    Industry.create(name: "test_industry")
  end

  describe 'カンパニーの権限' do
    before do
      login_as(@company, :scope => :company)
    end

    it 'スカウトインデックスページにアクセスできる' do
      visit scouts_path
      expect(page).to have_current_path scouts_path
    end

    it '自社のスカウトメッセージページにアクセスできる' do
      visit scout_scout_messages_path(@scout.id)
      expect(page).to have_current_path scout_scout_messages_path(@scout.id)
    end

    it '他社のスカウトメッセージページにアクセスできない' do
      visit scout_scout_messages_path(@scout_other.id)

      expect(page).to have_content "No Access Right."
      expect(page).to have_current_path root_path
    end

    it 'メッセージページからメッセージを送信できる' do
      visit scout_scout_messages_path(@scout.id)
      fill_in 'scout_message_body', with: 'test message'
      click_on 'Send message'

      expect(page).to have_content 'test message'
      expect(page).to have_content 'Unread'
    end

    it 'ダッシュボードに未読メッセージ数が表示され、アクセスすると未読メッセージ数が0になる' do
      visit dashboard_company_path(@company.id)
      expect(all('.badge-light')[0].text).to eq "2"
      visit scout_scout_messages_path(@scout.id)

      visit dashboard_company_path(@company.id)
      expect(all('.badge-light')[0].text).to eq "0"
    end

    it 'スカウトインデックスに未読メッセージ数が表示され、アクセスすると未読メッセージ数が0になる' do
      visit scouts_path

      expect(all('.badge-light')[0].text).to eq "2"
      visit scout_scout_messages_path(@scout.id)

      visit scouts_path
      expect(all('.badge-light')[0].text).to eq "0"

    end
  end

  describe 'ログインユーザーの権限' do
    before do
      login_as(@user, :scope => :user)
    end

    it 'スカウトインデックスページにアクセスできる' do
      visit scouts_path
      expect(page).to have_current_path scouts_path
      expect(page).to have_content @company.name
      expect(page).not_to have_content @company_other.name
    end

    it '自分がスカウトされたスカウトメッセージページにアクセスできる' do
      visit scout_scout_messages_path(@scout.id)
      expect(page).to have_current_path scout_scout_messages_path(@scout.id)
    end

    it '他人のスカウトメッセージページにアクセスできない' do
      visit scout_scout_messages_path(@scout_other.id)

      expect(page).to have_content "No Access Right."
      expect(page).to have_current_path root_path
    end

    it 'メッセージページからメッセージを送信できる' do
      visit scout_scout_messages_path(@scout.id)
      fill_in 'scout_message_body', with: 'test message'
      click_on 'Send message'

      expect(page).to have_content 'test message'
      expect(page).to have_content 'Unread'
    end

    it 'ダッシュボードに未読メッセージ数が表示され、アクセスすると未読メッセージ数が0になる' do
      visit dashboard_user_path(@user.id)

      count_list = all('.scout_count_badge')
      expect(count_list[0].text).to eq "2"
      visit scout_scout_messages_path(@scout.id)

      visit dashboard_user_path(@user.id)
      count_list = all('.scout_count_badge')
      expect(count_list[0].text).to eq "0"
      expect(count_list[0].text).not_to eq "2"

    end

    it 'スカウトインデックスに未読メッセージ数が表示され、アクセスすると未読メッセージ数が0になる' do
      visit scouts_path

      count_list = all('.scout_count_badge')

      expect(count_list[0]).to have_content 2
      visit scout_scout_messages_path(@scout.id)

      visit scouts_path
      count_list = all('.scout_count_badge')
      expect(count_list[0]).to have_content 0
      expect(count_list[0]).not_to have_content 2
    end
  end

  describe '未ログインユーザーの権限' do
    it 'スカウトメッセージページにアクセスできない' do
      visit scout_scout_messages_path(@scout.id)
      expect(page).to have_current_path root_path

      visit scout_scout_messages_path(@scout_other.id)

      expect(page).to have_current_path root_path
    end

    it 'アプライインデックスページにアクセスできない' do
      visit scouts_path
      expect(page).to have_current_path root_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'アドミンユーザーの権限' do
    before do
      @admin_user = User.create(email: 'admin_user@sample.com', password: "password", password_confirmation: "password", admin: true)
      login_as(@admin_user, :scope => :user)
    end

    it '各ユーザー、カンパニーのスカウトメッセージページにアクセスできない' do
      visit scout_scout_messages_path(@scout.id)

      expect(page).to have_current_path root_path
      expect(page).to have_content "No Access Right."

      visit scout_scout_messages_path(@scout_other.id)

      expect(page).to have_content "No Access Right."
      expect(page).to have_current_path root_path
    end

    it 'アドミンユーザー用スカウトメッセージページにアクセスできる' do
      visit admin_scout_scout_messages_path(@scout.id)
      expect(page).to have_current_path admin_scout_scout_messages_path(@scout.id)

      visit admin_scout_scout_messages_path(@scout_other.id)
      expect(page).to have_current_path admin_scout_scout_messages_path(@scout_other.id)
    end

    it 'アドミン用スカウト管理画面からスカウトを削除できる' do
      x = Scout.all.count
      visit admin_scouts_path

      accept_alert do
        click_link 'Delete', match: :first
      end

      sleep 1
      y = Scout.all.count
      expect(x-y).to eq 1
    end

    it 'アドミンユーザー用スカウトメッセージページからメッセージを削除できる' do
      x = ScoutMessage.all.count
      visit admin_scout_scout_messages_path(@scout.id)
      accept_alert do
        click_link 'Delete', match: :first
      end

      sleep 1
      y = ScoutMessage.all.count
      expect(x-y).to eq 1
    end
  end
end
