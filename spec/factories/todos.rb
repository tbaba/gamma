# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :todo do |f|
  f.summary "MyString"
  f.detail "MyString"
  f.progress 1
  f.user nil
end
