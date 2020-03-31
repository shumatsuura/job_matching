require "csv"

CSV.foreach('db/seed/job_category.csv', headers: true) do |row|
  JobCategory.create(name: row['Name']
                )
end
