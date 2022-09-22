# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'base64'
require 'json'

# class PaypalManagement handles placing orders with paypal
class PaypalManagement
  def place(order = nil)
    uri = URI('https://api-m.sandbox.paypal.com/v2/checkout/orders')

    res = Net::HTTP.get_response(uri)
    puts res.to_s
  end

  def access_token
    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Authorization' => "Basic #{Base64.strict_encode64('AVSE_p4cSWKy008vSSKSCaSfOvAuidWfbvbrXkKtbGcWOzDjgPwep5ls3hUZdDlu7zn_BxYg1KEJWm9-:EBHz7FFp3Ncpr_ND0NBfIvaJ5MDNjq9jwanvEQyR4FdtMtclDHenEhAG6UiTd2Wj0rczc1-W-osG6NK7')}"
    }
    body = { 'grant_type': 'client_credentials' }
    make_post('https://api-m.sandbox.paypal.com/v1/oauth2/token', body, headers)
  end

  private

  def make_post(url, body, headers)
    uri = URI(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    req = Net::HTTP::Post.new(uri, headers)
    req.set_form_data(body)
    res = https.request(req)
    puts res.read_body
  end
end

pypl = PaypalManagement.new
pypl.access_token
