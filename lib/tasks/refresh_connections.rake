namespace :background_jobs do
  desc 'Refresh all connections'
  task refresh_connections: :environment do
    Connection.where('next_refresh < :current', current: Time.now).find_each do |connection|
      RefreshConnectionService.new(connection).call
    end
  end
end
