require "rails_helper"

RSpec.describe "Auth", type: :request do
  it "registers and logs in" do
    post "/api/v1/auth/register", params: { email: "u@e.co", name: "U", password: "pass", password_confirmation: "pass" }
    expect(response).to have_http_status(:created)
    token = JSON.parse(response.body)["token"]
    get "/api/v1/auth/me", headers: { "Authorization" => "Bearer #{token}" }
    expect(response).to have_http_status(:ok)
  end
end
