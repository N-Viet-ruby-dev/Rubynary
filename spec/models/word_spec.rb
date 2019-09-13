# frozen_string_literal: true

require "rails_helper"

RSpec.describe Word, type: :model do
  it { should validate_presence_of(:en) }
  it { should validate_presence_of(:ja) }
  it { should validate_presence_of(:vi) }
  it { should validate_length_of(:en).is_at_most(255) }
  it { should validate_length_of(:ja).is_at_most(255) }
  it { should validate_length_of(:vi).is_at_most(255) }
  it { should validate_length_of(:description).is_at_most(255) }
end
