json.array!(@shelves) do |shelf|
  json.extract! shelf, :title, :author, :year
  json.url shelf_url(shelf, format: :json)
end
