class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.string :email
      t.text :body

      t.timestamps
    end
  end
end
