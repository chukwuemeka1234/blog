require 'rails_helper'

RSpec.describe 'post_index_route', type: :feature do
  describe 'Post' do
    before(:each) do
      first_user = User.create(name: 'Victor', photo: 'link', bio: 'bio', Posts_counter: 0,
                               email: 'anivictor.chukwuemeka.avc@gmail.com', password: 'donbabachi123',
                               password_confirmation: 'donbabachi123')

      visit new_user_session_path
      fill_in 'Email', with: 'anivictor.chukwuemeka.avc@gmail.com'
      fill_in 'Password', with: 'donbabachi123'
      click_button 'Log in'

      @post = Post.create(Title: 'Greetings', text: 'Say Hi', Comments_counter: 1, Likes_counter: 1,
                          author: first_user)
      @posta = Post.create(Title: 'World', text: 'Hello to the world', Comments_counter: 1, Likes_counter: 1,
                           author: first_user)
      @postb = Post.create(Title: 'Sports', text: 'Arsenal wins Chelsea', Comments_counter: 0, Likes_counter: 0,
                           author: first_user)
      @commenta = Comment.create(text: 'Say Hi', author: User.first, post: Post.first)
      @commentb = Comment.create(text: 'What is this', author: User.first, post: Post.first)
      @commentc = Comment.create(text: 'Bond be bond', author: User.first, post: Post.first)

      visit(user_posts_path(first_user.id))
    end

    it 'Check for user profile picture' do
      all('img').each do |i|
        expect(i[:src]).to eq('link')
      end
    end

    it 'Display username' do
      expect(page).to have_content('Victor')
    end

    it 'Display Title' do
      expect(page).to have_content('Greetings')
    end

    it 'Display number of posts' do
      post = Post.all
      expect(post.size).to eql(3)
    end

    it 'Display post number in counter' do
      first_user = User.first
      expect(page).to have_content(first_user.Posts_counter)
    end

    it 'Displays content of the post' do
      expect(page).to have_content 'Say Hi'
    end

    it 'displays first comment' do
      expect(page).to have_content 'Say Hi'
    end

    it 'displays number of comments.' do
      post = Post.first
      expect(page).to have_content(post.Comments_counter)
    end

    it 'displays number of likes' do
      post = Post.first
      expect(page).to have_content(post.Likes_counter)
    end

    it 'redirects after click' do
      click_link 'Greetings'
      expect(page).to have_current_path user_post_path(@post.author_id, @post)
    end
  end
end
