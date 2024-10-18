require 'httparty'
require_relative 'edusense'
require_relative '../app/models/lesson'

class Scraper
  include HTTParty

  LOGIN_CITY_MAP = [
    OpenStruct.new(city: 'Itabira', input_login: '@pditabira.com'),
    OpenStruct.new(city: 'Bom Despacho', input_login: '@pdbomdespacho.com')
  ].freeze

  def initialize; end

  def run
    LOGIN_CITY_MAP.each do |login|
      run_city(login.city, login.input_login)
    end
  end

  private

  def run_city(city, input_login)
    login_resp = login!
    page = 0
    lessons = list_lessons(Date.today - 30, Date.today, input_login, page)
    while (lessons.dig('data')&.size || 0) > 0
      puts " - [#{city}] Page: #{page} - Total records: #{lessons.dig('recordsTotal')}"
      lessons.dig('data').each do |lesson|
        lesson_record = Lesson.find(lesson_id: lesson.dig('lesson_id'), user_name: lesson.dig('user_name'))
        # puts lesson
        if lesson_record.nil?
          puts " - [#{city}] Saving lesson: #{lesson.dig('lesson_id')} - #{lesson.dig('user_name')}"
          Lesson.create(
            user_name: lesson.dig('user_name'),
            lesson_id: lesson.dig('lesson_id'),
            lesson_name: lesson.dig('lesson_name'),
            lesson_type: lesson.dig('lesson_type'),
            course_name: lesson.dig('course_name'),
            id_lxp_course: lesson.dig('id_lxp_course'),
            status_lesson: lesson.dig('status_lesson'),
            total_time: lesson.dig('total_time'),
            lxp_like: lesson.dig('lxp_like'),
            first_access: lesson.dig('first_access'),
            last_access: lesson.dig('last_access'),
            completed_at: lesson.dig('completed_at'),
            created_at: lesson.dig('created_at'),
            city: city
          )
        else
          puts " - [#{city}] Update lesson: #{lesson.dig('lesson_id')} - #{lesson.dig('user_name')}"
          lesson_record.update(
            lesson_name: lesson.dig('lesson_name'),
            lesson_type: lesson.dig('lesson_type'),
            course_name: lesson.dig('course_name'),
            id_lxp_course: lesson.dig('id_lxp_course'),
            status_lesson: lesson.dig('status_lesson'),
            total_time: lesson.dig('total_time'),
            lxp_like: lesson.dig('lxp_like'),
            first_access: lesson.dig('first_access'),
            last_access: lesson.dig('last_access'),
            completed_at: lesson.dig('completed_at'),
            created_at: lesson.dig('created_at'),
            city: city
          )
        end
      end
      page += 1
      lessons = list_lessons(Date.today - 30, Date.today, input_login, page)
      puts 'Done!'
      # binding.irb
    end
  end

  def login!
    response = self.class.post(
      Edusense::SINGIN_URL, {
        headers: {
          "Content-Type": 'application/json;charset=UTF-8',
          Authorization: "Basic #{Base64.strict_encode64('bot@matheusrodela.com:PProjetodesenvolve4')}"
        }
      }
    )

    raise 'Login failed' unless [200, 2001].include?(response.code)

    @cookie = response.headers['set-cookie']
  end

  def list_lessons(date_begin, date_end, input_login, page = 0)
    raise 'Invalid dates' if date_begin.nil? || date_end.nil?

    data = {
      'draw' => 1,
      'columns[0][data]' => 'user_name',
      'columns[0][name]' => nil,
      'columns[0][searchable]' => true,
      'columns[0][orderable]' => true,
      'columns[0][search][value]' => nil,
      'columns[0][search][regex]' => false,
      'columns[1][data]' => 'lesson_name',
      'columns[1][name]' => nil,
      'columns[1][searchable]' => true,
      'columns[1][orderable]' => true,
      'columns[1][search][value]' => nil,
      'columns[1][search][regex]' => false,
      'columns[2][data]' => 'lesson_type',
      'columns[2][name]' => nil,
      'columns[2][searchable]' => true,
      'columns[2][orderable]' => true,
      'columns[2][search][value]' => nil,
      'columns[2][search][regex]' => false,
      'columns[3][data]' => 'course_name',
      'columns[3][name]' => nil,
      'columns[3][searchable]' => true,
      'columns[3][orderable]' => true,
      'columns[3][search][value]' => nil,
      'columns[3][search][regex]' => false,
      'columns[4][data]' => 'status_lesson',
      'columns[4][name]' => nil,
      'columns[4][searchable]' => true,
      'columns[4][orderable]' => true,
      'columns[4][search][value]' => nil,
      'columns[4][search][regex]' => false,
      'columns[5][data]' => 'lxp_like',
      'columns[5][name]' => nil,
      'columns[5][searchable]' => true,
      'columns[5][orderable]' => true,
      'columns[5][search][value]' => nil,
      'columns[5][search][regex]' => false,
      'columns[6][data]' => 'total_time',
      'columns[6][name]' => nil,
      'columns[6][searchable]' => true,
      'columns[6][orderable]' => true,
      'columns[6][search][value]' => nil,
      'columns[6][search][regex]' => false,
      'columns[7][data]' => 'first_access',
      'columns[7][name]' => nil,
      'columns[7][searchable]' => true,
      'columns[7][orderable]' => true,
      'columns[7][search][value]' => nil,
      'columns[7][search][regex]' => false,
      'columns[8][data]' => 'last_access',
      'columns[8][name]' => nil,
      'columns[8][searchable]' => true,
      'columns[8][orderable]' => true,
      'columns[8][search][value]' => nil,
      'columns[8][search][regex]' => false,
      'columns[9][data]' => 'completed_at',
      'columns[9][name]' => nil,
      'columns[9][searchable]' => true,
      'columns[9][orderable]' => true,
      'columns[9][search][value]' => nil,
      'columns[9][search][regex]' => false,
      'order[0][column]' => 9,
      'order[0][dir]' => 'desc',
      'start' => page * 100,
      'length' => 100,
      'search[value]' => nil,
      'search[regex]' => false
    }

    query = {
      combo_user_status: nil,
      combo_course: nil,
      combo_lesson: nil,
      input_dt_begin: date_begin.strftime('%Y-%m-%d'),
      input_dt_end: date_end.strftime('%Y-%m-%d'),
      input_name: nil,
      input_login: input_login,
      input_sup: nil
    }
    url = "#{Edusense::LESSON_USER_URL}?#{URI.encode_www_form(query)}"

    self.class.post(
      url,
      {
        headers: {
          "Content-Type": 'application/x-www-form-urlencoded',
          Cookie: @cookie
        },
        body: data
      }
    )
  end
end
