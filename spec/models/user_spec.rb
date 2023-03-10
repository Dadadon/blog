require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).is_greater_than_or_equal_to(0).only_integer }
  end

  describe "#recent_posts" do
    let(:user) { FactoryBot.create(:user) }

    it "returns the 3 most recent posts" do
      FactoryBot.create_list(:post, 5, user: user)
      recent_posts = user.recent_posts
      expect(recent_posts.count).to eq(3)
      expect(recent_posts.first.created_at).to be > recent_posts.last.created_at
    end
  end
end

