require "csv"

CSV.foreach('db/seeds/industry.csv', headers: true) do |row|
  Industry.create(name: row['Name']
                )
end
