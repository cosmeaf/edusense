Sequel.migration do
  change do
    create_table(:lessons) do
      primary_key :id
      String :user_name
      Integer :lesson_id
      String :lesson_name
      String :lesson_type
      String :course_name
      Integer :id_lxp_course
      String :status_lesson
      String :total_time
      String :lxp_like
      DateTime :first_access
      DateTime :last_access
      DateTime :completed_at
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
