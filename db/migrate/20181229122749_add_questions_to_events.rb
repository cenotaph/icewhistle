class AddQuestionsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :question1, :text
    add_column :events, :question2, :text
    add_column :events, :question3, :text
    add_column :events, :reg_limit, :integer
  end
end
