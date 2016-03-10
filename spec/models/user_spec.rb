require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to :slack_team }
  it { should respond_to :name }
  it { should respond_to :uid }
end
