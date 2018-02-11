module TransactionConcern
  extend ActiveSupport::Concern

  def filer
    Filer.find_by_filer_id_and_election_cycle(filer_id, election_cycle)
  end
end
