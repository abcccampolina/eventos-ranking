class CreateJoinTableEventoUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :eventos, :users do |t|
      # t.index [:evento_id, :user_id]
      # t.index [:user_id, :evento_id]
    end
  end
end
