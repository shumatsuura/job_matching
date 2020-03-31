require "csv"

CSV.foreach('db/seeds/job_category.csv', headers: true) do |row|
  JobCategory.create(name: row['Name']
                )
end
