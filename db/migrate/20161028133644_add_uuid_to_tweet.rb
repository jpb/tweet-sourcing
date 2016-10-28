class AddUuidToTweet < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :uuid, :string
  end
end
