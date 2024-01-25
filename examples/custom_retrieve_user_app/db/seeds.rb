# frozen_string_literal: true

User.create!(username: 'admin', email: 'admin@gmail.com', password: '123123') unless User.where(username: 'admin', email: 'admin@gmail.com').count.positive?
