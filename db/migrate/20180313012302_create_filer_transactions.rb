class CreateFilerTransactions < ActiveRecord::Migration[5.1]
  def change
    create_join_table :filers, :expenses, table_name: 'filers_expenses'
    create_join_table :filers, :debts, table_name: 'filers_debts'
    create_join_table :filers, :receipts, table_name: 'filers_receipts'
    create_join_table :filers, :contributions, table_name: 'filers_contributions'
  end
end
