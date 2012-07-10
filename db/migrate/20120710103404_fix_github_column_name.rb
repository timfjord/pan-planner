class FixGithubColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :github_url, :github_username
  end
end
