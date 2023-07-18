class AddAcceptDefaultingToEvento < ActiveRecord::Migration[6.0]
  def change
    add_column :eventos, :aceitar_inadiplentes, :string
    add_reference :eventos, :user, foreign_key: true
  end
end
