# frozen_string_literal: true

require "rails_helper"

RSpec.describe Word, type: :model do
  it { should validate_presence_of(:en) }
  it { should validate_presence_of(:ja) }
  it { should validate_presence_of(:vi) }
end
