require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_second) { FactoryBot.create(:user_second) }
  before do
    @conversation = create(:conversation)
  end
  describe "scope" do
    describe "test" do
        let!(:message) { create(:message, sender_id: user.id, receiver_id: user_second.id) }
        subject { Conversation.message }
        it { is_expected.to include message}
    end
  end
  
 
  
end
