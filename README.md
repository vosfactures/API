# Logiciel de Facturation VosFactures.fr : API


Intégrer votre site internet ou une application externe avec le logiciel de facturation en ligne <http://vosfactures.fr/>



Grâce à l'API de VosFactures, vous pouvez créer automatiquement des factures (ou autre), produits et contacts sur votre compte depuis des applications externes. Ainsi, si vous avez un E-commerce et que vous vendez en ligne depuis votre site internet, vous pouvez via l'API faire en sorte qu'à chaque vente réalisée sur votre site, la facture correspondante soit automatiquement générée sur votre compte VosFactures, et même envoyée directement par email à votre client. 

## Menu
+ [Code API](#token)
+ [Se connecter et télécharger le code API](#connect)
+ [Documents de facturation - actions et champs](#invoices)
+ [Contacts](#contacts)
+ [Produits](#products)
+ [Factures (et autres documents) - exemples d'appels API](#examples)  
	+ Télécharger la liste de factures du mois en cours
	+ Télécharger les factures d'un client
	+ Télécharger les factures par numéro d'ID
	+ Télécharger sous format PDF
	+ Envoyer les factures par email à un client
	+ Créer une nouvelle facture
	+ Créer une nouvelle facture (par client, produit, ID du vendeur)
	+ Créer une nouvelle facture d'avoir
	+ Mettre à jour une facture existante
	+ Changer l'état d'un document
	+ Télécharger la liste des récurrences
	+ Créer une nouvelle récurrence
	+ Mettre à jour une récurrence existante
+ [Lien vers l'aperçu de la facture et le téléchargement en PDF](#view_url)  

  


<a name="token"/>
##Code API

Le code API (`API_TOKEN`) de votre compte VosFactures est affiché dans les paramètres de votre compte: "Paramètres -> Paramètres du compte -> Intégration -> Code d'autorisation API". 
Le code API est du type "qCedKxkTgQhGJpiI2SU". Dans les exemples suivants, l'url votrecompte.vosfactures.fr est à remplacer avec l'url de votre propre compte. 

<a name="connect"/>
##Se connecter et télécharger le code API

```shell
curl https://app.vosfactures.fr/login.json \
    -H 'Accept: application/json'  \
    -H 'Content-Type: application/json' \
    -d '{
            "login": "identifiant_ou_email",
            "password": "mot_de_passe"
    }'
``` 
Cette requête renvoie le code API et les informations sur le compte vosfactures (champ du `prefixe`et `url` du compte):

```shell
{
    "login":"paul",
    "email":"paul@email.com",
    "prefix":"YYYYYYY",
    "url":"https://YYYYYYY.vosfactures.fr",
    "first_name":"Paul",
    "last_name":"Lebrun",
    "api_token":"XXXXXXXXXXXXXX"
}
```

<a name="invoices"/>
##Documents de facturation


* `GET /invoices/1.json` télécharge le document
* `POST /invoices.json` ajoute un nouveau document
* `PUT /invoices/1.json` met à jour le document
* `DELETE /invoices/1.json` supprime le document


Exemple - Vous pouvez ajouter une nouvelle facture (ou autre) en complétant seulement les champs obligatoires (version minimale): si seuls les ID du produit, de l'acheteur et du vendeur sont indiqués, la facture créée sera datée du jour et aura une date limite de règlement de 5 jours. Le champ "department_id" représente l'ID du département vendeur (depuis Paramètres > Compagnies/Départments, cliquer sur le nom de la compagnie/département pour visualiser l'ID dans l'url affiché). Si aucun "department_id" n'est renseigné, le département principal sera choisi. 
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
"number" : "13/2012" - numéro du document (généré automatiquement si non indiqué)
"kind" : "vat" - type du document ("vat" pour facture, "estimate" pour devis, "proforma" pour facture proforma, "correction" pour avoir, "client_order" pour bon de commande de client, "receipt" pour reçu, "advance" pour facture d'acompte, "final" pour facture de solde, "invoice_other" pour autre type de document, "kp" pour bon d'entrée de caisse,"kw" pour bon de sortie de caisse)
"income" : "1" - revenu (1) ou dépense (0)
"issue_date" : "2013-01-16" - date de création 
"place" : "Paris" - lieu de création
"sell_date" : "2013-01-16" - date additionnelle (ex: date de vente) : date complète ou juste mois et année:YYYY-MM. Pour ne pas faire apparaître cette date, indiquez "off" (ou décochez l'option "Afficher la Date additionnelle" depuis vos paramètres du compte). 
"category_id" : "" - ID de la catégorie
"department_id" : "1" - ID du département vendeur (depuis Paramètres > Compagnies/Départments, cliquer sur le nom de la compagnie/département pour visualiser l'ID dans l'url affiché). Le système affichera alors automatiquement les coordonnées du département vendeur (nom, adresse...) sur le document (les autres champs "seller_" ne sont plus nécessaires). 
"seller_name" : "Ma Société" - Nom du département vendeur. Si ce champ n'est pas renseigné, le département principal est sélectionné par défaut. Préférez plutôt "department_id". Si vous utilisez toutefois "seller_name", le système tentera d'identifier le département portant ce nom, sinon il créera un nouveau département. 
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
"seller_person" : "" - Nom du vendeur (figurant en bas de page des documents)
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
"buyer_phone" : "", numéro de tel de l'acheteur
"additional_info" : "0" - afficher (1) ou non (0) la colonne aditionnelle
"additional_info_desc" : "" - contenu de la colonne aditionnelle (intitulé à définir dans Paramètres du compte > Options par défaut)
"additional_invoice_field" : "" - contenu du champ additionnel (intitulé à définir dans Paramètres du compte > Options par défaut)
"show_discount" : "0" - afficher (1) ou non (0) la colonne réduction
"payment_type" : "chèque" - mode de règlement 
"payment_to_kind" : date limite de règlement (parmi les options proposées). Si l'option est "Autre" ("other_date"), vous pouvez définir une date spécifique grâce au champ "payment_to". Si vous indiquez "5", la date d'échéance est de 5 jours. Pour ne pas afficher ce champ, indiquez "off". 
"payment_to" : "2013-01-16" - date limite de règlement
"status" : "Créé" - état du document 
"paid" : "0,00" - montant payé
"oid" : "10021", - numéro de commande (ex: numéro généré par une application externe)
"oid_unique": si la valeur est «yes», alors il ne sera pas permis au système de créer 2 factures avec le même OID (cela peut être utile en cas de synchronisation avec une boutique en ligne)
"warehouse_id" : "1090" - numéro d'identification de l'entrepôt
"buyer_first_name" : "Prénom" de l'acheteur 
"buyer_last_name" : "Nom" de l'acheteur 
"buyer_company": "1" - si l'acheteur est un professionnel, "0" si c'est un particulier
"description" : "" - Informations spécifiques 
"paid_date" : "" - Date du paiement
"currency" : "EUR" - devise
"lang" : "fr" - langue du document
"exchange_currency" : "" - convertir en (la conversion du montant total et du montant de la taxe en une autre devise selon taux de change du jour)
"title" : "" - Objet
"internal_note" : "" - Notes privées  
"invoice_template_id" : "1" - format d'impression
"description_footer" : "" - Bas de page 
"description_long" : "" - Texte additionnel (imprimé sur la page suivante) 
"from_invoice_id" : "" - ID du document de référence depuis lequel le document a été généré (utile par ex quand une facture est générée depuis un devis)
"positions":
   		"product_id" : "1" - ID du produit
   		"name" : "Produit A" - nom du produit 
   		"code" : "" - Référence du produit
   		"additional_info" : "" - contenu de la colonne additionnelle
   		"discount_percent" : "" - % de la réduction (remarque: afin de pouvoir appliquer la réduction, il faut au préalable donner à "show_discount" la valeur de 1 et vérfier si dans les Paramètres du compte > Options par défaut, l'option choisie sous le champ 'Comment calculer la réduction' est 'pourcentage du prix unitaire net')
   		"discount" : "", - montant de la réduction (remarque: afin de pouvoir appliquer la réduction, il faut au préalable donner à "show_discount" la valeur de 1 et vérfier si dans les Paramètres du compte > Options par défaut, l'option choisie sous le champ 'Comment calculer la réduction' est 'Montant (TTC)')
   		"quantity" : "1" - quantité 
   		"quantity_unit" : "kg" - unité 
   		"price_net" : "59,00", - prix unitaire HT (calculé automatiquement si non indiqué)
   		"tax" : "23" - % de taxe
   		"price_gross" : "72,57" - prix unitaire TTC (calculé automatiquement si non indiqué)
   		"total_price_net" : "59,00" - total HT (calculé automatiquement si non indiqué)
   		"total_price_gross" : "72,57" - total TTC
"hide_tax" : "1" - Montant TTC uniquement (ne pas afficher de montant HT ni de taxe)
"calculating_strategy" => 
{
  "position": "default" ou "keep_gross" - Comment se calcule le total de chaque ligne 
  "sum": "sum" ou "keep_gross" ou "keep_net" - Comment se calcule le total des colonnes 
  "invoice_form_price_kind": "net" ou "gross" - prix unitaire (HT ou TTC)
}

```

Valeurs des Champs

Champ: `kind`- Type du document
```shell
	"vat" - facture 
	"proforma" -  facture Proforma
	"advance" - facture d'acompte
	"final" - facture de solde
	"correction" - facture d'avoir
	"estimate" - devis
	"client_order" - bon de commande
	"receipt" - reçu
	"kp" - bon d'entrée de caisse
	"kw" - bon de sortie de caisse
	"invoice_other" - Autre 
	
	
	
```

Champ: `lang`
```shell
	"en" - Anglais
	"de" - Allemand
	"fr" - Français
	"he" - Grec
	"es" - Espagnol
	"it" - Italien
	"nl" - Hollandais
	"cz" - Tchèque
	"hr" - Croate
	"pl" - Polonais
	"hu" - Hongrois
    	"sk" - Slovaque
    	"sl" - Slovène
	"et" - Estonien
    	"ru" - Russe
    	"cn" - Chinois
    	"ar" - Arabe
    	"tr" - Turc
    	"fa" - Persan
    	
    	Vous pouvez créer des documents en bilingue en combinant deux langues séparées par un slash, par exemple:
     "en / fr" - en anglais et en français
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
	"cheque" - chèque
	"paypal" - PayPal
	"off" - aucun (ne pas afficher)
	"any_other_text_entry" - autre
```

Champ: `status`- Etat
```shell
	"issued" - Créé
	"sent" - Envoyé
	"paid" - Payé
	"partial" - Payé en partie
	"rejected" - Refusé
	"accepted" - Accepté
```

Champ: `discount_kind` - Type de réduction
```shell
	"percent_unit" - % calculé sur le prix unitaire
	"percent_total" - % calculé sur le montant total
	"amount" - montant
```


<a name="clients"/>
##Contacts

Liste des contacts

```shell
curl "http://votrecompte.vosfactures.fr.com/clients.json?api_token=API_TOKEN&page=1"
```

Obtenir un contact selon son ID

```shell
curl "http://votrecompte.vosfactures.fr.com/clients/100.json?api_token=API_TOKEN"
```

Ajouter un contact

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
			"email" : "client@email.fr",
			"person" : "person1",
			"post_code" : "post-code1",
			"phone" : "phone1",
			"mobile_phone" : "phone2"
			"street" : "street1",
			"street_no" : "street-no1"
	    }}'
```
Champs fiche contact: 
```shell
"note" : description additionnelle
"payment_to_kind" : Date limite de règlement par défaut
```

Mettre à jour un contact

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
			"email" : "client2@email.fr",
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
			"tax": "20" - % de taxe
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
			"price_gross": "102" - prix unitaire TTC
	    }}'
```

<a name="examples"/>
##Factures - exemples d'appels API

Télécharger la liste des factures du mois en cours

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?period=this_month&api_token=API_TOKEN
```

<b>REMARQUE</b>: Des paramètres additionnels peuvent être transmis aux appels, ex: `page=`, `period=` etc... (Vous pouvez utiliser les mêmes filtres que ceux du moteur de recherche utilisé pour afficher la liste des documents dans le logiciel).

Télécharger les factures d'un client

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?client_id=ID_KLIENTA&api_token=API_TOKEN
```

Télécharger une facture par numéro d'ID


```shell
curl https://votrecompte.vosfactures.fr/invoices/100.json?api_token=API_TOKEN
```

Télécharger une facture sous format PDF


```shell
curl https://votrecompte.vosfactures.fr/invoices/100.pdf?api_token=API_TOKEN
```

Remarque: la variable "payment_url" vout permet d'obtenir l'url du paiement en ligne d'une facture (dans le cadre de la fonction Paiement en ligne). 

Envoyer une facture par email à un client


```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?api_token=API_TOKEN
```
Remarque: Afin d'éviter le risque de spams, le système n'autorise pas l'envoi répété d'un même document avant un délai de 3 jours, à moins d'utiliser le paramètre suivant: 
```shell
"force": true
```
Par exemple, écrivez: 
```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?api_token=API_TOKEN&force=true
```

Autres options PDF:
* print_option=original - Original
* print_option=copy - Copie
* print_option=original_and_copy - Original et copie
* print_option=duplicate - Duplicata


Créer une nouvelle facture

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

<b>REMARQUE</b>
Si vous obtenez le message suivant: 
{"code":"error","message":{"seller_bank_account":["Protection contre la modification du numéro de compte bancaire"]}}
cela signifie que vous avez choisi un niveau de sécurité standard ou élevée contre le changement de compte bancaire (Paramètres > Paramètres du compte > Options par défaut > Sécurité) et que vous essayez tout de même de créer un document avec des coordonnées bancaires différentes de celles indiquées dans la fiche du département vendeur (Paramètres > Compagnies/départements). Il faut donc soit changer le niveau de sécurité, soit vérifier les coordonnées bancaires envoyées. 

Créer une nouvelle facture d'avoir

```shell
curl http://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{"api_token": "API_TOKEN",
        "invoice": {
            "kind": "correction",
            "from_invoice_id": "2432393,
            "client_id": 1,
            "positions":[
                {"name": "Produit A1",
                "quantity":-1,
                "total_price_gross":"-10",
                "tax":"23",
                "correction_before_attributes": {
                    "name":"Produit A1",
                    "quantity":"2",
                    "total_price_gross":"20",
                    "tax":"23",
                    "kind":"correction_before"
                },
                "correction_after_attributes": {
                    "name":"Produit A1",
                    "quantity":"1",
                    "total_price_gross":"10",
                    "tax":"23",
                    "kind":"correction_after"
                }
            }]
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

Changer l'état d'un document

```shell
curl "https://votrecompte.vosfactures.fr/invoices/111/change_status.json?api_token=API_TOKEN&status=STATUS" -X POST
```

Télécharger la liste des récurrences
```shell
curl https://votrecompte.vosfactures.fr/recurrings.json?api_token=API_TOKEN
```

Créer une nouvelle récurrence

Dans l'exemple ci-dessous, la récurrence est basée sur la facture n°1 ("invoice_id"), débute le 01/01/2016 ("start_date"), est mensuelle ("every"), et n'a pas de date de fin ("end_date"). Les factures récurrentes générées sont envoyées automatiquement au(x) client(s) ("buyer_email") et une notification vous est envoyée ("send_email")
```shell
curl https://votrecompte.vosfactures.fr/recurrings.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{"api_token": "API_TOKEN",
        "recurring": {
            "name": "Nom de la récurrence",
            "invoice_id": 1,
            "start_date": "2016-01-01",
            "every": "1m",
            "issue_working_day_only": false,
            "send_email": true,
            "buyer_email": "client1@email.fr, client2@email.fr",
            "end_date": "null"
        }}'
```

Mettre à jour une récurrence existante (changement de la date de la prochaine facture)

```shell
curl https://votrecompte.vosfactures.fr/recurrings/111.json \
    -X PUT \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "recurring": {
            "next_invoice_date": "2016-02-01"
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







