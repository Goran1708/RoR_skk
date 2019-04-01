json.extract! ticket, :id, :destination, :departure, :arrival, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
