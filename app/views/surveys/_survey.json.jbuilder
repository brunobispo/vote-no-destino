json.extract! survey, :id, :created_at, :updated_at
json.options survey.options do |option|
  json.id option.id
  json.name option.name
  json.score option.score
end
json.url survey_url(survey, format: :json)