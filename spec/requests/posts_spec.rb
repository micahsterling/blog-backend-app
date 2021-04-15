require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "should return all the posts in the db" do
      # get posts_index_path
      user = User.create!(
        email: "brice@email.com",
        password:  "password",
      )

      Post.create!(
        title: "the title",
        body: "the body",
        image: "the image",
        user_id: user.id,
      )
      get "/api/posts"
      posts = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(posts.length).to eq(1)
    end
  end
 
end
