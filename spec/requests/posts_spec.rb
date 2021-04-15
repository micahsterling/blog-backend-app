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
  describe "Post /posts" do 
    it "should create a new post in the db" do 
      # make a web request to rails that makes a new post
      user = User.create!(
        email: "frank@email.com",
        password: "password" 
      )

      jwt = JWT.encode(
        {
          user_id: user.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        "HS256" # the encryption algorithm
      )

      post "/api/posts", params: {
        title: "the title",
        body: "the body",
        image: "the image",
      },

      headers: {"Authorization" => "Bearer #{jwt}"}
      # parse the response
      recipe = JSON.parse(response.body)
      # check that the correct data is in the response  
      expect(response).to have_http_status(200)
      expect(post["title"]).to eq("the title")
    end
  end
end
