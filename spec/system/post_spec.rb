require 'rails_helper'

RSpec.describe 'Post Test', type: :system, js: true do
  before do
    @user = User.create(email: 'user@sample.com', password: "password", password_confirmation: "password")
    @user1 = User.create(email: 'user1@sample.com', password: "password", password_confirmation: "password")
    @company = Company.create!(name: "sample_company", :email => 'test@example.com', :password => 'f4k3p455w0rd')
    @post = FactoryBot.create(:post, company_id: @company.id)
    @company1 = Company.create(name: "sample1_company",email: 'company1@sample.com', password: "password", password_confirmation: "password")
    @post1 = FactoryBot.create(:post, company_id: @company1.id)
    @company1.company_skills.create(name: "test_skill")
    JobCategory.create(name: "test_category")
    Industry.create(name: "test_industry")
  end

  describe 'カンパニーの権限' do
    before do
      login_as(@company, :scope => :company)
      @company.company_skills.create(name: "test_skill")
    end

    it '自社のダッシュボードページからPost作成画面にアクセスできること' do
      visit dashboard_company_path(@company.id)
      click_on 'Create New Post'
      expect(page).to have_current_path new_post_path
    end

    it 'Postを作成できる' do
      visit new_post_path
      fill_in 'Title', with:'wei'
      fill_in 'Salary', with:'222'
      fill_in 'Number of recruits', with:'2'
      fill_in 'Position', with:'Head'
      fill_in 'Description', with:'aaa aaa iii'
      fill_in 'Location', with:'yangon'

      select 'test_category', from: "post_post_job_categories_attributes_0_job_category_id"
      select 'test_industry', from: "post_post_industries_attributes_0_industry_id"

      find('label',:text => 'test_skill').click
      click_on 'Create Post'

      expect(page).to have_content "wei"
      expect(page).to have_content "yangon"
      expect(page).to have_content "successfully"
    end

    it '自社のポストページにアクセスできる' do
      visit post_path(@post.id)
      expect(page).to have_current_path post_path(@post.id)
    end

    it '他社のポストページにアクセスできる' do
      visit post_path(@post1.id)
      expect(page).to have_current_path post_path(@post1.id)
      expect(page).not_to have_content 'Like'
      expect(page).not_to have_content 'Unlike'
      expect(page).not_to have_content 'Apply Now'
      expect(page).not_to have_content 'Delete Application'
    end

    it 'Postを編集できる' do
      visit edit_post_path(@post.id)
      fill_in 'Title', with:'wei'
      click_on 'Update Post'

      expect(page).to have_content "wei"
      expect(page).to have_content "successfully"
    end

    it '他社のPost編集ページにアクセスできない' do
      visit edit_post_path(@post1.id)
      expect(page).to have_content "No Access Right."
      expect(page).to have_current_path root_path
    end

    it 'Postを削除できる' do
      x = @company.posts.count
      visit dashboard_company_path(@company.id)

      accept_alert do
        click_link 'Delete'
      end
      sleep 1
      y = @company.posts.count
      expect(x-y).to eq 1
    end

    it 'Postのマネージページにアクセスできる' do
      visit manage_post_path(@post.id)
      expect(page).to have_current_path manage_post_path(@post.id)
    end

    it '他社のPostのマネージページにアクセスできない' do
      visit manage_post_path(@post1.id)
      expect(page).to have_content "No Access Right."
      expect(page).to have_current_path root_path
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
      expect(all('.fa-heart').empty?).not_to eq true
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
      expect(page).not_to have_content '.fa-heart'
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

  describe 'アドミンユーザーの権限' do
    before do
      @admin_user = User.create(email: 'admin_user@sample.com', password: "password", password_confirmation: "password", admin: true)
      login_as(@admin_user, :scope => :user)
    end

    it '特定のカンパニーに紐づいたポストを作成できる' do
      visit admin_companies_path
      click_on 'Edit', match: :first
      click_on 'Create New Post'

      fill_in 'Title', with:'admin_post'
      fill_in 'Salary', with:'222'
      fill_in 'Number of recruits', with:'2'
      fill_in 'Position', with:'Head'
      fill_in 'Description', with:'aaa aaa iii'
      fill_in 'Location', with:'Tokyo'

      find('label',:text => 'test_skill').click
      select 'test_category', from: "post_post_job_categories_attributes_0_job_category_id"
      select 'test_industry', from: "post_post_industries_attributes_0_industry_id"

      click_on 'Create Post'

      expect(page).to have_content "admin_post"
      expect(page).to have_content "Tokyo"
      expect(page).to have_content "successfully"

    end

    it 'ポスト詳細ページにアクセスできる' do
      visit post_path(@post.id)
      expect(page).to have_current_path post_path(@post.id)

      visit post_path(@post1.id)
      expect(page).to have_current_path post_path(@post1.id)
    end

    it 'ポストマネージページにアクセスできる' do
      visit manage_post_path(@post.id)
      expect(page).to have_current_path manage_post_path(@post.id)

      visit manage_post_path(@post1.id)
      expect(page).to have_current_path manage_post_path(@post1.id)
    end

    it '特定のカンパニーに紐づいたポストを編集できる' do
      visit admin_posts_path
      click_on 'Edit', match: :first
      click_on 'Edit Post'

      fill_in 'Title', with:'weiwei'
      click_on 'Update Post'

      expect(page).to have_content "weiwei"
      expect(page).to have_content "successfully"
    end

    it '特定のカンパニーに紐づいたポストを削除できる' do
      x = Post.all.count
      visit admin_posts_path
      click_on 'Edit', match: :first
      accept_alert do
        click_link 'Delete'
      end
      sleep 1
      y = Post.all.count
      expect(x-y).to eq 1
    end
  end

end
