# frozen_string_literal: true

class ProjectWord < ApplicationRecord
  belongs_to :project
  belongs_to :word
end
