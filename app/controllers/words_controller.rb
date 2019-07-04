# frozen_string_literal: true

class WordsController < ApplicationController
  def index
    @words = Word.all
  end
end
