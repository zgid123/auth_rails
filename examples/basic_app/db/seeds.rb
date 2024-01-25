# frozen_string_literal: true

User.create!(email: 'admin@gmail.com', password: '123123') unless User.where(email: 'admin@gmail.com').count.positive?
