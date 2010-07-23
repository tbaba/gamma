Rails.application.config.middleware.insert(Warden::Manager, Rack::OpenID)

Warden::OpenID.configure do |config|
  config.required_fields = User.required_open_id_fields
  config.optional_fields = User.optional_open_id_fields
  config.user_finder do |response|
    user = User.find_by_identity_url(response.identity_url)
    if user.nil?
      user = User.new
      user.extract_open_id_values(response)
      unless user.save
        message = "failed to create user: "
        message << "#{users.errors.full_messages.inspect}"
        message << user.inspect
        Rails.logger.error(message)
        user = nil
      end
    end
    user
  end
end

