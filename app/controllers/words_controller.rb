# frozen_string_literal: true

class WordsController < ApplicationController
  before_action :set_search, only: %i[index]
  before_action :word_project, only: %i[create new]
  before_action :authenticate_user!, only: %i[create new]

  def index
    @words_search = @search.result(distinct: true) unless params[:q].nil?
  end

  def new; end

  def create
    flash.now[:warning] = t(".not_file_selected") unless params[:file].present?
    response = ImportWords.perform params[:file], params[:project_ids], current_user.id
    if response
      flash[:success] = t(".file_imported")
      redirect_to root_path
    else
      flash.now[:error] = t(".error_import")
      render :new
    end
  end

  private

  def set_search
    @search = Word.ransack(params[:q])
  end

  def word_project
    @word_project ||= Project.pluck :name, :id
  end
end
