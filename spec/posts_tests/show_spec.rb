require 'rails_helper'

RSpec.describe 'post_show_route', type: :feature do
  describe 'Post' do
    before(:each) do
      @first_user = User.create(name: 'Victor', photo: 'link', bio: 'Programmer from Nigeria', Posts_counter: 0,
                                email: 'blanac@gmail.com', password: '123456', password_confirmation: '123456')
      @second_user = User.create(name: 'Jik', photo: 'link', bio: 'Software developer', Posts_counter: 0,
                                 email: 'blancaa@gmail.com', password: '123456', password_confirmation: '123456')
      @third_user = User.create(name: 'Downey', photo: 'link', bio: 'downey is not junior', Posts_counter: 0,
                                email: 'downeyy@gmail.com', password: '123456', password_confirmation: '123456')

      visit new_user_session_path
      fill_in 'Email', with: 'blanac@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'

      @post = Post.create(Title: 'First Post', text: 'This is the first post', Comments_counter: 0, Likes_counter: 0,
                          author: @first_user)
      @posta = Post.create(Title: 'Second Post', text: 'This is the second post', Comments_counter: 0,
                           Likes_counter: 0, author: @second_user)
      @postb = Post.create(Title: 'Third Post', text: 'This is the third post', Comments_counter: 0, Likes_counter: 0,
                           author: @third_user)

      @commenta = Comment.create(text: 'Thy shall not find', author: User.first, post: Post.first)
      @commentb = Comment.create(text: 'Her majesty Lady Whistledown', author: User.first, post: Post.first)
      @commentc = Comment.create(text: 'It was astounding', author: User.first, post: Post.first)
      visit user_post_path(@first_user.id, @post.id)
    end

    it 'Display username' do
      expect(page).to have_content('Victor')
    end

    it 'displays number of posts' do
      post = Post.all
      expect(post.size).to eql(3)
    end

    it 'displays user bio' do
      expect(page).to have_content('is')
    end

    it 'displays users 3 posts' do
      expect(page).to have_content('First Post')
    end

    it 'displays content of comments' do
      expect(page).to have_content('Thy shall not find')
    end

    it 'displays number of comments' do
      post = Post.first
      expect(post.Comments_counter).to eql(3)
    end
  end
end
