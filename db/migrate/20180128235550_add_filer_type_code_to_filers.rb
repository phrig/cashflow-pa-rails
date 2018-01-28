class AddFilerTypeCodeToFilers < ActiveRecord::Migration[5.1]
  def change
    add_column :filers, :filer_type_code, :string
  end
end
