# frozen_string_literal: true

namespace :list_tasks do
  desc "Destroy after 1 month"
  task auto_destroy: :environment do
    History.where("created_at < ?", 1.month.ago).destroy_all
  end
end
