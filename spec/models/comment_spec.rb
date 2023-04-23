require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント登録' do
    before do
      user = FactoryBot.create(:user)
      sheet = FactoryBot.create(:sheet, user:)
      @comment = FactoryBot.build(:comment, user:, sheet:)
    end
    context '登録できる場合' do
      it 'textが存在すれば登録できる' do
        expect(@comment).to be_valid
      end
      it 'textが100文字以下であれば登録できる' do
        expect(@comment).to be_valid
      end
      it 'userが紐づいていれば登録できる' do
        expect(@comment).to be_valid
      end
      it 'sheetが紐づいていれば登録できる' do
        expect(@comment).to be_valid
      end
    end
    context '登録できない場合' do
      it 'textが空では登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it 'textが101文字以上では登録できない' do
        @comment.text = Faker::Lorem.characters(number: 101)
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Text is too long (maximum is 100 characters)')
      end
      it 'userが紐づいていなければ登録できない' do
        @comment.user_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end
      it 'sheetが紐づいていなければ登録できない' do
        @comment.sheet_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Sheet must exist')
      end
    end
  end
end
