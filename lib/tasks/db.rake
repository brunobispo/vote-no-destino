namespace :db do
  desc "Checks to see if the database exists"
  task exists: [:available] do
    begin
      Rake::Task['environment'].invoke
      ActiveRecord::Base.connection
    rescue
      exit 1
    else
      exit 0
    end
  end

  task :available do
    begin
      ActiveRecord::Base
        .establish_connection(configuration.merge database: 'postgres')
        .connection
    rescue PG::ConnectionBad
      puts 'Waiting database availability...'
      sleep 5
      retry
    end
  end

  def configuration
    Rails.application.config.database_configuration['default']
  end
end
