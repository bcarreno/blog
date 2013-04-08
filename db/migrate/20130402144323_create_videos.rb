class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :null => false
      t.string :youtube_id, :null => false
      t.integer :duration
      t.boolean :is_hd, :default => false
      t.timestamps
    end
  end
end
