require 'rails_helper'

RSpec.describe User, type: :model do
  describe "新規登録時" do
    it 'emailが空ならバリデーションが通らない' do
      user = User.new(email: "",password: "password")
      expect(user).not_to be_valid(:create)
    end

    it 'emailが無効な値ならバリデーションが通らない' do
      user = User.new(email: "aaaaa",password: "password")
      expect(user).not_to be_valid(:create)
    end

    it 'passwordが空ならバリデーションが通らない' do
      user = User.new(email: "test@test.com",password: "")
      expect(user).not_to be_valid(:create)
    end

    it 'email,passwordがあればバリデーションが通る' do
      user = User.create(email: "test@test.com",password: "password")
      expect(user).to be_valid(:create)
    end
  end

  describe '編集時' do
    before do
      @user = User.new(email: "test@test.com",password: "password")
      @user.first_name = "test_first_name"
      @user.last_name = "test_last_name"
      @user.status = "Close"
      @user.gender = "Male"
      @user.date_of_birth = DateTime.now - 20.years
    end

    context '親レコード' do

      it '編集時にバリデーションが通る' do
        expect(@user).to be_valid(:update)
      end

    end

  # it '通常ユーザーの削除' do
  #   x = User.all
  #   expect{ User.last.destroy }.to change{ x.size }.from(101).to(100)
  # end

  # it 'adminの削除' do
  #   x = User.all.count
  #   User.first.destroy
  #   y = User.all.count
  #   expect(x - y).to eq 0
  # end
  #
  # it 'adminの変更' do
  #   expect(User.where(admin: true).count).to eq 1
  #   user = User.find_by(admin: true)
  #   user.update(admin: false)
  #   expect(User.where(admin: true).count).to eq 1
  # end

end
