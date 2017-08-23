<?php
$host = 'XXXXXX.vosfactures.fr';
$token = 'XXXXXXXXXX';
$json ='{ "api_token": "'.$token.'", "invoice": { "kind":"vat", "number": null, "sell_date": "2013-04-17", "issue_date": "2013-04-17", "payment_to": "2013-04-24", "seller_name": "Société Chose", "seller_tax_no": "FR5252445767", "buyer_name": "Client Intel", "buyer_tax_no": "FR45362780010", "positions":[ {"name":"Produit A1", "tax":23, "total_price_gross":10.23, "quantity":1}, {"name":"Produit A2", "tax":0, "total_price_gross":50, "quantity":3} ] }}';
$c = curl_init();
curl_setopt($c, CURLOPT_URL, 'https://'.$host.'/invoices.json');
$head[] ='Accept: application/json';
$head[] ='Content-Type: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $head);
curl_setopt($c, CURLOPT_POSTFIELDS, $json);
curl_exec($c);
?>
 
