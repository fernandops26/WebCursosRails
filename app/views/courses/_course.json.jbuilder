json.extract! course, :id, :titulo, :contenido, :category_id, :fecha, :estado, :created_at, :updated_at
json.url course_url(course, format: :json)