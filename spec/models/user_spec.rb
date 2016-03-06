require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:slack_pics)}
  it { should have_attached_file(:image)}
  it { should have_attached_file(:stache_image)}
  it { should have_attached_file(:stached_user_image)}
  it { should validate_attachment_content_type(:image).allowing('image/jpeg', 'image/gif', 'image/png', 'image/jpg')}
  it { should validate_attachment_content_type(:stache_image).allowing('image/jpeg', 'image/gif', 'image/png', 'image/jpg')}
end
