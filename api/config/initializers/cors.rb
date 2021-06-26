Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins 'http://localhost:8000',
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['access-token', 'client', 'uid']
  end
end