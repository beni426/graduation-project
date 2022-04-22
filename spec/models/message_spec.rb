require 'rails_helper'

RSpec.describe 'メッセージ機能', type: :model do
  before do
   @user= FactoryBot.create(:user) 
   @user_second= FactoryBot.create(:user_second) 
   @conversation = Conversation.create(sender_id: @user.id,receiver_id: @user_second.id)
   end
   describe "メッセージ送信機能" do
      context '空のメッセージを送ると、' do
        it 'バリデーションに引っかかるる' do
            message= Message.new(
              body: nil,
              conversation_id: @conversation.id,
              user_id:  @user.id)
               expect(message).not_to be_valid
            end
        end
       context 'メッセージを入力する場合' do
          it 'バリデーションがとおる' do
            message= Message.new(
                body: 'バリデーションが通る',
                conversation_id: @conversation.id,
                user_id:  @user.id)
             expect(message).to be_valid
           end
         end
    end
end
