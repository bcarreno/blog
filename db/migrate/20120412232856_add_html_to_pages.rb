class AddHtmlToPages < ActiveRecord::Migration
  def change
    add_column :pages, :html, :text
  end
end
