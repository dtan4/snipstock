class AddDefaultLangToSnippets < ActiveRecord::Migration
  def change
    change_column :snippets, :lang, :string, null: false, default: 'text'
  end
end
