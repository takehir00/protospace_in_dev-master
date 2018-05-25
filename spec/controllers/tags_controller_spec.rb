require 'rails_helper'

describe TagsController do

  describe 'DELETE #destroy' do
    it "assigns the requested tag to @tag" do
      tag = create(:tag)
      delete :destroy, id: tag
      expect(assigns(:tag)).to eq tag
    end
  end
end
