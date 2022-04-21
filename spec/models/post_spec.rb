require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Post model' do
    first_user = User.create(name: 'Victor', bio: 'Rails programmer.')
    subject { Post.new(Title: 'Developer', text: 'Coding and solving problems', author_id: first_user) }
    before { subject.save }

    it 'Checks if title is filled' do
      subject.Title = nil
      expect(subject).to_not be_valid
    end

    # rubocop:disable Layout/LineLength
    it 'Checks character count' do
      subject.Title = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ultrices dui eu tempor suscipit. Ut sagittis risus nisi, fermentum ultricies arcu interdum et. Aenean interdum pretium magna. Etiam efficitur aliquam vestibulum. Duis convallis odio nisi. Cras sagittis sagittis turpis, non tincidunt augue sagittis at. Vivamus nec dui et lectus venenatis porttitor. Sed ut sagittis leo, egestas porttitor.'
      expect(subject).to_not be_valid
    end

    # rubocop:enable Layout/LineLength

    it 'loads 5  recent comments ' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end

    it 'checks likes value' do
      expect(subject.Likes_counter).to be >= 0
    end

    it 'checks comments value' do
      expect(subject.Comments_counter).to be >= 0
    end

    it 'checks counter numericality' do
      subject.Comments_counter = 'one'
      expect(subject).to_not be_valid
    end

    it 'checks likes numericality' do
      subject.Likes_counter = 'one'
      expect(subject).to_not be_valid
    end
  end
end
