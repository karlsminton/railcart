# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'base64'
require 'json'

# class PaypalManagement handles placing orders with paypal
class PaypalManagement
  def place(order)
    token = PaypalToken.where('expires_in > ?', DateTime.now).first
    token = access_token if token.nil?

    body = {
      intent: 'CAPTURE',
      purchase_units: [
        {
          amount: {
            currency_code: 'USD',
            value: '100.00'
          }
        }
      ]
    }.to_json

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{token.access_token}"
    }
    res = make_post('https://api-m.sandbox.paypal.com/v2/checkout/orders', body, headers)

    # {
    #   "id":"2R303995NC8373017",
    #   "status":"CREATED",
    #   "links":[
    #     {
    #       "href":"https://api.sandbox.paypal.com/v2/checkout/orders/2R303995NC8373017",
    #       "rel":"self",
    #       "method":"GET"
    #     },{
    #       "href":"https://www.sandbox.paypal.com/checkoutnow?token=2R303995NC8373017",
    #       "rel":"approve",
    #       "method":"GET"
    #     },{
    #       "href":"https://api.sandbox.paypal.com/v2/checkout/orders/2R303995NC8373017",
    #       "rel":"update",
    #       "method":"PATCH"
    #     },{
    #       "href":"https://api.sandbox.paypal.com/v2/checkout/orders/2R303995NC8373017/capture",
    #       "rel":"capture",
    #       "method":"POST"
    #     }
    #   ]
    # }

    order_data = JSON.parse(res.body)
    order.paypal_id = order_data['id']
    order.paypal_status = order_data['status']
    order
  end

  private

  def access_token
    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Authorization' => "Basic #{Base64.strict_encode64('AVSE_p4cSWKy008vSSKSCaSfOvAuidWfbvbrXkKtbGcWOzDjgPwep5ls3hUZdDlu7zn_BxYg1KEJWm9-:EBHz7FFp3Ncpr_ND0NBfIvaJ5MDNjq9jwanvEQyR4FdtMtclDHenEhAG6UiTd2Wj0rczc1-W-osG6NK7')}"
    }
    body = { 'grant_type': 'client_credentials' }
    res = make_post('https://api-m.sandbox.paypal.com/v1/oauth2/token', body, headers)
    data = JSON.parse(res.body)

    invalid = %w[scope token_type]

    data = data.reject { |key, _value| invalid.include?(key) }
    token = PaypalToken.new(data)
    expires = DateTime.now
    token.expires_in = expires + token.expires_in.to_i.seconds
    token.save
    token
  end

  def make_post(url, body, headers)
    uri = URI(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    req = Net::HTTP::Post.new(uri, headers)
    if headers['Content-Type'] == 'application/x-www-form-urlencoded'
      req.set_form_data(body)
    else
      req.body = body
    end
    https.request(req)
  end
end
