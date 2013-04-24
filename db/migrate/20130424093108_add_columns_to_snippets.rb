class AddColumnsToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :title, :string, null: false, default: 'no title'
    add_column :snippets, :description, :text
    add_column :snippets, :user_id, :integer
  end
end
