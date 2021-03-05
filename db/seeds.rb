# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
  User.create(name: 'Admin', email: 'admin@test.com', password: 'secure', role: 'admin')
  User.create(name: 'User', email: 'user@test.com', password: 'secure', role: 'user')
