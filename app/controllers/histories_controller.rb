# frozen_string_literal: true

class HistoriesController < ApplicationController
  def index
    @histories = current_user.histories.order("created_at DESC")
  end
end
