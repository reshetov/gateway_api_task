class SaltedgeApiService
  EXPIRATION_TIME = 60

  def initialize
    @url = ENV['SALTEDGE_URL']
    @app_id = ENV['SALTEDGE_APP_ID']
    @secret = ENV['SALTEDGE_SECRET']
    @private_key = OpenSSL::PKey::RSA.new(File.open(Rails.root.join(ENV['SALTEDGE_PRIVATE_KEY'])))

    raise 'Missed params' if [@url, @app_id, @secret, @private_key].any?(&:blank?)
  end

  def request(method, path, payload)
    hash = {
      method: method,
      url: api_url(path),
      expires_at: (Time.now + EXPIRATION_TIME).to_i,
      payload: as_json(payload)
    }

    response =
    RestClient::Request.execute(
      method: hash[:method],
      url: hash[:url],
      payload: hash[:payload],
      log: Logger.new(STDOUT),
      headers: {
        'Accept' => 'application/json',
        'Content-type' => 'application/json',
        'Expires-at' => hash[:expires_at],
        'Signature' => sign_request(hash),
        'App-Id' => @app_id,
        'Secret' => @secret
      }
    )

    pp JSON.parse(response.body)['data'] # TODO: REMOVE
    [response.code, JSON.parse(response.body)['data']]
  rescue RestClient::Exception => error
    bad_response = error.response
    [bad_response.code, JSON.parse(bad_response.body)]
  rescue Exception => error
    pp "SaltedgeService API error: #{error.message}"
  end

  private

  def sign_request(hash)
    data = "#{hash[:expires_at]}|#{hash[:method].to_s.upcase}|#{hash[:url]}|#{hash[:payload]}"
    Base64.encode64(@private_key.sign(OpenSSL::Digest::SHA256.new, data)).delete("\n")
  end

  def api_url(path)
    "#{@url}/#{path}"
  end

  def as_json(payload)
    return '' if payload.empty?

    payload.to_json
  end
end
