# frozen_string_literal: true

class Word < ApplicationRecord
  validates :ja, presence: true
  validates :en, presence: true
  validates :vi, presence: true
end
