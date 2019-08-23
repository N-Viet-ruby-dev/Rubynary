# frozen_string_literal: true

class WordsController < ApplicationController
  before_action :word_project, only: %i[create new]
  before_action :word, only: %i[destroy update edit]
  before_action :authenticate_user!
  LIMIT_SUGGESTIONS = 9

  def index
    @projects = Project.all
    return if params[:q].nil?

    History.create keyword: params[:q], user_id: current_user.id if current_user.present? && params[:q].present?
    @words = if params[:search_project].nil?
               Word.ransack(ja_or_vi_or_en_cont: params[:q]).result(distinct: true)
             else
               Word.ransack(ja_or_vi_or_en_cont: params[:q]).result(distinct: true)
                   .joins(:projects).where(projects: { id: params[:search_project] })
             end
             .page(params[:page]).per(3)
    if @words.empty?
      flash.now[:warning] = t(".find_result")
    else
      respond_to do |format|
        format.html {}
        format.js
        format.json do
          @words = @words.limit(LIMIT_SUGGESTIONS)
        end
      end
    end
  end

  def edit; end

  def update
    @words = Word.all
    suggested_word = @word.suggested_words.last
    if params[:approval] == "approval"
      suggested_word.update(status: 1)
      @word.update(word_params.merge(last_update_by_id: suggested_word.created_by_id))
    else
      suggested_word.update(status: 2)
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.js
    end
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

  def word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:suggested_word).permit :ja, :en, :vi, :description
  end

  def word_project
    @word_project ||= Project.pluck :name, :id
  end
end
