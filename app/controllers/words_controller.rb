# frozen_string_literal: true

class WordsController < ApplicationController
  before_action :word_project, only: %i[create new]
  before_action :word, only: %i[destroy update edit]
  before_action :check_lead_comtor, only: %i[destroy]
  LIMIT_SUGGESTIONS = 9

  def index
    @projects = Project.all
    return if params[:q].nil?

    @words = check_params_q_search
    check_result(@words)
    search_history_service
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

  def new
    redirect_to :root if current_user.developer?
  end

  def create
    return if current_user.developer?

    import
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

  def check_result(words)
    if words.empty?
      flash.now[:warning] = t(".find_result")
    else
      respond_to do |format|
        format.html {}
        format.js
        format.json do
          words = words.limit(LIMIT_SUGGESTIONS)
        end
      end
    end
  end

  def params_q_search
    Word.ransack(ja_or_vi_or_en_cont: params[:q]).result(distinct: true)
  end

  def check_params_q_search
    if params[:search_project].nil?
      params_q_search
    else
      params_q_search.joins(:projects).where(projects: { id: params[:search_project] })
    end
      .page(params[:page]).per(3)
  end

  def import
    count_created, rows_error = ImportWords.perform params[:file], params[:project_ids], current_user.id
    check_import(count_created, rows_error)
    redirect_to new_word_path
  end

  def check_import(count_created, rows_error)
    if count_created.positive?
      flash[:warning] = "#{rows_error.size} " + t(".error_import") + rows_error.to_s if rows_error.size.positive?
      flash[:info] = count_created.to_s + t(".success_import")
    else
      flash[:error] = t(".file_error_import")
    end
  end

  def search_history_service
    SearchHistoryService.perform params[:q], params[:search_project], params[:commit], current_user.id
  end
end
