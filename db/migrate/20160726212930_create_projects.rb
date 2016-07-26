class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :status
      t.datetime :valid_till
      t.float :discount
      t.text :notes
      t.text :terms
      t.string :code

      t.timestamps
    end
  end
end
