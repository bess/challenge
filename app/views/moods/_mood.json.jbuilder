json.extract! mood, :id, :user_id, :date, :mood, :description, :created_at, :updated_at
json.url mood_url(mood, format: :json)
