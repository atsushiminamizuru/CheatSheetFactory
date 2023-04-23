require 'rails_helper'

RSpec.describe Sheet, type: :model do
  before do
    @sheet = FactoryBot.build(:sheet)
  end

  describe 'Cheat Sheet 投稿' do
    context '新規投稿できる場合' do
      it 'imageとtitleとcontentとgenreが存在すれば登録できる' do
        expect(@sheet).to be_valid
      end
      it 'titleが50文字以下であれば登録できる' do
        expect(@sheet).to be_valid
      end
      it 'contentが300文字以下であれば登録できる' do
        expect(@sheet).to be_valid
      end
      it 'userが紐づいていれば登録できる' do
        expect(@sheet).to be_valid
      end
      it 'genreが紐づいていれば登録できる' do
        expect(@sheet).to be_valid
      end
    end
    context '新規投稿できない場合' do
      it 'imageが空では登録できない' do
        @sheet.image = nil
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include("Image can't be blank")
      end
      it 'titleが空では登録できない' do
        @sheet.title = ''
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentが空では登録できない' do
        @sheet.content = ''
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include("Content can't be blank")
      end
      it 'genreが空では登録できない' do
        @sheet.genre_id = '0'
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include("Genre can't be blank")
      end
      it 'titleが51文字以上では登録できない' do
        @sheet.title = Faker::Lorem.characters(number: 51)
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include('Title is too long (maximum is 50 characters)')
      end
      it 'contentが301文字以上では登録できない' do
        @sheet.content = Faker::Lorem.characters(number: 301)
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include('Content is too long (maximum is 300 characters)')
      end
      it 'userが紐づいていなければ登録できない' do
        @sheet.user_id = 'nil'
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include('User must exist')
      end
      it 'genreが紐づいていなければ登録できない' do
        @sheet.genre_id = 'nil'
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include("Genre can't be blank")
      end
    end
  end
end
