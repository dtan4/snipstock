class ChangeCommentDescriptionToNotNull < ActiveRecord::Migration
  def change
    change_column :comments, :description, :string, null: false, default: ''
  end
end
