class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships, id: false do |t|
      t.column :user_id, :integer
      t.column :event_id, :integer
    end
  end
end
