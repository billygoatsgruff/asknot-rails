module Helpers
  module Requests
    def json
      @json ||= JSON.parse(response.body)
    end

    def errors
      json['errors'].to_s if json['errors']
    end

    def token(user = nil)
      if user
        user.api_key
      else
        create(:user).api_key
      end
    end

    def accept_header
      'application/json'
    end

    def accept_headers
      { 'Accept' => accept_header,
        'Content-Type' => 'application/json' }
    end

    def authorization_header(user = nil)
      "#{token(user)}"
    end

    def authorization_headers(user = nil)
      accept_headers.merge('X-Api-Key' => authorization_header(user))
    end
  end
end
