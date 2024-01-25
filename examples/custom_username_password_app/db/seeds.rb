# frozen_string_literal: true

User.create!(username: 'admin', password: '123123') unless User.where(username: 'admin').count.positive?
