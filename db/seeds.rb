# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin_email = Rails.application.credentials.admin[:email]
admin_password = Rails.application.credentials.admin[:password]


User.create!(
    email: admin_email,
    password: admin_password,
    password_confirmation: Rails.application.credentials.admin.password,
    role: 0,
    first_name: 'CropConnect Admin',
    last_name: 'Admin',
    contact_number: 'N/A',
    address: 'N/A',
    created_at: Time.current,
    updated_at: Time.current
  )
  