json.array!(@routes) do |route|
  json.extract! route, :id, :name, :image
  json.url route_url(route, format: :json)
end
