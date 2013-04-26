class DropSnippetsTagsTable < ActiveRecord::Migration
  def change
    drop_table :snippets_tags
  end
end
