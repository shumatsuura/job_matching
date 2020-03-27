require 'rails_helper'

RSpec.describe User, type: :model do
  describe "新規登録時" do
    it 'emailが空ならバリデーションが通らない' do
      user = User.new(email: "",password: "password")
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

      it '編集時にfirst_nameが空ならバリデーションが通らない' do
        @user.first_name = ""
        expect(@user).not_to be_valid(:update)
      end

      it '編集時にlast_nameが空ならバリデーションが通らない' do
        @user.last_name = ""
        expect(@user).not_to be_valid(:update)
      end

      it '編集時にstatusが空ならバリデーションが通らない' do
        @user.status = ""
        expect(@user).not_to be_valid(:update)
      end

      it '編集時にgenderが空ならバリデーションが通らない' do
        @user.gender = ""
        expect(@user).not_to be_valid(:update)
      end
    end

    context 'Education' do
      it 'Shool Nameが空ならバリデーションが通らない' do
        education = @user.educations.build(school_name: "")
        expect(education).not_to be_valid
      end

      it 'School Nameがあればバリデーションが通る' do
        education = @user.educations.build(school_name: "aaa")
        expect(education).to be_valid
      end

      it 'Period EndかCurrently Attendingどちらが入ってないと通らない' do
        

      end

    end

    context 'Work Experience' do
      it 'Companyが空ならバリデーションが通らない' do

      end

      it 'Period EndかCurrently Employedどちらかが入ってないと通らない' do
      end
      it 'Period EndかCurrently Employed両方入ってると通らない' do
      end
    end

    context 'Skill' do

    end

    context 'Qualification' do

    end

    context 'Desired Industry' do

    end

    context 'Desired Job Category' do
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
