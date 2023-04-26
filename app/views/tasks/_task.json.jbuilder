json.extract! task, :id, :title, :user_id, :dietitian_id, :patient_id, :created_at, :updated_at
json.url task_url(task, format: :json)
