eval File.read("#{Rails.root}/config/environments/development.rb")

<REPLACEME:ApplicationName>::Application.configure do
  config.middleware.insert_after(ActionDispatch::Static, Rack::LiveReload)
end
