class RemoveColumnOrganizationIdToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column(:users, :organization_id, :integer) if column_exists? :users, :organization_id
  end
end
