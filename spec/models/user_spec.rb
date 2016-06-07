require 'rails_helper'

RSpec.describe User, type: :model do
  let(:my_user) { create(:user) }

  describe "upon creation of new user" do
    it "new user should have role: 'standard'" do
      expect(my_user.role).to eq('standard')
    end
  end
end
