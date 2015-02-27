# VosFactures: API


Intégrer votre site internet ou une application externe avec le logiciel de facturation <http://vosfactures.fr/>



Grâce à API de VosFactures, vous pouvez créer automatiquement des factures, produits et contacts sur votre compte depuis des applications externes. Ainsi, si vous avez un E-commerce et que vous vendez en ligne depuis votre site internet, vous pouvez via l'API faire en sorte qu'à chaque vente réalisée sur votre site, la facture correspondante soit automatiquement générée sur votre compte VosFactures, et même envoyée directement par email à votre client. 

## Contenu
+ [Codes API](#token)  
+ [Factures - exemples d'appels API](#examples)  
	+ Downloading a list of invoices from current month
	+ Specific client's invoices
	+ Downloading invoices by ID
	+ Downloading as PDF
	+ Sending invoices by email to a client
	+ Adding a new invoice
	+ Adding a new invoice (by client, product, seller ID)
	+ Invoice update
+ [Link to invoice preview and PDF download](#view_url)  
+ [Examples of use - purchase of training](#use_case1)  
+ [Invoices - specification](#invoices)
+ [Clients](#clients)
+ [Products](#products)
+ [Examples in PHP and Ruby](#codes)  


<a name="token"/>
##API token

`API_TOKEN` token has to be downloaded from application settings ("Settings -> Account settings -> Integration -> API Authorization Code")

<a name="examples"/>
##Examples of calling

Downloading a list of invoices from current month

```shell
curl https://yourdomain.invoiceocean.com/invoices.json?period=this_month&api_token=API_TOKEN
```

<b>NOTE</b>: additional parameters can be forwarded to calls, e.g. `page=`, `period=` etc.

Specific client's invoices

```shell
curl https://yourdomain.invoiceocean.com/invoices.json?client_id=ID_KLIENTA&api_token=API_TOKEN
```

Downloading invoices by ID


```shell
curl https://yourdomain.invoiceocean.com/invoices/100.json?api_token=API_TOKEN
```

Downloading as PDF


```shell
curl https://yourdomain.invoiceocean.com/invoices/100.pdf?api_token=API_TOKEN
```

Sending invoices by email to a client


```shell
curl -X POST https://yourdomain.invoiceocean.com/invoices/100/send_by_email.json?api_token=API_TOKEN
```

Other PDF options:
* print_option=original - Original
* print_option=copy - Copy
* print_option=original_and_copy - Original and copy
* print_option=duplicate Duplicate


Adding a new invoice

```shell
curl https://YOUR_DOMAIN.invoiceocean.com/invoices.json 
  	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{
	  	"api_token": "API_TOKEN",
	  	"invoice": {
			"kind":"vat", 
			"number": null, 
			"sell_date": "2013-01-16", 
			"issue_date": "2013-01-16", 
			"payment_to": "2013-01-23",
			"seller_name": "Wystawca Sp. z o.o.", 
			"seller_tax_no": "5252445767", 
			"buyer_name": "Klient1 Sp. z o.o.",
			"buyer_tax_no": "5252445767",
			"positions":[
				{"name":"Produkt A1", "tax":23, "total_price_gross":10.23, "quantity":1},
				{"name":"Produkt A2", "tax":0, "total_price_gross":50, "quantity":3}
			]		
		}
	}'
```

Adding a new invoice - the minimal version (only fields required), when we have product, buyer and seller ID we do not need to provide full details.
VAT Invoice with current date and 5 day due date will be issued.

```shell
curl http://YOUR_DOMAIN.invoiceocean.com/invoices.json 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"invoice": {
			"payment_to_kind": 5,
			"department_id": 1, 
			"client_id": 1,
			"positions":[
				{"product_id": 1, "quantity":2}
			]
	    }}'
```	   

Invoice update

```shell
curl https://YOUR_DOMAIN.invoiceocean.com/invoices/111.json 
	-X PUT 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{
		"api_token": "API_TOKEN",
		"invoice": {
			"buyer_name": "New client name Ltd."
		}
	}'
```

<a name="view_url"/>
##Link to invoice preview and PDF download

After downloading invoice data, e.g. by:

```shell
curl https://YOUR_DOMAIN.invoiceocean.com/invoices/100.json?api_token=API_TOKEN
```

API gives us `token` field, on which basis we may receive invoice preview links 
Such links allow you to refer to the selected invoice without having to log in - you can, for instance, send these links to the customer, who will have access to invoices and PDF.

Links are in the form: 

preview: `http://yourdomain.invoiceocean.com/invoice/{{token}}` 
pdf: `http://yourdomain.invoiceocean.com/invoice/{{token}}.pdf`

E.g. for token equal: `HBO3Npx2OzSW79RQL7XV2` public PDF will be at `http://yourdomain.invoiceocean.com/invoice/HBO3Npx2OzSW79RQL7XV2.pdf`

<a name="use_case1"/>
##Examples of using PHP - purchase of training

`TODO` 

Flow Portal Example which generates a proforma invoice for the client, sends it to the client and after receiving payment, sends the training ticket to the client

* Client fills in details in the Portal
* The Portal calls API from invoiceocean.com and generates an invoice
* The Portal sends a Proforma PDF invoice to the Client along with a payment link
* Client makes a payment for the Proforma invoice (e.g. using PayPal)
* InvoiceOcean.com receives information that the payment has been made, generates VAT invoice and sends it to the client and calls Portal API
* After receiving information regarding payment (by API) Portal sends the training ticket to the Client


<a name="invoices"/>
##Invoices


* `GET /invoices/1.json` downloading invoice
* `POST /invoices.json` adding a new invoice
* `PUT /invoices/1.json` updating invoice
* `DELETE /invoices/1.json` deleting invoice


Example - adding a new invoice - the minimal version (only fields required), when we have product, buyer and seller ID we do not need to provide full details. Field department_id determines the company (or department) which issues the invoice (it can be obtained by clicking on the company in Settings> Data Company)

```shell
curl http://YOUR_DOMAIN.invoiceocean.com/invoices.json 
    -H 'Accept: application/json'  
    -H 'Content-Type: application/json'  
    -d '{"api_token": "API_TOKEN",
        "invoice": {
            "payment_to_kind": 5,
            "department_id": 1, 
            "client_id": 1,
            "positions":[
                {"product_id": 1, "quantity":2}
            ]
        }}'
```
 
Invoice fields

```shell
"number" : "13/2012" - invoice number (if not entered, it will be automatically generated)
"kind" : "vat" - invoice kind (vat, proforma, bill, receipt, advance, correction, vat_mp, invoice_other, vat_margin, kp, kw, final, estimate)
"income" : "1" - income invoice (1) or cost invoice (0)
"issue_date" : "2013-01-16" - date of issue 
"place" : "Warszawa" - place of issue
"sell_date" : "2013-01-16" - date of sale (it can be date or month in the YYYY-MM format)
"category_id" : "" - category id
"department_id" : "1" - department id (in Settings > Company / department, click on company / department and department ID will be shown in the URL)
"seller_name" : "Radgost Sp. z o.o." - seller
"seller_tax_no" : "525-244-57-67" - seller tax id
"seller_bank_account" : "24 1140 1977 0000 5921 7200 1001" - seller bank account
"seller_bank" : "BRE Bank", 
"seller_post_code" : "02-548", 
"seller_city" : "Warsaw", 
"seller_street" : "21 Olesińska St.", 
"seller_country" : "", 
"seller_email" : "platnosci@radgost123.com", 
"seller_www" : "", 
"seller_fax" : "", 
"seller_phone" : "", 
"client_id" : "-1" - buyer id (if -1 then client will be created in the system)
"buyer_name" : "Client name - buyer
"buyer_tax_no" : "525-244-57-67", 
"disable_tax_no_validation" : "", 
"buyer_post_code" : "30-314", 
"buyer_city" : "Warsaw", 
"buyer_street" : "Nowa 44", 
"buyer_country" : "", 
"buyer_note" : "", 
"buyer_email" : "", 
"additional_info" : "0" - whether to display additional field in invoice position
"additional_info_desc" : "PKWiU" - name of the additional column in invoice positions
"show_discount" : "0" - whether show discount or not
"payment_type" : "transfer", 
"payment_to_kind" : due date. if it is "other_date", then you may define a specific date in "payment_to" field, if it is, for example, numer 5 then you have a 5 day payment period
"payment_to" : "2013-01-16", 
"status" : "issued", 
"paid" : "0,00", 
"oid" : "zamowienie10021", - order number (e.g. from external ordering system)
"warehouse_id" : "1090", 
"seller_person" : "Forename Surname", 
"buyer_first_name" : "Forename", 
"buyer_last_name" : "Surname", 
"description" : "", 
"paid_date" : "", 
"currency" : "GBP", 
"lang" : "en", 
"exchange_currency" : "", - converted currency (conversion of the sum and tax into another currency at current exchange rates)
"internal_note" : "", 
"invoice_template_id" : "1", 
"description_footer" : "", 
"description_long" : "", 
"from_invoice_id" : "" - invoice id, on which basis the invoice was generated (useful when generating a VAT invoice from Proforma invoice)
"positions":
   		"product_id" : "1", 
   		"name" : "InvoiceOcean Basic", 
   		"additional_info" : "", - additional information on invoice position 
   		"discount_percent" : "", - percentage discount (note: in order for the discount to be calculated, you need to set field 'show_discount' to 1 and before issuing check if in Account Settings, field: "How to calculate discount" is set to 'percentage from unit gross price')
   		"discount" : "", - amount discount (note: in order for the discount to be calculated, you need to set field 'show_discount' to 1 and before issuing check if in Account Settings, field: "How to calculate discount" is set to "amount")
   		"quantity" : "1", 
   		"quantity_unit" : "unit", 
   		"price_net" : "59,00", - if not entered it will be calculated
   		"tax" : "23", 
   		"price_gross" : "72,57", - if not entered it will be calculated
   		"total_price_net" : "59,00", - if not entered it will be calculated
   		"total_price_gross" : "72,57"
```

Field entries

Field: `kind`
```shell
	"vat" - VAT invoice
	"proforma" -  Proforma invoice
	"bill" - bill
	"receipt" - receipt
	"advance" - advance invoice
	"final" - final invoice
	"correction" - Credit Note
	"vat_mp" - MP invoice 
	"invoice_other" - other invoice 
	"vat_margin" - margin invoice
	"kp" - cash received
	"kw" - cash disbursed
	"estimate" - Estimate
```

Field: `lang`
```shell
	"pl" - Polish
	"en" - English
	"de" - German
	"fr" - French
	"cz" - Czech
	"ru" - Russian
	"es" - Spanish
	"it" - Italian
	"nl" - Dutch
	"hr" - Croatian
```


Field: `income`
```shell
	"1" - income invoice
	"0" - cost invoice
```

Field: `payment_type`
```shell
	"transfer" - transfer
	"card" - card
	"cash" -  cash
	"any_other_text_entry" 
```

Field: `status`
```shell
	"issued" - issued
	"sent" - sent
	"paid" - paid
	"partial" - partially paid
```

Field: `discount_kind` - discount kind
```shell
	"percent_unit" - calculated from the unit price
	"percent_total" - calculated from the total price
	"amount" - amount
```


<a name="clients"/>
##Clients

Clients list

```shell
curl "http://YOUR_DOMAIN.invoiceocean.com/clients.json?api_token=API_TOKEN&page=1"
```

Get selected client by ID

```shell
curl "http://YOUR_DOMAIN.invoiceocean.com/clients/100.json?api_token=API_TOKEN"
```

Adding clients

```shell
curl http://YOUR_DOMAIN.invoiceocean.com/clients.json 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"client": {
			"name": "Klient1",
			"tax_no": "5252445767",
			"bank" : "bank1",
			"bank_account" : "bank_account1",
			"city" : "city1",
			"country" : "",
			"email" : "bank1",
			"person" : "person1",
			"post_code" : "post-code1",
			"phone" : "phone1",
			"street" : "street1",
			"street_no" : "street-no1"
	    }}'
```

Client update

```shell
curl http://YOUR_DOMAIN.invoiceocean.com/clients/111.json 
	-X PUT 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"client": {
			"name": "Klient2",
			"tax_no": "52524457672",
			"bank" : "bank2",
			"bank_account" : "bank_account2",
			"city" : "city2",
			"country" : "PL",
			"email" : "bank2",
			"person" : "person2",
			"post_code" : "post-code2",
			"phone" : "phone2",
			"street" : "street2",
			"street_no" : "street-no2"
	    }}'
```


<a name="products"/>
##Products

Products 

Products list


```shell
curl "http://YOUR_DOMAIN.invoiceocean.com/products.json?api_token=API_TOKEN&page=1"
```

Get selected product by ID

```shell
curl "http://YOUR_DOMAIN.invoiceocean.com/products/100.json?api_token=API_TOKEN"
```

Adding products


```shell
curl http://YOUR_DOMAIN.invoiceocean.com/products.json 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"product": {
			"name": "PoroductAA",
			"code": "A001",
			"price_net": "100",
			"tax": "23"
	    }}'
```

Product update

```shell
curl http://YOUR_DOMAIN.invoiceocean.com/products/333.json 
	-X PUT
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"product": {
			"name": "PoroductAA2",
			"code": "A0012",
			"price_net": "102"
	    }}'
```

<a name="codes"/>
##Examples in PHP and Ruby

<https://github.com/radgost/fakturownia-api/blob/master/example1.php/>

<https://github.com/radgost/fakturownia-api/blob/master/example1.rb/>

Ruby Gem for InvoiceOcean.com integration: <https://github.com/kkempin/fakturownia/>
