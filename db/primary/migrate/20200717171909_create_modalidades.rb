class CreateModalidades < ActiveRecord::Migration[6.0]
  def change
    create_table :modalidades do |t|
      t.string :nome

      t.timestamps
    end
  end
end
