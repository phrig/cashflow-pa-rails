desc "Create join tables for filers and transactions"

task create_filer_transactions: :environment do
  TRANSACTION_CLASSES = ['Expense', 'Debt', 'Receipt', 'Contribution']

  TRANSACTION_CLASSES.map do |transaction_class|
    join_table_name = "Filers#{transaction_class.capitalize}s"
    klass = transaction_class.constantize
    klass.all.each do |object|
      filer = Filer.find_by_filer_id_and_election_cycle(object.filer_id, object.election_cycle)
      join_table = join_table_name.constantize.new
      join_table.filer_id = filer.id
      object_id_attribute = "#{transaction_class.downcase}_id"
      join_table.write_attribute(object_id_attribute.to_sym, object.id)
      join_table.save
    end
  end
end