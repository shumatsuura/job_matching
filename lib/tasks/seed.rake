Rails.root.glob('db/seeds/**/*.rb').each do |file|
  namespace :seed do
    path_name = file.relative_path_from(Rails.root).sub_ext('').to_s  # db/seeds/<dir>/<file>
    desc "Load the seed data from #{path_name}."

    task_command = path_name.tr("/", ":")  # db:seeds:<dir>:<file>
    task task_command.to_s => :environment do
      load(file)
    end
  end
end
