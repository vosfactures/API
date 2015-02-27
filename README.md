# VosFactures: API


Intégrer votre site internet ou une application externe avec le logiciel de facturation en ligne <http://vosfactures.fr/>



Grâce à l'API de VosFactures, vous pouvez créer automatiquement des factures (ou autre), produits et contacts sur votre compte depuis des applications externes. Ainsi, si vous avez un E-commerce et que vous vendez en ligne depuis votre site internet, vous pouvez via l'API faire en sorte qu'à chaque vente réalisée sur votre site, la facture correspondante soit automatiquement générée sur votre compte VosFactures, et même envoyée directement par email à votre client. 

## Menu
+ [Code API](#token)  
+ [Factures - exemples d'appels API](#examples)  
	+ Télécharger la liste de factures du mois en cours
	+ Télécharger les factures d'un client
	+ Télécharger les factures par numéro d'ID
	+ Télécharger sous format PDF
	+ Envoyer les factures par email à un client
	+ Ajouter une nouvelle facture
	+ Ajouter une nouvelle facture (par client, produit, ID du vendeur)
	+ Mettre à jour une facture
+ [Lien vers l'aperçu de la facture et le téléchargement en PDF](#view_url)  
+ [Exemples d'utilisation - purchase of training](#use_case1)  
+ [Factures - caractéristiques](#invoices)
+ [Clients](#clients)
+ [Produits](#products)
+ [Exemples en PHP et Ruby](#codes)  


<a name="token"/>
##Code API

Le code API du compte VosFactures (`API_TOKEN)` est affiché depuis les paramètres du compte ("Paramètres -> Paramètres du compte -> Intégration -> Code d'autorisation API")

<a name="examples"/>
##Factures - exemples d'appels API

Télécharger la liste des factures du mois en cours

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?period=this_month&api_token=API_TOKEN
```

<b>NOTE</b>: Des paramètres additionnels peuvent aussi transmis aux appels, ex: `page=`, `period=` etc...

Télécharger les factures d'un client

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?client_id=ID_KLIENTA&api_token=API_TOKEN
```

Télécharger les factures par numéro d'ID


```shell
curl https://votrecompte.vosfactures.fr/invoices/100.json?api_token=API_TOKEN
```

Télécharger sous format PDF


```shell
curl https://votrecompte.vosfactures.fr/invoices/100.pdf?api_token=API_TOKEN
```

Envoyer les factures par email à un client


```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?api_token=API_TOKEN
```

Autres options PDF:
* print_option=original - Original
* print_option=copy - Copie
* print_option=original_and_copy - Original et copie
* print_option=duplicate - Duplicata


Ajouter une nouvelle facture

```shell
curl https://votrecompte.vosfactures.fr/invoices.json 
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
			"seller_name": "Société Chose", 
			"seller_tax_no": "FR5252445767", 
			"buyer_name": "Client Intel",
			"buyer_tax_no": "FR45362780010",
			"positions":[
				{"name":"Produit A1", "tax":23, "total_price_gross":10.23, "quantity":1},
				{"name":"Produit A2", "tax":0, "total_price_gross":50, "quantity":3}
			]		
		}
	}'
```

Vous pouvez ajouter une nouvelle facture en complétant seulement les champs obligatoires (version minimale): si seuls les ID du produit, de l'acheteur et du vendeur sont indiqués, la facture créée sera datée du jour et aura une date limite de règlement de 5 jours.

```shell
curl http://votrecompte.vosfactures.fr/invoices.json 
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

Mettre à jour une facture

```shell
curl https://votrecompte.vosfactures.fr/invoices/111.json 
	-X PUT 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{
		"api_token": "API_TOKEN",
		"invoice": {
			"buyer_name": "Nouveau nom du client"
		}
	}'
```

<a name="view_url"/>
##Lien vers l'aperçu de la facture et le téléchargement en PDF

Après le téléchargement des données de la facture, par ex:

```shell
curl https://votrecompte.vosfactures.fr/invoices/100.json?api_token=API_TOKEN
```

L'API renvoie le champ `token`, grâce auquel il est possible de recevoir les liens vers l'aperçu de la facture et de son téléchargement en pdf. Ces liens vous permettent de faire référence à la facture sélectionnée sans avoir à vous connecter - vous pouvez, par exemple, envoyer ces liens à votre client qui aura accès à l'aperçu et au PDF des factures.

Les liens sont sous la forme: 

vers l'aperçu: `http://votrecompte.vosfactures.fr/invoice/{{token}}` 
vers le pdf: `http://votrecompte.vosfactures.fr/invoice/{{token}}.pdf`

Par exemple, pour un token égal à `HBO3Npx2OzSW79RQL7XV2`, le PDF sera accessible à l'url suivant: `http://votrecompte.vosfactures.fr/invoice/HBO3Npx2OzSW79RQL7XV2.pdf`

<a name="use_case1"/>
##Exemples d'utilisation PHP - purchase of training

`TODO` 

Flow Portal Example which generates a proforma invoice for the client, sends it to the client and after receiving payment, sends the training ticket to the client

* Le client renseigne ses coordonnées sur le portail 
* Le portail appel l'API depuis vosfactures.fr et génère la facture
* Le portail envoies une facture PDF au client avec un lien de paiement sends a Proforma PDF invoice to the Client along with a payment link
* Le lient effectue son paiement (ex: par Paypal)
* vosfactures.fr reçoie l'information comme quoi le paiement a été effectué, génère la facture correspondante et l'envoie au client, et appelle l'API du Portail. 
* After receiving information regarding payment (by API) Portal sends the training ticket to the Client


<a name="invoices"/>
##Factures


* `GET /invoices/1.json` télécharge la facture
* `POST /invoices.json` ajoute une nouvelle facture
* `PUT /invoices/1.json` met à jour la facture
* `DELETE /invoices/1.json` supprime la facture


Exemple - Vous pouvez ajouter une nouvelle facture en complétant seulement les champs obligatoires (version minimale): si seuls les ID du produit, de l'acheteur et du vendeur sont indiqués, la facture créée sera datée du jour et aura une date limite de règlement de 5 jours. Le champ "department_id" determines the company (or department) which issues the invoice (it can be obtained by clicking on the company in Settings> Data Company)

```shell
curl http://votrecompte.vosfactures.fr/invoices.json 
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
 
Champs d'un document

```shell
"number" : "13/2012" - numéro du document (if not entered, it will be automatically generated)
"kind" : "facture" - type du document (devis, facture, proforma, acompte, avoir, bon de commande, facture de solde, invoice_other,)
"income" : "1" - revenu (1) ou dépense (0)
"issue_date" : "2013-01-16" - date de création 
"place" : "Paris" - lieu de création
"sell_date" : "2013-01-16" - date de vente (date complète ou juste mois et année:YYYY-MM)
"category_id" : "" - ID de la catégorie
"department_id" : "1" - ID du département vendeur (depuis Paramètres > Compagnies/Départments, cliquer sur le nom de la compagnie/département pour visualiser l'ID dans l'url affiché)
"seller_name" : "Société Chose." - nom du vendeur
"seller_tax_no" : "FR5252445767" - numéro d'identification fiscale du vendeur (ex: n° TVA)
"seller_bank_account" : "24 1140 1977 0000 5921 7200 1001" - coordonnées bancaires du vendeur
"seller_bank" : "CREDIT AGRICOLE" - domiciliation bancaire
"seller_post_code" : "75007", code postal du vendeur
"seller_city" : "Paris" - ville du vendeur
"seller_street" : "21 Rue des Mimosas" - numéro et nom de rue du vendeur
"seller_country" : "" - pays du vendeur
"seller_email" : "contact@chose.com" - email du vendeur
"seller_www" : "" - site internet du vendeur
"seller_fax" : "" - numéro de fax du vendeur
"seller_phone" : "" - numéro de tel du vendeur
"client_id" : "-1" - ID de l'acheteur (si la valeur est -1 alors le client sera ajouté à la liste des contacts)
"buyer_name" : "Client Intel" - nom de l'acheteur
"buyer_tax_no" : "FR45362780010" - numéro d'identification fiscale de l'acheteur (ex: n° TVA) 
"disable_tax_no_validation" : "", 
"buyer_post_code" : "06000", code postal de l'acheteur
"buyer_city" : "Nice" - ville de l'acheteur
"buyer_street" : "44 Rue des Plans" - numéro et nom de rue de l'acheteur 
"buyer_country" : "", pays de l'acheteur
"buyer_note" : "", description additionnelle
"buyer_email" : "", email de l'acheteur
"additional_info" : "0" - afficher (1) ou non (0) la colonne aditionnelle
"additional_info_desc" : "Origine" - titre de la colonne aditionnelle
"show_discount" : "0" - afficher (1) ou non (0) la colonne réduction
"payment_type" : "chèque" - mode de règlement 
"payment_to_kind" : date limite de règlement (parmi les options proposées). Si l'option est "Autre" ("other_date"), vous pouvez définir une date spécifique grâce au champ "payment_to". if it is, for example, numer 5 then you have a 5 day payment period
"payment_to" : "2013-01-16" - date limite de règlement
"status" : "Créé" - état du document 
"paid" : "0,00" - montant payé
"oid" : "10021", - numéro de commande (e.g. from external ordering system)
"warehouse_id" : "1090", 
"seller_person" : "Forename Surname", de l'acheteur 
"buyer_first_name" : "Prénom" de l'acheteur 
"buyer_last_name" : "Nom" de l'acheteur 
"description" : "" - Informations spécifiques 
"paid_date" : "" - Date du paiement
"currency" : "EUR" - devise
"lang" : "fr" - langue du document
"exchange_currency" : "" - convertir en (la conversion du montant total et du montant de la taxe en une autre devise selon taux de change du jour)
"internal_note" : "" - Notes privées  
"invoice_template_id" : "1" - format d'impression
"description_footer" : "" - Bas de page 
"description_long" : "" - Texte additionnel (imprimé sur la page suivante) 
"from_invoice_id" : "" - ID du document de référence depuis lequel le document a été généré (utile par ex quand une facture est générée depuis un devis)
"positions":
   		"product_id" : "1" - ID du produit
   		"name" : "Produit A" - nom du produit 
   		"additional_info" : "" - contenu de la colonne additionnelle
   		"discount_percent" : "" - % de la réduction (remarque: afin de pouvoir appliquer la réduction, il faut au préalable donner à "show_discount" la valeur de 1 et vérfier si dans les Paramètres du compte > Options par défaut, l'option choisie sous le champ 'Comment calculer la réduction' est 'pourcentage du prix unitaire net')
   		"discount" : "", - montant de la réduction (remarque: afin de pouvoir appliquer la réduction, il faut au préalable donner à "show_discount" la valeur de 1 et vérfier si dans les Paramètres du compte > Options par défaut, l'option choisie sous le champ 'Comment calculer la réduction' est 'Montant (TTC)')
   		"quantity" : "1" - quantité 
   		"quantity_unit" : "kg" - unité 
   		"price_net" : "59,00", - prix HT (calculé automatiquement si non indiqué)
   		"tax" : "23" - % de taxe
   		"price_gross" : "72,57" - prix TTC (calculé automatiquement si non indiqué)
   		"total_price_net" : "59,00" - total HT (calculé automatiquement si non indiqué)
   		"total_price_gross" : "72,57" - total TTC
```

Valeurs des Champs

Champ: `kind`- Type du document
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

Champ: `lang`
```shell
	"pl" - Polonais
	"en" - Anglais
	"de" - Allemand
	"fr" - Français
	"cz" - Tchèque
	"ru" - Russe
	"es" - Espagnol
	"it" - Italien
	"nl" - Hollandais
	"hr" - Croate
```


Champ: `income`- facture de vente ou d'achat
```shell
	"1" - revenu (vente)
	"0" - dépense (achat)
```

Champ: `payment_type`- Mode de règlement
```shell
	"transfer" - virement bancaire
	"card" - carte bancaire
	"cash" -  espèce
	"any_other_text_entry" - autre
```

Champ: `status`- Etat
```shell
	"issued" - créé
	"sent" - envoyé
	"paid" - payé
	"partial" - payé en partie
```

Champ: `discount_kind` - Type de réduction
```shell
	"percent_unit" - % calculé sur le prix unitaire
	"percent_total" - % calculé sur le montant total
	"amount" - montant
```


<a name="clients"/>
##Clients

Liste des clients

```shell
curl "http://votrecompte.vosfactures.fr.com/clients.json?api_token=API_TOKEN&page=1"
```

Obtenir un client selon son ID

```shell
curl "http://votrecompte.vosfactures.fr.com/clients/100.json?api_token=API_TOKEN"
```

Ajouter un client

```shell
curl http://votrecompte.vosfactures.fr/clients.json 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"client": {
			"name": "Client1",
			"tax_no": "FR5252445333",
			"bank" : "banque1",
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

Mettre à jour un client

```shell
curl http://votrecompte.vosfactures.fr/clients/111.json 
	-X PUT 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"client": {
			"name": "Client2",
			"tax_no": "FR52524457672",
			"bank" : "banque2",
			"bank_account" : "bank_account2",
			"city" : "Ville2",
			"country" : "EUR",
			"email" : "bank2",
			"person" : "person2",
			"post_code" : "post-code2",
			"phone" : "phone2",
			"street" : "street2",
			"street_no" : "street-no2"
	    }}'
```


<a name="products"/>
##Produits

Produits 

Liste des produits


```shell
curl "http://votrecompte.vosfactures.fr/products.json?api_token=API_TOKEN&page=1"
```

Obtenir un produit selon son ID

```shell
curl "http://votrecompte.vosfactures.fr/products/100.json?api_token=API_TOKEN"
```

Ajouter un produit


```shell
curl http://votrecompte.vosfactures.fr/products.json 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"product": {
			"name": "ProduitA" - nom
			"code": "A001" - référence
			"price_net": "100" - prix unitaire HT
			"tax": "23" - % de taxe
	    }}'
```

Mettre à jour un produit

```shell
curl http://votrecompte.vosfactures.fr/products/333.json 
	-X PUT
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{"api_token": "API_TOKEN",
		"product": {
			"name": "ProduitA" - nom
			"code": "A0012" - référence
			"price_net": "102" - prix unitaire HT
	    }}'
```

<a name="codes"/>
##Examples in PHP and Ruby

<https://github.com/radgost/fakturownia-api/blob/master/example1.php/>

<https://github.com/radgost/fakturownia-api/blob/master/example1.rb/>

Ruby Gem for vosfactures.fr integration: <https://github.com/kkempin/fakturownia/>
