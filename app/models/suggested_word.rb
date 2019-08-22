# frozen_string_literal: true

class SuggestedWord < ApplicationRecord
  validates :ja, presence: true
  validates :en, presence: true
  validates :vi, presence: true
  belong_to :word
  enum status: %i[waiting approved disapproved]
end
