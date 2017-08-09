require 'rails_helper'

describe 'current_users endpoints' do
  describe 'GET /current_user' do
    context 'authenticated user' do
      it 'returns JSON for the current user' do
        user = create(:user)

        get(api_v1_current_user_url, {}, authorization_headers(user))

        expect(response).to have_http_status :ok
        expect(response).to match_response_schema :user
      end
    end

    context 'unauthenticated user' do
      it 'returns a 401 - Unauthorized response' do
        get(api_v1_current_user_url, {}, accept_headers)

        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'PATCH /current_user' do
    context 'authenticated user' do
      it 'returns JSON for the updated current user' do
        user = create(:user)

        patch(api_v1_current_user_url, simple_params, authorization_headers(user))

        expect(response).to have_http_status :ok
        expect(response).to match_response_schema :user
      end

      it "updates the current user's profile attributes" do
        user = create(:user)

        patch(api_v1_current_user_url, simple_params, authorization_headers(user))

        user.reload
        expect(user.has_shared).to be_truthy
        expect(user.is_supporter).to be_truthy
      end
    end

    context 'unauthenticated user' do
      it 'returns a 401 - Unauthorized response' do
        patch(api_v1_current_user_url, {}, accept_headers)

        expect(response).to have_http_status :unauthorized
      end
    end
  end

  def simple_params
    @simple_params ||= { user: { has_shared: true,
                                 is_supporter: true } }.to_json
  end
end
