
20.times do
  user = User.create(first_name: Faker::Name.first_name,
                     last_name: Faker::Name.last_name,
                     email: Faker::Internet.email,
                     password: "password",
                     password_confirmation: "password",
                     gender: ["Male","Female"].sample,
                     date_of_birth: DateTime.now - rand(10..30).year,
                     address: Faker::Address.full_address,
                     phone_number: Faker::PhoneNumber.cell_phone,
                     race: ["White","Black","Yellow"].sample,
                     religion: ["Christian","Buddhist","Muslim"].sample,
                     expected_salary: (100..10000).to_a.sample,
                     status: ["Actively Looking","Closed","Open for Opportunity"].sample,
                     description: description = Faker::Lorem.paragraph,
                   )

  user.educations.create(
    school_name: Faker::Educator.university,
    major: Faker::Educator.subject,
    period_start: DateTime.now - rand(10).week,
    period_end: DateTime.now - rand(10).week,
  )

  user.languages.create(
    name: Faker::Nation.language,
    level: rand(1..4),
  )

  user.desired_industries.create(
    industry_id: rand(1..2)
  )

  user.work_experiences.create(
    company: Faker::Company.name,
    position: Faker::Job.position,
    period_start: DateTime.now - rand(10).week,
    period_end: DateTime.now - rand(10).week,
    currently_employed: true,
    description: Faker::Lorem.paragraphs,
    salary: (100..10000).to_a.sample,
  )

  user.user_skills.create(
    name: Faker::Job.key_skill,
  )

  user.qualifications.create(
    name: ["CPA","Lawyer","Doctor","CFA","Driving","IT Passport","Book Keeping","FP"].sample,
    date_of_acquisition: DateTime.now - rand(10).week,
  )

  user.desired_job_categories.create(
    job_category_id: rand(1..2),
  )
end

#Companyの作成
20.times do
  company = Company.create(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    phone_number: Faker::PhoneNumber.cell_phone,
    location: Faker::Nation.capital_city,
    address: Faker::Address.full_address,
    number_of_employees: rand(2..10000),
    date_of_incorporation: DateTime.now - rand(1..100).year,
    paid_up_capital: rand(2..10000000),
    # logo: null,
    # header_image: null,
    # image: null,
    email_for_inquiry: Faker::Internet.email,
    member_status: rand(0..3),
  )

  company.industry_relations.create(
    industry_id: rand(1..2)
  )

  company.company_skills.create(
    name: Faker::Job.key_skill
  )

  #Comnayに紐づくPostの作成
  10.times do
    post = company.posts.create(
      title: Faker::Job.title,
      salary: rand(10000..1000000),
      number_of_recruits: rand(1..5),
      position: Faker::Job.position,
      description: Faker::Lorem.paragraphs,
      location: Faker::Nation.capital_city,
    )

    post.post_industries.create(
      industry_id: rand(1..2)
    )

    post.post_job_categories.create(
      job_category_id: rand(1..4)
    )

    post.post_skills.create(
      company_skill_id: company.company_skills.sample
    )

    #ユーザーを5人選んで、当該ポストにapplyさせる
    users = User.all.sample(5)
    users.each do |user|
      apply = user.applies.create(post_id: post.id)
      #ユーザーからのメッセージを作成
      apply.apply_messages.create(
        body: Faker::Lorem.sentence,
        user_id: user.id,
        # company_id: null,
      )
      #カンパニーからのメッセージを作成
      apply.apply_messages.create(
        body: Faker::Lorem.sentence,
        # user_id: null,
        company_id: post.company_id,
      )
    end

    #ユーザーを3人選んで、当該ポストをlikeさせる
    users = User.all.sample(3)
    users.each do |user|
      user.like_posts.create(
        post_id: post.id
      )
    end
  end

  #スカウトの作成
  users = User.all.sample(5)
  users.each do |user|
    scout = company.scouts.create(user_id: user.id)
    #ユーザーからのメッセージを作成
    scout.scout_messages.create(
      body: Faker::Lorem.sentence,
      company_id: company.id,
      # user_id: null,
    )
    #カンパニーからのメッセージを作成
    scout.scout_messages.create(
      body: Faker::Lorem.sentence,
      # company_id: null,
      user_id: user.id,
    )
  end

  #LikeUserの作成
  users = User.all.sample(5)
  users.each do |user|
    company.like_users.create(user_id: user.id)
  end

end
