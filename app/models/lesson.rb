require_relative '../../db/database'

class Lesson < Sequel::Model
end

#duplicates = DB[:lessons].select_group(:user_name, :lesson_name).select_append{count('*').as(count)}.having{count('*') > 1}.all
#binding.irb
