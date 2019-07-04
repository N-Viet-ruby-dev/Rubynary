# frozen_string_literal: true

class WordsController < ApplicationController
  before_action :set_search, only: [:search, :default]
  
  def index
    @words = Word.all
  end

  def search
    @words = @search.result(distinct: true)
  end

  private
  def set_search
    @search = Word.ransack(params[:q])
  end
end
