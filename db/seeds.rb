# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  Cat.destroy_all

  cat1 = Cat.create!(birthdate: '2010/11/14', color: 'tuxedo', name: 'Charlie', sex: 'M', description: 'A cat for the ages')

  cat2 = Cat.create!(birthdate: '2012/3/14', color: 'white', name: 'Albert', sex: 'M', description: 'One of the smartest cats of the twenty-first century')

  cat3 = Cat.create!(birthdate: '2014/5/1', color: 'tortoiseshell', name: 'Joseph', sex: 'M', description: 'An aspiring playwright')

  cat4 = Cat.create!(birthdate: '2020/3/10', color: 'calico', name: 'Steph', sex: 'F', description: 'A modern cat')

  cat5 = Cat.create!(birthdate: '2019/6/17', color: 'orange', name: 'Stravinsky', sex: 'F', description: 'An avant-garde cat')
end