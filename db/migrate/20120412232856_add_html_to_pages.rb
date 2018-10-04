class AddHtmlToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :html, :text
  end
end
