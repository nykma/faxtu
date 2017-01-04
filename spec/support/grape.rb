module GrapeHelpers
  def stub_current_user(user)
    if user.is_a?(Admin)
      allow(Admin).to receive(:find_by).and_call_original
      allow(Admin).to receive(:find_by).with(authentication_token: anything) { user }
    elsif user.is_a?(Agent)
      allow(Agent).to receive(:find_by).and_call_original
      allow(Agent).to receive(:find_by).with(authentication_token: anything) { user }
    end
  end

  def extract_result(resp = last_response)
    expect(resp.status).to eq 200
    result = JSON.parse(resp.body)
    expect(result['meta']).to be_a Hash
    expect(result['body'].is_a?(Hash) || result['body'].is_a?(Array)).to eq true

    [result['meta'], result['body']]
  end

  def subdomain!(sub = "test")
    ::Rack::Test::DEFAULT_HOST.replace "#{sub}.newbeevc.com"
  end
end

RSpec.configure do |config|
  config.include GrapeHelpers, type: :request
end
