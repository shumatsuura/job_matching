require 'rails_helper'

RSpec.describe 'Post Function', type: :system, js: true do
  before do
    @user = User.create(email: 'user@sample.com', password: "password", password_confirmation: "password")
    @user1 = User.create(email: 'user1@sample.com', password: "password", password_confirmation: "password")
    @user2 = User.create(email: 'user2@sample.com', password: "password", password_confirmation: "password")
    @company = Company.create!(name: "sample_company", :email => 'test@example.com', :password => 'f4k3p455w0rd')
    @post = FactoryBot.create(:post, company_id: @company.id)
    @company1 = Company.create(email: 'company1@sample.com', password: "password", password_confirmation: "password")
    @post1 = FactoryBot.create(:post, company_id: @company1.id)
    JobCategory.create(name: "test_category")
    Industry.create(name: "test_industry")
  end

  describe 'カンパニーの権限' do
    before do
      login_as(@company, :scope => :company)
      @company.company_skills.create(name: "test_skill")
    end

    it 'Postのマネージページにアクセスできる' do
      visit manage_post_path(@post.id)
      expect(page).to have_current_path manage_post_path(@post.id)
    end

    it 'メッセージページにアクセスできる' do

    end

    it 'メッセージページからメッセージを送信できる' do

    end

    it 'マネージページに未読メッセージ数が表示される' do

    end

    it 'アクセスすると未読メッセージ数が0になる' do

    end
  end

  describe 'ログインユーザーの権限' do
    before do
      login_as(@user, :scope => :user)
    end

    it 'ポスト作成ページにアクセスできないこと' do
      visit new_post_path
      expect(page).to have_current_path new_company_session_path
    end

    it 'ポストページにアクセスできる' do
      visit post_path(@post1.id)
      expect(page).to have_current_path post_path(@post1.id)
      expect(page).to have_content 'Like'
      expect(page).to have_content 'Apply Now'
    end

    it 'Post編集ページにアクセスできない' do
      visit edit_post_path(@post1.id)
      expect(page).to have_current_path new_company_session_path
    end

    it 'Postのマネージページにアクセスできない' do
      visit manage_post_path(@post1.id)

      expect(page).to have_current_path new_company_session_path
    end
  end

  describe '未ログインユーザーの権限' do
    it 'ポスト作成ページにアクセスできないこと' do
      visit new_post_path
      expect(page).to have_current_path new_company_session_path
    end

    it 'ポストページにアクセスできる' do
      visit post_path(@post1.id)
      expect(page).to have_current_path post_path(@post1.id)
      expect(page).not_to have_content 'Like'
      expect(page).not_to have_content 'Apply Now'
    end

    it 'Post編集ページにアクセスできない' do
      visit edit_post_path(@post1.id)
      expect(page).to have_current_path new_company_session_path
    end

    it 'Postのマネージページにアクセスできない' do
      visit manage_post_path(@post1.id)

      expect(page).to have_current_path new_company_session_path
    end
  end
end
