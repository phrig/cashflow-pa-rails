class AddIndexToFilers < ActiveRecord::Migration[5.1]
  def change
    add_index :filers, [:filer_id, :election_cycle]
  end
end
