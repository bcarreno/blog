# encoding: utf-8

class SeedVideos < ActiveRecord::Migration
  def up
    [
      ['Test 1', 4 * 60 + 37, Date.new(2012, 11, 17, 2012), false, 'abcde'],
      ['Test 2', 9 * 60 + 23, Date.new(2012, 6, 30, 2012), false, 'fghij'],
    ].each do |video|
      execute <<-EOT
        insert into videos (title, duration, created_at, updated_at, is_hd, youtube_id)
        values ('#{video[0]}', #{video[1]}, '#{video[2]}', '#{video[2]}', #{video[3]}, '#{video[4]}')
      EOT
    end
  end

  def down
    execute "delete from videos"
  end
end
