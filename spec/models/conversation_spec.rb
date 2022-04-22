require 'rails_helper'

RSpec.describe '会話機能', type: :model do
  before do
    @user= FactoryBot.create(:user) 
   @user_second= FactoryBot.create(:user_second) 
  end
  describe "会話機能のバリデーションテスト" do
    context 'senderとreceiverの組み合わせが初めての場合、' do
      it 'バリデーションがなくてConversationが作成される' do
        conversation = Conversation.new(
        sender_id: @user.id,
        receiver_id: @user_second.id )
        expect(conversation).to be_valid
      end
    end
    context 'senderとreceiverの組み合わせが初めてじゃない場合' do
      it 'バリデーションが発生' do
        conversation = Conversation.new(
            sender_id: @user.id,
            receiver_id: @user_second.id) 
        conversation2 = Conversation.new(
        sender_id: conversation.sender_id,
        receiver_id: conversation.receiver_id)
        expect(conversation2.valid?).to eq true;
       end
    end
  end
end
