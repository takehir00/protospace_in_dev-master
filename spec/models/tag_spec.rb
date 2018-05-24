
require 'rails_helper'

describe Tag do
  describe '#create' do

    it "is invalid without a name" do
      tag = build(:tag, name:"")
      tag.valid?
      expect(tag.errors[:name]).to include("can't be blank")
    end

  end
end
