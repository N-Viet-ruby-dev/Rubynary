# frozen_string_literal: true

class SearchHistoryService
  class << self
    def perform(params_q, projects_search, params_commit, user)
      return unless params_commit.present?

      keyword_in_history = History.where(keyword: params_q, user_id: user).pluck(:id)
      if keyword_in_history.blank?
        create_history(params_q, projects_search, user)
      else
        check_project(params_q, keyword_in_history, projects_search, user)
      end
    end

    private

    def create_history(params_q, projects_search, user)
      @history = History.create(keyword: params_q, user_id: user)
      projects = Project.where(id: projects_search)
      projects&.each do |project|
        project.project_histories.create(history_id: @history.id)
      end
    end

    def update_history(history_id)
      History.find(history_id).touch(:updated_at)
    end

    def check_project(params_q, keyword_in_history, projects_search, user)
      hash_keyword_projects = keyword_in_history.each_with_object({}) do |id, hash|
        hash[id] = ProjectHistory.where(history_id: id).pluck(:project_id)
      end
      convert_project_id = []
      convert_projects_search_id(convert_project_id, projects_search)
      if hash_keyword_projects.values.include? convert_project_id.sort
        update_history(hash_keyword_projects.key(convert_project_id.sort))
      else
        create_history(params_q, projects_search, user)
      end
    end

    def convert_projects_search_id(convert_project_id, projects_search)
      projects_search&.each do |f|
        convert_project_id.push(f.to_i)
      end
    end
  end
end
