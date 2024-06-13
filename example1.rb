#!/usr/bin/env ruby

require 'net/https'
require 'uri'
require 'json'

endpoint = 'http://votrecompte.vosfactures.fr/invoices.json'
uri = URI.parse(endpoint)

json_params = {
  "api_token" => "votre_API_code",
  "invoice" => {
    "number" => nil,
    "kind" => "vat",
    "sell_date" => "2013-07-19",
    "issue_date" => "2013-07-19",
    "payment_to" => "2013-07-26",
    "seller_name" => "Société Chose",
    "seller_tax_no" => "FR5252445767",
    "buyer_name" => "Client Intel",
    "buyer_tax_no" => "FR45362780010",
    "positions" => [
      { "name" => "Produit A1", "tax" => 23, "total_price_gross" => 10.23, "quantity" => 1 },
      { "name" => "Produit A2", "tax" => 0, "total_price_gross" => 50, "quantity" => 3 }
    ]
  }
}

request = Net::HTTP::Post.new(uri.path)
request.body = JSON.generate(json_params)
request["Content-Type"] = "application/json"

http = Net::HTTP.new(uri.host, uri.port)
response = http.start { |h| h.request(request) }

if response.code == '201'
  ret = JSON.parse(response.body)
else
  ret = response.body
end

puts ret.to_json
