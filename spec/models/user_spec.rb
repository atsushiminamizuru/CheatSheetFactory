require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'introductionは空でも登録できる' do
        @user.introduction = ''
        expect(@user).to be_valid
      end
      it 'profile_imageは空でも登録できる' do
        @user.profile_image = nil
        expect(@user).to be_valid
      end
      it 'emailが固有かつ@を含んでいれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上128文字以下であれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが半角英数字混合での入力であれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが一致していれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nameが20文字以下であれば登録できる' do
        expect(@user).to be_valid
      end
      it 'introductionが200文字以下であれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'パスワードに半角英字が含まれていない場合、登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'パスワードに半角数字が含まれていない場合、登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'パスワードに半角記号が含まれている場合、登録できない' do
        @user.password = '123ab%'
        @user.password_confirmation = '123ab%'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'パスワードに半角カタカナが含まれている場合、登録できない' do
        @user.password = '123abｨ'
        @user.password_confirmation = '123abｨ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'パスワードに全角英字が含まれている場合、登録できない' do
        @user.password = '123abＡ'
        @user.password_confirmation = '123abＡ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'パスワードに全角数字が含まれている場合、登録できない' do
        @user.password = '123ab６'
        @user.password_confirmation = '123ab６'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'パスワードに全角記号が含まれている場合、登録できない' do
        @user.password = '123ab％'
        @user.password_confirmation = '123ab％'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'パスワードに全角（漢字・ひらがな・カタカナ）が含まれている場合、登録できない' do
        @user.password = '123ab練しゅウ'
        @user.password_confirmation = '123ab練しゅウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'nameが21文字以上では登録できない' do
        @user.name = Faker::Lorem.characters(number: 21)
        @user.valid?
        expect(@user.errors.full_messages).to include('Name is too long (maximum is 20 characters)')
      end
      it '重複したnameが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.name = @user.name
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Name has already been taken')
      end
      it 'introductionが201文字以上では登録できない' do
        @user.introduction = Faker::Lorem.characters(number: 201)
        @user.valid?
        expect(@user.errors.full_messages).to include('Introduction is too long (maximum is 200 characters)')
      end
    end
  end
end
