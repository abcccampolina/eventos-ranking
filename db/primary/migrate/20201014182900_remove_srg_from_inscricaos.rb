class RemoveSrgFromInscricaos < ActiveRecord::Migration[6.0]
  def change
    remove_reference :inscricaos, :srg_animal, null: false, foreign_key: true
  end
end
