class AddTextToTweet < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :text, :string
  end
end
