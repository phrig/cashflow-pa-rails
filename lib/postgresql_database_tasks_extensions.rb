module PostgreSQLDatabaseTasksExtensions
  def drop
    establish_master_connection
    pid_column = PG.library_version >= 90200 ? 'pid' : 'procpid'
    connection.select_all %Q(
      SELECT pg_terminate_backend(pg_stat_activity.#{pid_column})
      FROM pg_stat_activity
      WHERE datname = '#{configuration['database']}'
        AND #{pid_column} <> pg_backend_pid();
    )
    super
  end
end

module ActiveRecord
  module Tasks
    class PostgreSQLDatabaseTasks
      prepend PostgreSQLDatabaseTasksExtensions
    end
  end
end
