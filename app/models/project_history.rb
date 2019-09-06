# frozen_string_literal: true

class ProjectHistory < ApplicationRecord
  belongs_to :project
  belongs_to :history
end
