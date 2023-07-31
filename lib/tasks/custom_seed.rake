namespace :db do
  namespace :seed do
    desc 'Load the custom seed data from db/seeds/my_custom_seed.rb '
    task :single => :environment do
      filename = Dir[File.join(Rails.root, 'db', 'seeds', "#{ENV['SEED']}.rb")][0]

      Rails.logger.debug "Seeding #{filename}..."
      load(filename) if File.exist?(filename)
    end
  end
end