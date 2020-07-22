# API du Logiciel de Facturation en ligne VosFactures


Intégrer votre site internet ou une application externe avec le logiciel de facturation en ligne [VosFactures](https://vosfactures.fr)



Grâce à l'API de VosFactures, vous pouvez créer automatiquement des factures (ou autres documents tels que : devis, bon de commande, bon de livraison ...), produits, contacts, ou paiements depuis des applications externes.</br>Par exemple, si vous avez un E-commerce et que vous vendez en ligne depuis votre site internet, vous pouvez via l'API faire en sorte qu'à chaque vente réalisée sur votre site, la facture correspondante soit automatiquement générée sur votre compte VosFactures, et même envoyée directement par email à votre client.</br> 
</br>Les demandes API sont compatibles avec JSON, XML,Ruby, ou Javascript et avec SSL. Vous pouvez créer un compte gratuitement sur <https://vosfactures.fr/> et tester notre API. </br>Des exemples pratiques d'appels API sont également disponibles dans votre compte VosFactures (Paramètres > API) et sur <https://app.vosfactures.fr/api>. 

## Menu
+ [Code API](#token)
+ [Documents de facturation - actions et champs](#invoices)
+ [Paramètres additionnels disponibles pour les téléchargements par API](#list_params)
+ [Factures (et autres documents) - exemples d'appels API](#examples)  
	+ [Télécharger la liste de factures du mois en cours](#download)
	+ [Télécharger la liste de factures d'une période donnée](#downloadmore)
	+ [Télécharger les factures d'un client](#downloadclient)
	+ [Télécharger un document (ex: facture) par son numéro d'ID](#downloadid)
	+ [Télécharger un document par son numéro](#downloadnr)
	+ [Télécharger les documents liés à un document donné](#download_id)
	+ [Télécharger les documents créés à partir d'un document donné](#download_from)
	+ [Télécharger sous format PDF](#downloadpdf)
	+ [Remarques : Paiement en ligne. Marge d'un document](#notedoc)
	+ [Envoyer les factures par email à un client](#send)
	+ [Créer un nouveau document](#create)
	+ [Créer une nouvelle facture (version rapide)](#create2)
	+ [Créer une facture avec réduction](#create3)
	+ [Créer un document similaire (ex: devis -> facture , facture -> facture)](#create4)
	+ [Créer une facture d'acompte](#create5)
	+ [Créer une facture de solde](#create6)
	+ [Créer une facture d'avoir (partielle)](#credit)
	+ [Créer une facture d'avoir (totale)](#credittotal)
	+ [Modifier une facture](#update)
	+ [Modifier un produit listé sur une facture](#update2)
	+ [Supprimer un produit listé sur une facture](#update3)
	+ [Ajouter un produit sur une facture](#update4)
	+ [Changer l'état d'une facture](#status)
	+ [Supprimer une facture](#deleteinvoice)
	+ [Télécharger la liste des récurrences](#downloadrecurring)
	+ [Créer une nouvelle récurrence](#createrecurring)
	+ [Mettre à jour une récurrence existante](#updaterecurring)
+ [Lien vers l'aperçu de la facture et le téléchargement en PDF](#view_url) 
+ [Département vendeur](#department)
	+ [Créer un nouveau département](#departadd)
	+ [Modifier un département](#departupdate)
	+ [Télécharger la liste des départements](#departlist)
	+ [Supprimer un département selon ID](#departdelete)
	+ [Obtenir un département selon ID](#departID)
	+ [Remarque : Champs](#departnote)
+ [Contacts](#clients)  
	+ [Télécharger la liste des contacts](#client)
	+ [Obtenir un contact selon son ID](#clientID)
	+ [Obtenir un contact selon le "Réf/code client"](#externalclientID)
	+ [Obtenir un contact selon son N° d'identification fiscale](#clienttax)
	+ [Obtenir un contact selon son nom](#clientname)
	+ [Obtenir un contact selon son nom d'usage](#clientshortname)
	+ [Obtenir un contact selon son adresse email](#clientemail)
	+ [Remarque](#noteclient1)
	+ [Ajouter un contact](#addclient)
	+ [Mettre à jour un contact](#updateclient)
	+ [Remarque: Champs](#noteclient)	
+ [Produits](#products)
	+ [Télécharger les produits](#productlist)
	+ [Télécharger les produits et quantités par entrepôt](#warehouse)
	+ [Obtenir un produit par son ID](#productID)
	+ [Obtenir un produit et quantité par son ID par entrepôt](#warehouseID)
	+ [Ajouter un produit](#productadd)
	+ [Mettre à jour un produit](#productupdate) 
	+ [Remarque: Champ](#noteproduct)
+ [Catégories](#categorie)
	+ [Liste des catégories](#categorielist)
	+ [Télécharger une catégorie sélectionnée par ID](#categorieID)
	+ [Ajouter une nouvelle catégorie](#categorienew)
	+ [Mettre à jour une catégorie](#categorieupdate)
	+ [Supprimer la catégorie avec l'ID donné](#categoriedelete)
+ [Documents de stock](#warehouse_documents) 
	+ [Télécharger les documents de stock](#wd1) 
	+ [Obtenir un document de stock par son ID](#wd2) 
	+ [Créer un bon d'entrée (BE)](#wd3) 
	+ [Créer un bon de livraison (BL)](#wd4) 
	+ [Créer un bon de transfert (BT)](#wd4t) 
	+ [Créer un bon d'entrée (BE) pour un contact, département, ou produit existant](#wd5) 
	+ [Mettre à jour un document de stock](#wd6) 
	+ [Supprimer un document de stock](#wd7) 
+ [Entrepôts](#warehouse)
	+ [Liste des entrepôts](#warehouselist)
	+ [Téléchargement de l'entrepôt sélectionné par son ID](#warehouseID)
	+ [Ajouter un nouvel entrepôt](#warehousenew)
	+ [Mettre à jour un entrepôt](#warehouseupdate)
	+ [Supprimer un entrepôt sélectionné par son ID](#warehousedelete)
+ [Paiements](#paiements)
	+ [Champs disponibles](#paiementschamps)
	+ [Télécharger la liste des Paiements](#paiementslist)
	+ [Obtenir un paiement par son ID](#paiementsid)
	+ [AJouter un nouveau paiement](#paiementsadd)
+ [Création de compte à partir d'application tierce](#accountsystem)
+ [Connexion via API](#connect)
+ [Exemples : CURL, PHP, Ruby](#exemples)

  


<a name="token"/>

## Code API

Le code API (`API_TOKEN`) de votre compte VosFactures est affiché dans les paramètres de votre compte: 
"Paramètres -> Paramètres du compte -> Intégration -> Code d'autorisation API". 
Le code API est du type "qCedKxkTgQhGJpiI2SU".</br> 
<b>Dans tous les exemples suivants, l'url votrecompte.vosfactures.fr est à remplacer avec l'url de votre propre compte.</b> 

<a name="invoices"/>

## Documents de facturation : Actions et Champs


* `GET /invoices/1.json` télécharge le document 
* `POST /invoices.json` ajoute un nouveau document
* `PUT /invoices/1.json` met à jour le document
* `DELETE /invoices/1.json` supprime le document


<b>Exemple</b> - Vous pouvez ajouter une nouvelle facture (ou autre) en complétant seulement les champs obligatoires (version minimale): si seuls les ID du produit (product_id), de l'acheteur (buyer_id) et du vendeur (department_id) sont indiqués, la facture créée sera datée du jour et aura une date limite de règlement de 5 jours. Le champ "department_id" représente l'ID du département vendeur (depuis Paramètres > Compagnies/Départments, cliquez sur le nom de la compagnie/département pour visualiser l'ID dans l'url affiché). Si aucun "department_id" n'est renseigné, le département principal sera choisi. 
```shell
curl https://votrecompte.vosfactures.fr/invoices.json 
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
 
<b>Champs d'un document de facturation</b>

```shell
"number" : "13/2012" - numéro du document (généré automatiquement si non indiqué)
"kind" : "vat" - type du document ("vat" pour facture, "estimate" pour devis, "proforma" pour facture proforma, "correction" pour avoir, "client_order" pour bon de commande de client, "receipt" pour reçu, "advance" pour facture d'acompte, "final" pour facture de solde, "invoice_other" pour autre type de document, "kp" pour bon d'entrée de caisse,"kw" pour bon de sortie de caisse)
"income" : "1" - revenu (1) ou dépense (0)
"user_id" : "" - numéro ID de l'utilisateur ayant créé le document (en cas de compte Multi-utilisateurs : https://aide.vosfactures.fr/2703898-Multi-utilisateurs-cr-ation-fonctions-et-restrictions)
"issue_date" : "2013-01-16" - date de création 
"place" : "Paris" - lieu de création
"sell_date" : "2013-01-16" - date additionnelle (ex: date de vente) : date complète ou juste mois et année:YYYY-MM. Pour ne pas faire apparaître cette date, indiquez "off" (ou décochez l'option "Afficher la Date additionnelle" depuis vos paramètres du compte).
"test" : "true" ou "false" - document test ou non (en savoir plus ici: http://aide.vosfactures.fr/15399051-Cr-er-un-Document-ou-Paiement-Test) 
"category_id" : "" - ID ou Nom de la catégorie : le système va d'abord regarder si la valeur renseignée correspond à un n° ID d'une catégorie existante, et ensuite à un Nom d'une catégorie existante. Si aucune valeur ne correspond, le système va créer une  nouvelle catégorie. 
"department_id" : "1" - ID du département vendeur (depuis Paramètres > Compagnies/Départments, cliquer sur le nom de la compagnie/département pour visualiser l'ID dans l'url affiché). Le système affichera alors automatiquement les coordonnées du département vendeur (nom, adresse...) sur le document (les autres champs "seller_" ne sont plus nécessaires). 
"seller_name" : "Ma Société" - Nom du département vendeur. Si ce champ n'est pas renseigné, le département principal est sélectionné par défaut. Préférez plutôt "department_id". Si vous utilisez toutefois "seller_name", le système tentera d'identifier le département portant ce nom, sinon il créera un nouveau département. 
"seller_tax_no" : "FR5252445767" - numéro d'identification fiscale du vendeur (ex: n° TVA)
"seller_tax_no_kind" : "", - initulé du numéro d'identification du vendeur : si non renseigné, il s'agit de "Numéro TVA", sinon il faut spécifier l'intitulé préalablement listé dans vos paramètres du compte, comme par exemple "SIREN" ou "CIF" (en savoir plus ici: http://aide.vosfactures.fr/1802938-Num-ro-d-identification-fiscale-de-votre-entreprise-TVA-SIREN-IDE-CIF-)
"seller_bank_account" : "24 1140 1977 0000 5921 7200 1001" - coordonnées bancaires du vendeur
"seller_bank" : "CREDIT AGRICOLE" - domiciliation bancaire
"seller_bank_swift" : "" - code bancaire BIC. Attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"seller_bank_swift":"BIC"} lors de la création d'un document de facturation. 
"seller_post_code" : "75007", code postal du vendeur
"seller_city" : "Paris" - ville du vendeur
"seller_street" : "21 Rue des Mimosas" - numéro et nom de rue du vendeur
"seller_country" : "" - pays du vendeur (ISO 3166)
"seller_email" : "contact@chose.com" - email du vendeur
"seller_www" : "" - site internet du vendeur
"seller_fax" : "" - numéro de fax du vendeur
"seller_phone" : "" - numéro de tel du vendeur
"seller_person" : "" - Nom du vendeur (figurant en bas de page des documents)
"client_id" : "-1" - ID du contact (si la valeur est -1 alors le contact sera créé et ajouté à la liste des contacts)
"buyer_name" : "Client Untel" - nom du contact (acheteur en cas de vente ou fournisseur en cas d'achat)
"buyer_first_name" : "Prénom" du contact
"buyer_last_name" : "Nom" du contact
"buyer_company": "1" - si le contact est un professionnel, "0" si c'est un particulier
"buyer_title" : Civilité du contact. Attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"buyer_title"":"Mme"} lors de la création d'un document de facturation. 
"buyer_tax_no" : "FR45362780010" - numéro d'identification fiscale du contact (ex: n° TVA)
"buyer_tax_no_kind" : "", - intitulé du numéro d'identification du contact : si non renseigné, il s'agit de "Numéro TVA", sinon il faut spécifier l'intitulé préalablement listé dans vos paramètres du compte, comme par exemple "SIREN" ou "CIF" (en savoir plus ici: https://aide.vosfactures.fr/19032497-Num-ro-d-identification-fiscale-des-contacts)
"disable_tax_no_validation" : "",
"use_moss": "0", - document sous le régime "Moss" (1) ou non (0) : régime de l'Autoliquidation de la TVA. En savoir plus ici: http://vosfactures.fr/tva-moss
"buyer_post_code" : "06000", code postal du contact
"buyer_city" : "Nice" - ville du contact
"buyer_street" : "44 Rue des Plans" - numéro et nom de rue du contact
"buyer_country" : "", pays du contact (ISO 3166)
"buyer_note" : "", description additionnelle du contact
"delivery_address" : "" - contenu du champ "Adresse supplémentaire" du contact
"use_delivery_address": "true" ou "false" - afficher ou non le champ "Adresse supplémentaire" du contact sur le document
"buyer_email" : "", email du contact
"buyer_phone" : "", numéro de tel du contact
"buyer_mobile_phone" : "" numéro de portable du contact
"additional_info" : "0" - afficher (1) ou non (0) la colonne aditionnelle sur le document de facturation (dont l'intitulé est à définir dans Paramètres du compte > Options par défaut)
"additional_info_desc" : "" - contenu de la colonne aditionnelle (contenu que vous retrouvez sur la fiche du produit correspondant) 
"additional_invoice_field" : "" - contenu du champ additionnel (dont l'intitulé est à définir dans Paramètres du compte > Options par défaut). Attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"additional_invoice_field":"contenu"} lors de la création d'un document de facturation. 
"show_discount" : "0" - afficher (1) ou non (0) la colonne réduction
"discount_kind": ""- type de réduction: "amount" (pour un montant ttc), "percent_unit" (pour un % sur le prix unitaire), ou  "percent_total" (pour un % calculé sur le prix total)
"payment_type" : "chèque" - mode de règlement 
"payment_to_kind" : date limite de règlement (parmi les options proposées). Si l'option est "Autre" ("other_date"), vous pouvez définir une date spécifique grâce au champ "payment_to". Si vous indiquez "5", la date d'échéance est de 5 jours. Pour ne pas afficher ce champ, indiquez "off". 
"payment_to" : "2013-01-16" - date limite de règlement
"sum_recovery" : "client_particulier" - afficher (client_professionnel) ou non (client_particulier) la mention "Indemnité forfaitaire de recouvrement". Attention, en json vous devez envoyer ce paramètre comme ceci: "additional_fields": {"sum_recovery":"client_professionnel"} lors de la création d'un document de facturation.
"interest_rate" : "10%" - Taux de pénalité en cas de retard de paiement (attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"interest_rate":"10%"} lors de la création d'un document de facturation. 
"advanced_payment_discount": "" - Escompte en % (attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"advanced_payment_discount":"10"} lors de la création d'un document de facturation)
"status" : "Créé" - état du document 
"paid" : "0,00" - montant payé
"oid" : "10021", - numéro de commande (ex: numéro généré par une application externe)
"oid_unique": si la valeur est «yes», alors il ne sera pas permis au système de créer 2 factures avec le même OID (cela peut être utile en cas de synchronisation avec une boutique en ligne)
"warehouse_id" : "1090" - numéro d'identification de l'entrepôt
"description" : "" - Informations spécifiques 
"paid_date" : "" - Date du paiement ("Paiement reçu le")
"currency" : "EUR" - devise
"lang" : "fr" - langue du document
"exchange_currency" : "USD" - convertir en (la conversion en une autre devise du montant total et du montant de la taxe selon taux de change du jour)
"exchange_kind" : "" - Source du taux de change utilisé en cas de conversion ("ecb" pour la Banque Centrale Européenne, "nbp" pour la Banque Nationale de Pologne, "cbr" pour la Banque Centrale de Russie, "nbu" pour la Banque Nationale d'Ukraine, "nbg" pour la Banque Nationale de Géorgie, "nbt" Banque Nationale Tchèque, "own" pour un taux propre)
"exchange_currency_rate" : "", - taux de change propre (à utiliser uniquement si le paramètre "exchange_kind" est égal à "own")
"title" : "" - Objet (attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"title":"contenu de l'objet"} lors de la création d'un document de facturation). 
"internal_note" : "" - Notes privées  
"invoice_template_id" : "1" - format d'impression
"description_long" : "" - Texte additionnel (imprimé sur la page suivante) 
"from_invoice_id" : "" - ID du document à partir duquel le document a été généré (utile par ex quand une facture est générée depuis un devis)
"invoice_id" : "" - ID du document de référence ayant un lien fonctionnel avec le document (ex: le devis de référence pour un acompte). 
"positions":
   		"product_id" : "1" - ID du produit
   		"name" : "Produit A" - nom du produit 
		"description" : "" - description du produit
   		"code" : "" - Référence du produit
   		"additional_info" : "" - contenu de la colonne additionnelle
   		"discount_percent" : "" - % de la réduction
   		"discount" : "", - montant ttc de la réduction
   		"quantity" : "1" - quantité 
   		"quantity_unit" : "kg" - unité 
   		"price_net" : "59,00", - prix unitaire HT (calculé automatiquement si non indiqué)
   		"tax" : "23" - % de taxe (les valeurs "disabled" ou "np" rendent la taxe inactive)
   		"price_gross" : "72,57" - prix unitaire TTC (calculé automatiquement si non indiqué)
   		"total_price_net" : "59,00" - total HT (calculé automatiquement si non indiqué)
   		"total_price_gross" : "72,57" - total TTC
                "kind":"text_separator" - pour insérer une ligne de texte, par ex: {"name":"texte", "kind":"text_separator"}
"hide_tax" : "1" - Montant TTC uniquement (ne pas afficher de montant HT ni de taxe) (attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"hide_tax":"1"} lors de la création d'un document de facturation)
"calculating_strategy" => 
{
  "position": "default" ou "keep_gross" - Comment se calcule le total de chaque ligne 
  "sum": "sum" ou "keep_gross" ou "keep_net" - Comment se calcule le total des colonnes 
  "invoice_form_price_kind": "net" ou "gross" - prix unitaire (HT ou TTC)
}
"split_payment": "1" - 1 ou 0 selon que la facture fait ou non l'objet d'un paiement partiel

```
<b>Remarque: Le paramètre "calculating_strategy"</b> correspond aux options de méthode de calcul, paramétrables par défaut depuis Paramètres > PAramètres du compte > Options par défaut > Section Montants, et également depuis le formulaire de création de chaque document de facturation. Si vous souhaitez utiliser le paramètre "calculating_strategy", il faut obligatoirement envoyer les 3 valeurs: "position",  "sum" et "invoice_form_price_kind". 

<b>Valeurs des Champs</b>

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

Champ: `test` - Document Test 
```shell
	"true" - document test 
	"false" - document non test

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
	"lcr" - LCR Lettre de Change Relevé
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

<a name="list_params"/>

## Paramètres additionnels des téléchargements

Des paramètres additionnels peuvent être transmis aux appels, ex: `page=`, `period=` etc... En effet vous pouvez utiliser les mêmes filtres que ceux du module de recherche proposé par le logiciel pour affiner les listes des documents/contacts/produits/paiements.</br>
Le paramètre `page =` vous permet de parcourir des enregistrements paginés.
Par défaut, il prend la valeur `1` et affiche les N premiers enregistrements, N étant la limite du nombre d’enregistrements retournés. Pour obtenir N autres enregistrements, appelez l’action avec le paramètre `page = 2`, etc.</br>
Le paramètre `period=` vous permet de  limiter les recherches à une période donnée. Voici les valeurs possibles : 
Possible values:
- last_12_months (12 derniers mois) qui est l'option par défaut
- this_month (mois en cours)
- last_30_days (30 derniers jours)
- last_month (mois dernier)
- this_year (année en cours)
- last_year (année dernière)
- all (tous)
- more (autre : dans ce cas, il faut spécifier les paramètres additionels ```date_from``` (date de début) et ```date_to``` (date de fin)

<a name="examples"/>

## Factures (et autres documents de facturation) - exemples d'appels API

<a name="download"/>
<b>Télécharger la liste des factures du mois en cours</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?period=this_month&api_token=API_TOKEN&page=1
```

<a name="downloadmore"/>
<b>Télécharger la liste des factures d'une période donnée</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?period=more&date_from=2018-01-01&date_to=2018-04-30&search_date_type=issue_date&api_token=API_TOKEN&page=1
```

<b>Remarque:</b> Si aucun paramètre additionnel n'est indiqué, seules les factures de la première page de la liste seront téléchargées (et donc les 25 premières factures). <b>Pour télécharger plus de 25 factures</b>, utilisez le paramètre additionnel `per_page=`, qui définit combien de documents chaque page contient (25, 50 ou 100).</br> 

Exemple: Pour obtenir les 50 premiers documents: 

```shell
curl "https://votrecompte.vosfactures/invoices.json?api_token=API_TOKEN&per_page=50"
```

Exemple: Pour obtenir les documents 51 à 100 :  

```shell
curl "https://votrecompte.vosfactures/invoices.json?api_token=API_TOKEN&per_page=50&page=2"
```

<a name="downloadclient"/>
<b>Télécharger les factures d'un client</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?client_id=ID_CLIENTA&api_token=API_TOKEN
```

<a name="downloadid"/>
<b>Télécharger une facture par numéro d'ID</b>


```shell
curl https://votrecompte.vosfactures.fr/invoices/100.json?api_token=API_TOKEN
```

<a name="downloadnr"/>
<b>Télécharger une facture par son numéro</b>


```shell
curl https://votrecompte.vosfactures.fr/invoices.json?number=25&api_token=API_TOKEN
```

<a name="download_id"/>
<b>Télécharger les documents liés à un document donné</b>

Les documents "liés" sont les documents qui ont un lien fonctionnel avec un autre document. Il s'agit des acomptes liés aux factures de solde et aux devis, et des avoirs liés aux factures. 

```shell
curl "https://votrecompte.vosfactures.fr/invoices.xml?invoice_id=ID&api_token=API_TOKEN"
```

<a name="download_from"/>
<b>Télécharger les documents créés à partir d'un document donné</b>

Les documents "créés à partir" d'un autre document sont les documents qui ont été créés en utilisant la fonction "Créer un doc. similaire", les factures créés à partir d'une proforma/devis/bon de commande, ainsi que les documents récurrents. 

```shell
curl "https://votrecompte.vosfactures.fr/invoices.xml?from_invoice_id=ID&api_token=API_TOKEN"
```

<a name="downloadpdf"/>
<b>Télécharger une facture sous format PDF</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices/100.pdf?api_token=API_TOKEN
```

Autres options PDF:
* print_option=original - Original
* print_option=copy - Copie 
* print_option=original_and_copy - Original et copie
* print_option=duplicate - Duplicata

<a name="notedoc"/>
<b>Remarques</b>:<br> 
Le paramètre ```payment_url``` vous permet d'obtenir l'url du paiement en ligne d'une facture (dans le cadre de la fonction Paiement en ligne).</br> 
La variable ```products-margin``` est retournée lors de l'appel API d'un document. Cette variable correspond au montant de la marge brute totale du document.<br> <br> 


<a name="send"/>
<b>Envoyer une facture par email à un client</b>


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


<a name="create"/>

<b>Créer un nouveau document (ex : facture)</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
  	-H 'Accept: application/json' \
	-H 'Content-Type: application/json' \
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
			"buyer_name": "Client Untel",
			"buyer_tax_no": "FR45362780010",
			"positions":[
				{"name":"Produit A1", "tax":23, "total_price_gross":10.23, "quantity":1},
				{"name":"Produit A2", "tax":0, "total_price_gross":50, "quantity":3}
			]		
		}
	}'
```

<b>Remarques importantes</b></br>
<b>Coordonnées vendeur</b></br>
Si votre département (fiche entreprise) a déjà été créé, envoyez le paramètre ```department_id```(et non ```seller_name```).</br>
<b>Documents Tests</b></br>
Si vous faites des essais, pensez à utiliser le paramètre ```test``` (dont la valeur peut être "true" ou "false") afin de créer des documents de facturation qui seront distingués en tant que documents "test" (au niveau du numéro et de la présentation). 

<a name="create2"/>
<b>Créer une nouvelle facture (version rapide)</b></br>

Vous pouvez ajouter une nouvelle facture en complétant seulement les champs obligatoires (version minimale): si seuls les ID du produit (```product_id```), de l'acheteur (```buyer_id```) et du vendeur (```department_id```) sont indiqués, la facture créée sera datée du jour et aura une date limite de règlement de 5 jours.

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
		"invoice": {
			"department_id": 1, 
			"client_id": 1,
			"positions":[
				{"product_id": 1, "quantity":2}
			]
	    }}'
```	   

<b>Remarque</b></br>
Si vous obtenez le message suivant: 
{"code":"error","message":{"seller_bank_account":["Protection contre la modification du numéro de compte bancaire"]}}
cela signifie que vous avez choisi un niveau de sécurité standard ou élevé contre le changement de compte bancaire (Paramètres > Paramètres du compte > Options par défaut > Sécurité) et que vous essayez tout de même de créer un document avec des coordonnées bancaires différentes de celles indiquées dans la fiche du département vendeur (Paramètres > Compagnies/départements). Il faut donc soit changer le niveau de sécurité, soit vérifier les coordonnées bancaires envoyées. 

<a name="create3"/>

<b>Créer une nouvelle facture avec réduction</b>

Il faut indiquer dans la partie document l'affichage ("show_discount") et le type ("discount_kind") de réduction, et dans la partie produit la valeur ("discount") de la réduction. 

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
		"invoice": {
			 "kind":"vat",
			 "number": null,
			 "issue_date": "2018-02-22",
			 "payment_to": "2018-03-01",   
			 "buyer_name": "Client Untel",  
			 "discount_kind":"amount",
			 "show_discount":true,
			 "positions":[
			 	{"name":"Produit A",
				"quantity":1,
				"tax":23,
				"total_price_gross":10.23,
				 "discount":"5.23"
				 },
				{"name":"Produit B",
				"quantity":2,
				"tax":0,
				"total_price_gross":50,
				}   
			     ]   
		}}'
```

<a name="create4"/>

<b>Créer un document similaire</b></br>

Vous pouvez créer un document (ex : facture) similaire à un autre document de facturation existant (ex: devis) grâce à un appel API correspondant à l'option "Créer un document similaire" ou à l'option "Créer la facture" du logiciel. Vous pouvez ainsi créer un document en tout point similaire à un document existant (le n° du document créé étant bien sûr automatiquement généré conformément à vos paramètres du numérotation).

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "copy_invoice_from": ID_du_document_source,
            "kind": "Type_du_document_à_créer"
        }
    }'
```

<b>Exemple : Créer la facture depuis un devis</b></br>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "copy_invoice_from": ID_du_devis,
            "kind": "vat"
        }
    }'
```

<b>Exemple : Créer la facture depuis une facture proforma</b></br>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "copy_invoice_from": ID_de_la_proforma,
            "kind": "vat"
        }
    }'
```   
    
 <b>Exemple : Dupliquer une facture </b></br>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "copy_invoice_from": ID_de_la_facture,
            "kind": "vat"
        }
    }'
```   

<a name="create5"/>

<b>Créer une facture d'acompte</b></br></br>
<b>Facture d'acompte en tant que pourcentage du montant total d'un devis</b></br>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "copy_invoice_from": ID_du_devis,
            "kind": "advance",
            "advance_creation_mode": "percent",
            "advance_value": "30",
            "position_name": "Acompte de 30% sur devis n° 123"
        }
    }'
```

<b>Facture d'acompte en tant que montant depuis un devis</b></br>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "copy_invoice_from": ID_du_devis,
            "kind": "advance",
            "advance_creation_mode": "amount",
            "advance_value": "150",
            "position_name": "Acompte de 150€ sur devis n° 123"
        }
    }'
```

<a name="create6"/>

<b>Créer une facture de solde</b></br>
Une fois le(s) acomptes créé(s), vous pouvez facturer le solde facilement en créant la facture de solde qui reprendra le détail du devis en y déduisant les acomptes déjà facturés.

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "copy_invoice_from": ID_du_devis,
            "kind": "final",
            "invoice_ids": [ID_du_premier_acompte, ID_du_deuxième_acompte, ...]
        }
    }'
```

<a name="credit"/>

<b>Créer une facture d'avoir (partielle)</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{"api_token": "API_TOKEN",
        "invoice": {
            "kind": "correction",
	    "correction_reason": "erreur de quantité",
            "from_invoice_id": "2432393",
	    "invoice_id": "2432393",
            "client_id": 1,
            "positions":[
                {"name": "Produit A1",
                "quantity":-1,
                "total_price_gross":"-10",
                "tax":"23",
		"kind":"correction"
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
<b>Remarque</b>: Si vous souhaitez afficher sur la facture d'avoir le numéro de la facture de référence (qui apparaît sous la forme de la mention "Avoir sur Facture N°xxxx"), il est conseillé d'utiliser le paramètre ```invoice_id``` (en y indiquant le n° ID de la facture de référence) qui créera le lien fonctionnel entre la facture et la facture d'avoir. Sinon, vous pouvez alternativement utiliser le paramètre ```from_invoice_id``` (en indiquant également le n° ID de la facture), ou ```correction``` (en indiquant le contenu que vous souhaitez afficher) - mais dans ces deux cas aucun lien fonctionnel n'est créé. 

<a name="credittotal"/>

<b>Créer une facture d'avoir (totale)</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
                -H 'Accept: application/json' \
                -H 'Content-Type: application/json' \
                -d '{
                    "api_token":"API_TOKEN",
                    "invoice": {
                        "copy_invoice_from": 2432393,
                        "kind": "correction",
                        "total_correction": "1",
                        "correction_reason": "commande annulée"
                    }
                }'
```
En attribuant la valeur "1" au paramètre ```total_correction```, une facture d'avoir totale est créée. Si au contraire vous indiquez la valeur "0", le montant de la facture d'avoir sera de zéro (car émise avec des lignes de produits identiques avant et après la correction). 

<a name="update"/>
<b>Modifier une facture</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices/111.json \
	-X PUT \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \  
	-d '{
		"api_token": "API_TOKEN",
		"invoice": {
			"buyer_name": "Nouveau nom du client"
		}
	}'
```

<a name="update2"/>
<b>Modifier un produit listé sur une facture</b></br>

Il faut spécifier l'ID du produit. 

```shell
curl https://votrecompte.vosfactures.fr/invoices/111.json \
    -X PUT \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "positions": [{"id":32649087, "name":"test"}]
        }
    }'
```
    
<a name="update3"/>
<b>Supprimer un produit listé sur une facture</b></br> 

Pour supprimer un article sur la facture, entrez l'ID du produit avec le paramètre "_destroy" égal à 1. 

```shell
curl https://votrecompte.vosfactures.fr/invoices/111.json \
        -X PATCH \
	-H 'Accept:application/json' \
	-H 'Content-Type:application/json' \
	-d '{
	         "api_token": "API_TOKEN",
                 "invoice": {
                        "positions":[{"id":32649087,"_destroy":1}]
              }
	 }'
```   

<a name="update3"/>
<b>Ajouter un produit sur une facture</b>

Notez que le produit ajouté sera listé en dernier sur le document de facturation. 

```shell
curl https://votrecompte.vosfactures.fr/invoices/111.json \
    -X PUT \
    -H 'Accept: application/json'  \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "positions": [{"name":"Produit A1", "tax":20, "total_price_gross":10.20, "quantity":1}]
        }
    }'
 ```

<a name="status"/>
<b>Changer l'état d'une facture</b>

```shell
curl "https://votrecompte.vosfactures.fr/invoices/111/change_status.json?api_token=API_TOKEN&status=STATUS" -X POST
```

<b>Remarque : Documents "Exportés"</b> </br>
En terme de suivi comptable, vous avez la possibilité d'afficher la colonne "Exporté" sur la liste des documents, vous permettant ainsi de visualiser rapidement les documents ayant fait l'objet d'un export - cet état "exporté" étant mis à jour automatiquement par le système après un export. Vous pouvez forcer cet état en envoyant le paramètre :</br> "accounting_status" : "exported"
</br>P.S: Depuis l'aperçu du document, dans l'encadré "suivi du document" il y a aura la trace d'une activité "Modification" avec la date et l'heure.  

<a name="deleteinvoice"/>
<b>Supprimer une facture</b>

```shell
curl -X DELETE "https://YOUR_DOMAIN.fakturownia.pl/invoices/INVOICE_ID.json?api_token=API_TOKEN"
```

<a name="downloadrecurring"/>
<b>Télécharger la liste des récurrences</b>

```shell
curl https://votrecompte.vosfactures.fr/recurrings.json?api_token=API_TOKEN
```

<a name="createrecurring"/>
<b>Créer une nouvelle récurrence</b>

Dans l'exemple ci-dessous, la récurrence est basée sur un document existant identifié par son ID ("invoice_id"), débute le 01/01/2016 ("start_date"), est mensuelle ("every"), est créée avec un état non payé ("create_as_paid"), à 11H30 ("time_in_timezone") même si c'est un week-end ("issue_working_day_only"), et n'a pas de date de fin ("end_date"). Les factures récurrentes générées sont envoyées automatiquement au client ("buyer_email") par email ("send_email") et une notification vous est envoyée ("email_notification_enabled"). Les paramètres  "only_year_month" (correspondant à l'option "Afficher uniquement le mois et l'année dans le champ "Date additionnelle") et "end_of_month_sell_date" (correspondant à l'option "Générer avec une date additionnelle égale au dernier jour du mois") ne peuvent pas avoir la même valeur "true" en même temps. 


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
	    "time_in_timezone": "11:30", 
            "issue_working_day_only": false,
	    "only_year_month": false,
	    "end_of_month_sell_date": false,
	    "invoice_pattern_enabled": true,
	    "invoice_pattern": "F/nr",
	    "convert_to_vat_invoice":true
	    "create_as_paid": false,
            "send_email": true,
            "buyer_email": "client1@email.fr, client2@email.fr",
	    "email_notification_enabled":true,
            "end_date": "null",
	    "comment": ""
        }}'
```

Vous pouvez également créer une récurrence non basée sur un document de référence. Pour cela, il suffit de spécifier le département vendeur (ID), le détail des produits (ID, quantité, prix, devise), contact (ID), et conditions de paiement, qui devront apparaître sur les factures générées par la récurrence.

```shell
curl https://votrecompte.vosfactures.fr/recurrings.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{"api_token": "API_TOKEN",
        "recurring": {
            "name": "Nom de la récurrence",
	    "income": "true",
	    "department_id": 259461,
            "product_id": 20419921,
	    "quantity": '1',
	    "price_gross": "20,00",
	    "currency": "EUR",
	    "client_id": 16673825,
	    "buyer_email": "client1@email.fr, client2@email.fr"
	    "payment_to": "1m",
            "start_date": "2019-03-02",
            "every": "1m",
	    "time_in_timezone": "11:30", 
            "issue_working_day_only": false,
	    "create_as_paid": false,
	    "only_year_month": false,
	    "end_of_month_sell_date": false,
	    "invoice_pattern_enabled": "true",
	    "invoice_pattern": "F/nr",
	    "convert_to_vat_invoice":false,
	    "send_email": true,
            "buyer_email": "client1@email.fr, client2@email.fr",
	    "email_notification_enabled":true,
            "end_date": "null",
	    "comment": "",
        }}'
```

<b>Pour résumer : Champs d'une récurrence</b> 
```shell
"name": "Nom de la récurrence" 
"start_date": "2019-03-02" - Date de création du 1er document récurrent
"next_invoice_date": "2019-03-02" - Date de création du prochain document récurrent 
"every": "1m" - Récurrence ("1w" -> hebdomadaire, "1m" -> mensuelle, "2m" -> bimestrielle, "3m" -> trimestrielle, "6m" -> semestrielle, "1y" -> annuelle)
"time_in_timezone": "11:30" - Heure de création
"issue_working_day_only": true ou false - Créer uniquement en semaine
"convert_to_vat_invoice":true ou false - Générer des factures (au cas où le document de référence est une profroma)
"create_as_paid": true ou false - Générer les documents récurrents avec l'état Payé.
"only_year_month": true ou false - Afficher uniquement le mois et l'année dans le champ "Date additionnelle"
"end_of_month_sell_date": true ou false - Générer avec une date additionnelle égale au dernier jour du mois
"invoice_pattern_enabled": true ou false - Autre que le format de numérotation par défaut (l'option ne s'applique pas en cas de dépenses). Si vous donnez la valeur "true", vous devez alors spécifier le format de numérotation souhaité via le paramètre "invoice_pattern" (ex: "invoice_pattern": "F/nr")
"send_email": true ou false - Envoi automatique de chaque nouveau document au client par email
"email_notification_enabled":true ou false - Notification envoyée sur l'email du propriétaire du compte à chaque document généré.
"end_date": "null" - Date de fin (date du dernier document généré)
"comment": "" - Commentaires (privés) de la récurrence
```

<a name="updaterecurring"/>
<b>Mettre à jour une récurrence existante</b> (ex: changement de la date de la prochaine facture)

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

## Lien vers l'aperçu de la facture et le téléchargement en PDF

Après le téléchargement des données de la facture, par ex:

```shell
curl https://votrecompte.vosfactures.fr/invoices/100.json?api_token=API_TOKEN
```

L'API renvoie le champ `token`, grâce auquel il est possible de recevoir les liens vers l'aperçu de la facture et de son téléchargement en pdf. Ces liens vous permettent de faire référence à la facture sélectionnée sans avoir à vous connecter - vous pouvez, par exemple, envoyer ces liens à votre client qui aura accès à l'aperçu et au PDF des factures.

Les liens sont sous la forme: 

vers l'aperçu: `https://votrecompte.vosfactures.fr/invoice/{{token}}`

vers le pdf: `https://votrecompte.vosfactures.fr/invoice/{{token}}.pdf`

Par exemple, pour un token égal à `HBO3Npx2OzSW79RQL7XV2`, le PDF sera accessible à l'url suivant: `https://votrecompte.vosfactures.fr/invoice/HBO3Npx2OzSW79RQL7XV2.pdf`


<a name="department"/>

## Département vendeur

<a name="departadd"/>
<b>Créer un nouveau département</b>

Vous pouvez créer votre département (fiche entreprise) soit lors de la création d'un document (voir plus bas), soit directement : 

```shell
curl https://votrecompte.vosfactures.fr/departments.json   
        -H 'Accept: application/json' \
	-H 'Content-Type: application/json' \
	-d '{
    		"api_token": "API_TOKEN",
		"department": {    
			"name": "Entreprise ABC",    "shortcut": "ABC"
		}
	}'  
```

<a name="departupdate"/>
<b>Modifier un département</b>

```shell
curl https://votrecompte.vosfactures.fr/departments/100.json  
        -X PUT 
        -H 'Accept: application/json'   
        -H 'Content-Type: application/json'   
        -d '{ 
        "api_token": "API_TOKEN", 
        "department": { 
          "name":"nouveau_nom",  
          "shortcut": "nouveau_nom_usage", 
          "tax_no": "xxx-xxx-xx-xx" 
        }}' 
```

<a name="departlist"/>
<b>Télécharger la liste des départements</b>

```shell
curl "https://votrecompte.vosfactures.fr/departments.json?api_token=API_TOKEN"
```

<a name="departdelete"/>
<b>Supprimer un département selon ID</b>

```shell
curl -X DELETE "https://votrecompte.vosfactures.fr/departments/100.json?api_token=API_TOKEN"
```

<a name="departID"/>
<b>Obtenir un département selon ID</b>

```shell
curl "https://votrecompte.vosfactures.fr/departments/100.json?api_token=API_TOKEN"
```

<a name="departnote"/>
<b>Remarque : Champs</b>
</br>Voici les champs que vous pouvez utiliser: 

```shell

"name" : "Entreprise ABC" - Nom du département vendeur 
"shortcut" : "ABC" - Nom d'usage du département (interne)
"kind":"SARL" - Forme juridique
"main":true - Département principal (true) ou non (false) (en cas de multidépartements)
"tax_no_kind":"" - Titre du type de n° d'immatriculation (ex: "TVA", "Siren" ...) - par défaut TVA
"tax_no" :"" - N° d'immatriculation - par défaut TVA
"post_code" : "75022" - Code Postal
"city" : "Paris" - Ville 
"street" : "32 Rue du commerce" - N° et nom de rue
"country" : "France" - Pays
"person" : "Nom vendeur" - Nom du vendeur (en savoir plus ici:http://aide.vosfactures.fr/468616-Nom-du-vendeur)
"email" : "abc@compagnie.com"
"phone" : "" - Téléphone 
"mobile_phone" : "" - Téléphone Portable
"www" : "" - site internet
"fax" : "" - Fax
"bank" : "" - Domiciliation bancaire
"bank_account" : "" - IBAN (ou n° de compte bancaire)
"bank_swift" :"" - BIC
"bank_account_currency" : "EUR" - devise du compte bancaire
"bank_accountancy_account" : "" - compte comptable banque (de la fonction "Plan Comptable": https://aide.vosfactures.fr/3069258-Exports-comptables-journaux-comptes-comptables)
"invoice_lang" : "fr" - Langue des documents par défaut (pour bilingue indiquez par ex "fr/de")
"invoice_description" : "" - Contenu par défaut du champ 'Informations spécifiques' des documents
"default_tax":"20" - Taux de taxe par défaut (pour un taux de taxe inactif indiquez "disabled")
"invoice_template_id" : 2400 - ID du format par défaut (en cas de multidépartements)
"cash_init_state" : ""150.0" - Total initial des espèces détenues
"footer_content" : "" - Contenu du bas de page personnalisé. Il convient d'envoyer également le paramètre "footer_kind": "own".
"use_pattern" : false - Numérotation indépendante des documents de ce département (en cas de multi-départements). Si true, indiquez les champs correspondants (ex: "invoice_pattern":"Fyyyy.mm.nr" pour les factures, "pattern_estimate":"FA-yymm-nr-m" pour les devis etc ...)
"own_email_settings" : false - Paramétrage indépendant du système d'envoi des emails (en cas de multi-départements). Si true, indiquez les champs correspondants ("email_from":"","email_cc":"","email_subject":"","email_template":null,"email_template_kind":"default","email_pdf":true,"own_overdue_email_settings":false,"overdue_email_subject":"","overdue_email_template":null,"overdue_email_template_kind":"default","overdue_email_pdf":true)
"restrict_warehouses" : false - Option "Restriction des entrepôts" activée (true) ou désactivée (false)
"warehouse_id" : null - ID des entrepôts en cas d'option "Restriction des entrepôts" activée
```

<a name="clients"/>

## Contacts

<a name="client"/>
<b>Télécharger la liste des contacts (par page)</b>

```shell
curl "https://votrecompte.vosfactures.fr.com/clients.json?api_token=API_TOKEN&page=1"
```
<a name="clientID"/>
<b>Obtenir un contact selon son ID</b>

```shell
curl "https://votrecompte.vosfactures.fr.com/clients/100.json?api_token=API_TOKEN"
```

<a name="externalclientID"/>
<b>Obtenir un contact selon son "Réf/code client"</b>

```shell
curl "https://votrecompte.vosfactures.fr.com/clients.json?external_id=100&api_token=API_TOKEN"
```

<a name="clienttax"/>
<b>Obtenir un contact selon son N° d'identification fiscale</b>

```shell
curl "https://votrecompte.vosfactures.fr.com/clients.json?tax_no=100&api_token=API_TOKEN"
```

<a name="clientname"/>
<b>Obtenir un contact selon son nom</b>

```shell
curl "https://votrecompte.vosfactures.fr.com/clients.json?name=NOM&api_token=API_TOKEN"
```

<a name="clientshortname"/>
<b>Obtenir un contact selon son nom d'usage</b>

```shell
curl "https://votrecompte.vosfactures.fr.com/clients.json?shortcut=NOM_USAGE&api_token=API_TOKEN"
```

<a name="clientemail"/>
<b>Obtenir un contact selon son adresse email</b>

```shell
curl "https://votrecompte.vosfactures.fr.com/clients.json?email=EMAIL&api_token=API_TOKEN"
```

<a name="noteclient1"/>
<b>Remarque:</b><br>
<b>La variable "panel_url"</b> est retournée lors de l'appel API d'un contact. Cette variable correspond au lien url de l'espace client (de la fonction Accès Client).
<br><br>

<a name="addclient"/>
<b>Ajouter un contact</b>

```shell
curl https://votrecompte.vosfactures.fr/clients.json \ 
	-H 'Accept: application/json' \  
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
		"client": {
			"name" : "Client1",
			"tax_no" : "FR5252445333",
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
			
	    }}'
```

<a name="updateclient"/>
<b>Mettre à jour un contact</b>

```shell
curl https://votrecompte.vosfactures.fr/clients/111.json \ 
	-X PUT  \
	-H 'Accept: application/json'  \ 
	-H 'Content-Type: application/json'  \ 
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
	    }}'
```

<a name="noteclient"/>
<b>Remarque: Champs fiche contact</b>

```shell
"note":"" -  description additionnelle
"payment_to_kind":"" -  Date limite de règlement par défaut
"accounting_id":"" -  Compte comptable général (de la fonction Plan Comptable: https://aide.vosfactures.fr/3069258-Exports-comptables-journaux-comptes-comptables ) 
"accounting_id2":"" -  Compte comptable auxiliaire
"chorus_identifier_type":"" - Typage Identifiant Débiteur (Chorus Pro). Voici les valeurs numériques (de 1 à 6) que vous pouvez attribuer à ce paramètre:
"1" pour "Tiers avec SIRET"
"2" pour "Structure Européenne hors France"
"3" pour "Structure hors UE"
"4" pour "RIDET"
"5" pour "Numéro Tahiti"
"6" pour "Autre"
"chorus_identifier":"123456789" - Identifiant Débiteur (Chorus Pro)
"chorus_service_code":"" - Code Service Débiteur (Chorus Pro)
```


<a name="products"/>

## Produits


<a name="productlist"/>
<b>Télécharger la Liste des produits (par page)</b>


```shell
curl "https://votrecompte.vosfactures.fr/products.json?api_token=API_TOKEN&page=1"
```

<a name="warehouse"/>
<b>Télécharger la liste des produits et quantités pour un entrepôt en particulier (par page)</b>

```shell
curl "https://votrecompte.ivosfactures.fr/products.json?api_token=API_TOKEN&warehouse_id=WAREHOUSE_ID&page=1"
```

<a name="productID"/>
<b>Obtenir un produit selon son ID</b>

```shell
curl "https://votrecompte.vosfactures.fr/products/100.json?api_token=API_TOKEN"
```

<a name="warehouseID"/>
<b>Obtenir un produit et sa quantité selon son ID pour un entrepôt en particulier</b>

```shell
curl "https://votrecompte.vosfactures.fr/products/100.json?api_token=API_TOKEN&warehouse_id=WAREHOUSE_ID"
```

<a name="productadd"/>
<b>Ajouter un produit</b>


```shell
curl https://votrecompte.vosfactures.fr/products.json \ 
	-H 'Accept: application/json' \  
	-H 'Content-Type: application/json' \  
	-d '{"api_token": "API_TOKEN",
		"product": {
			"name": "ProduitA" - nom
			"code": "A001" - référence
			"price_gross": "100" - prix unitaire TTC
			"tax": "20" - % de taxe
	    }}'
```

<a name="productupdate"/>
<b>Mettre à jour un produit</b>

```shell
curl https://votrecompte.vosfactures.fr/products/333.json  \
	-X PUT \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \  
	-d '{"api_token": "API_TOKEN",
		"product": {
			"name": "ProduitA" - nom
			"code": "A0012" - référence
			"price_gross": "102" - prix unitaire TTC
			"tax": "20" - % de taxe
	    }}'
```

<b>Remarque</b>: Le prix HT d'un produit est calculé par le système sur la base du prix TTC et du taux de taxe - il ne peut donc pas être directement mis à jour par API.


<a name="noteproduct"/>
<b>Remarques</b></br>
<b>Champs fiche produit</b>

```shell
"accounting_id" : "" - Compte comptable (produits) (de la fonction Plan Comptable: https://aide.vosfactures.fr/3069258-Exports-comptables-journaux-comptes-comptables )
"accounting_id2" : "" - Compte comptable (charges) 
"accounting_tax_code" : "" -  Compte comptable TVA (vente)
"accounting_tax_code_exp" : "" - Compte comptable TVA (achat)
"accounting_activity_code" : "" - Code Activité
"accounting_sheet_code" : "" - Code Journal
```

<b>Filtres</b>
```shell
"disabled" pour rechercher les produits inactifs, ex: 
curl "https://votrecompte.vosfactures.fr/products.json?filter=disabled&api_token=API_TOKEN&page=1"
```

<a name="categorie"/>
	 
## Catégories

<a name="categorielist"/>
<b>Liste des catégories</b>

```shell
curl " https://votrecompte.vosfactures.fr/categories.json?api_token=API_TOKEN "
```

<a name="categorieID"/>
<b>Télécharger une catégorie sélectionnée par ID</b>

```shell
curl " https://votrecompte.vosfactures.fr/categories/100.json?api_token=API_TOKEN "
```

<a name="categorienew"/>
<b>Ajouter une nouvelle catégorie </b>

```shell
curl https://votrecompte.vosfactures.fr/categories.json 
				-H 'Accept: application/json'  
				-H 'Content-Type: application/json'  
				-d '{
				"api_token": "API_TOKEN",
				"category": {
					"name":"catégorie A", 
					"description": null
				}}'
```

<a name="categorieupdate"/>
<b> Mettre à jour une catégorie </b>

```shell
curl https://votrecompte.vosfactures.fr/categories/100.json 
				-X PUT
				-H 'Accept: application/json'  
				-H 'Content-Type: application/json'  
				-d '{
				"api_token": "API_TOKEN",
				"category": {
					"name":"catégorie A", 
					"description": "description nouvelle"
				}}'
```
<a name="categoriedelete"/>
<b>Supprimer la catégorie avec l'ID donné </b>

```shell
curl -X DELETE " https://votrecompte.vosfactures.fr/categories/100.json?api_token=API_TOKEN "
```


<a name="warehouse_documents"/>

## Documents de stock 


<a name="wd1"/>
<b>Télécharger les documents de stock</b>
 
```shell 
curl "https://votrecompte.vosfactures.fr/warehouse_documents.json?api_token=API_TOKEN" 
``` 
Vous pouvez utiliser les mêmes paramètres que ceux décrits pour les documents de facturation. 
 
<a name="wd2"/> 
<b>Obtenir un document de stock par son ID </b>
 
```shell 
curl "https://votrecompte.vosfactures.fr/warehouse_documents/555.json?api_token=API_TOKEN" 
``` 

<a name="wd3"/> 
<b>Créer un bon d'entrée (BE)</b> 
 
```shell 
curl https://votrecompte.vosfactures.fr/warehouse_documents.json 
	-H 'Accept: application/json' 
	-H 'Content-Type: application/json' 
	-d '{ 
	"api_token": "API_TOKEN", 
	"warehouse_document": { 
	"kind":"pz", 
	"number": null, 
	"warehouse_id": "1", 
	"issue_date": "2017-10-23", 
	"department_name": "Department1", 
	"client_name": "Fournisseur1", 
	"warehouse_actions":[ 
	{"product_name":"Produit A1", "purchase_tax":20, "purchase_price_net":10.20, "quantity":1}, 
	{"product_name":"Produit A2", "purchase_tax":0, "purchase_price_net":50, "quantity":2} 
	]	
	}}' 
``` 
 
<a name="wd4"/> 
<b>Créer un bon de livraison (BL)</b>
 
```shell 
curl https://votrecompte.vosfactures.fr/warehouse_documents.json 
	-H 'Accept: application/json' 
	-H 'Content-Type: application/json' 
	-d '{ 
	"api_token": "API_TOKEN", 
	"warehouse_document": { 
	"kind":"wz", 
	"number": null, 
	"warehouse_id": "1", 
	"issue_date": "2017-10-23", 
	"department_name": "Department1", 
	"client_name": "Client1", 
	"warehouse_actions":[ 
	{"product_id":"333", "tax":20, "price_net":10.20, "quantity":1}, 
	{"product_id":"444", "tax":0, "price_net":50, "quantity":2} 
	]	
	}}' 
``` 
<a name="#wd4t"/>
<b>Créer un bon de transfert (BT)</b>
```shell 
curl https://votrecompte.vosfactures.fr/warehouse_documents.json 
                -H 'Accept: application/json'  
                -H 'Content-Type: application/json'  
                -d '{
                "api_token": "API_TOKEN",
                "warehouse_document": {
                    "kind":"mm", 
                    "number": null,
                    "warehouse_id": "1",
                    "issue_date": "2017-10-23", 
                    "department_name": "Department1 SA", 
                    "client_name": "Client ABC",
                    "warehouse_actions":[
                        {"product_name":"Produit A1", "purchase_tax":20, "purchase_price_net":10.20, "quantity":1, "warehouse2_id":13}
                    ]
                }}'
```
 
<a name="wd5"/> 
<b>Créer un bon d'entrée (BE) pour un contact, département, ou produit existant </b>
 
```shell 
curl https://votrecompte.vosfactures.fr/warehouse_documents.json 
	-H 'Accept: application/json' 
	-H 'Content-Type: application/json' 
	-d '{ 
	"api_token": "API_TOKEN", 
	"warehouse_document": { 
	"kind":"pz", 
	"number": null, 
	"warehouse_id": "1", 
	"issue_date": "2017-10-23", 
	"department_id": "222", 
	"client_id": "111", 
	"warehouse_actions":[ 
	{"product_id":"333", "purchase_tax":20, "price_net":10.20, "quantity":1}, 
	{"product_id":"444", "purchase_tax":0, "price_net":50, "quantity":2} 
	]	
	}}' 
``` 
 
<a name="wd6"/>  
<b>Mettre à jour un document de stock</b>
 
```shell 
curl https://votrecompte.vosfactures.fr/warehouse_documents/555.json 
	-X PUT 
	-H 'Accept: application/json' 
	-H 'Content-Type: application/json' 
	-d '{"api_token": "API_TOKEN", 
	"warehouse_document": { 
	"client_name": "Nouveau contact" 
	}}' 
``` 
 
<a name="wd7"/>  
<b>Supprimer un document de stock</b> 
 
```shell 
curl -X DELETE "https://votrecompte.vosfactures.fr/warehouse_documents/100.json?api_token=API_TOKEN" 
``` 

<a name="warehouse"/>  
<b>Entrepôts</b>

<a name="warehouselist"/>
<b>Liste des entrepôts</b>

```shell 
curl "https://votrecompte.vosfactures.fr/warehouses/100.json?api_token=API_TOKEN" 
``` 

<a name="warehouseID"/>
<b>Téléchargement de l'entrepôt sélectionné par son ID</b>

```shell 
curl "https://votrecompte.vosfactures.fr/warehouses/100.json?api_token=API_TOKEN" 
``` 

<a name="warehousenew"/>
<b>Ajouter un nouvel entrepôt</b>

```shell 
curl https://votrecompte.vosfactures.fr/warehouses.json 
				-H 'Accept: application/json'  
				-H 'Content-Type: application/json'  
				-d '{
				"api_token": "API_TOKEN",
				"warehouse": {
					"name":"Entrepôt A", 
					"kind": null,
					"description": null
				}}'
``` 

<a name="warehouseupdate"/>
<b>Mettre à jour un entrepôt</b>
	
```shell 
curl https://votrecompte.vosfactures.fr/warehouses/100.json 
				-X PUT
				-H 'Accept: application/json'  
				-H 'Content-Type: application/json'  
				-d '{
				"api_token": "API_TOKEN",
				"warehouse": {
					"name":Entrepôt A", 
					"kind": null,
					"description": "nouvelle description"
				}}'
``` 
	
<a name="warehousedelete"/>
<b>Supprimer un entrepôt sélectionné par ID</b>

```shell 
curl -X DELETE "https://votrecompte.vosfactures.fr/warehouses/100.json?api_token=API_TOKEN" 
``` 


<a name="paiements"/>

## Paiements

Vous pouvez via l'API ajouter un paiement que vous retrouverez dans votre onglet "Paiements" de votre compte VosFactures, qu'il s'agisse d'un paiement manuel, ou d'un paiement en ligne (réalisé depuis une facture via la fonction "Paiement en ligne", ou depuis le wigdet de paiement de la fonction "Paiements E-commerce").

<a name="paiementschamps"/>

### Champs disponibles

Coordonnées de l'acheteur apparaissant dans les champs "grisés" du paiement (et non sur la facture) :
```shell
"last_name" - Nom de famille
"first_name" - Prénom 
"street" - N° et nom de rue
"city" - Ville 
"post_code" - Code Postal
"country" - Pays
"client_id" - ID de l'acheteur 
"phone" - Téléphone
"email" - Email 
```

Coordonnées de l'acheteur apparaissant sur la facture correspondant au paiement :
```shell
"generate_invoice" - "1" ou "0" : Générer une facture correspondant au paiement une fois celui-ci payé (quand "paid" est égal à 1)
"invoice_id" - ID de la facture qui reçoit le paiement 
"invoice_name" - Nom 
"invoice_street" - N° et nom de rue
"invoice_city" - Ville
"invoice_post_code" - Code Postal
"invoice_country" - Pays
"invoice_tax_no" - N° d'identification fiscal 
```
Concernant le paiement : 
```shell
"price" - Montant du paiement
"name" - Titre du paiement
"description" - Description du paiement
"comment" - Commentaire du paiement
"currency" - Devise du paiement
"paid_date" - Date du paiement
"department_id" - ID du département vendeur concerné 
"oid" - N° de commande qu reçoit le paiement
"paid" - "1" ou "0" pour indiquer si le Paiement est "payé" ou non <Boolean>
"kind" - Type de paiement (origine). Si ajouté par API, la valeur devrait être "api".
"provider"- Nom de la plateforme de paiement (en cas de Paiement en Ligne)
"provider_response" - Réponse de la plateforme de paiement (en cas de Paiement en Ligne)
"provider_status" - Etat du paiement selon la plateforme de paiement (en cas de Paiement en Ligne)
"provider_title" - Titre de la plateforme de paiement (en cas de Paiement en Ligne)
```

En cas de widget de paiement (Fonction "Paiements E-commerce"):
```shell
"invoice_comment" - Commentaire  éventuellement laissé par l'acheteur (n'apparaît pas sur les factures)
"product_id" - ID du produit à l'origine du paiement 
"quantity" - Quantité du produit 
"promocode" - Code promotionnel
```

<a name="paiementslist"/>
<b>Télécharger la liste des Paiements</b>

XML
```shell
curl "https://votrecompte.vosfactures.fr/banking/payments.xml?api_token=API_TOKEN"
```

JSON
```shell
curl "https://votrecompte.vosfactures.fr/banking/payments.json?api_token=API_TOKEN"
```

<a name="paiementsid"/>
<b>Obtenir un paiement selon son ID</b>

XML
```shell
curl "https://votrecompte.vosfactures.fr/banking/payments/100.xml?api_token=API_TOKEN"
```

JSON
```shell
curl "https://votrecompte.vosfactures.fr/banking/payment/100.json?api_token=API_TOKEN"
```    

<a name="paiementsadd"/>
<b>Ajouter un nouveau paiement</b>

Minimal JSON
```shell
curl https://votrecompte.vosfactures.fr/banking/payments.json 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{
		"api_token": "API_TOKEN",
		"banking_payment": {	
			"name":"Titre du Paiement",
			"price": 100.00,
			"invoice_id": null,
			"paid":true,
			"kind": "api"
	     	}
	     }'
```

Full JSON
```shell
curl https://votrecompte.vosfactures.fr/banking/payments.json 
	-H 'Accept: application/json'  
	-H 'Content-Type: application/json'  
	-d '{
		"api_token": "API_TOKEN",
		"banking_payment": {	
			"city": null,
			"client_id":null,
			"comment":null,
			"country":null,
			"currency":"EUR",
			"department_id":null,
			"description":"abonnement mensuel",
			"email":"email@email.com",
			"first_name":"Paul",
			"generate_invoice":true,			
			"invoice_city":"Paris",
			"invoice_comment":"",
			"invoice_country":null,
			"invoice_id":null,
			"invoice_name":"Durand Paul",
			"invoice_post_code":"06800",
			"invoice_street":"75 Rue du Parc",
			"invoice_tax_no":"FR5252445767",
			"last_name":"Durand",
			"name":"Titre du Paiement",
			"oid":"",
			"paid":true,
			"paid_date":null,
			"phone":null,
			"post_code":null,
			"price":"100.00",
			"product_id":1,
			"promocode":"",
			"provider":"virement",
			"provider_response":null,
			"provider_status":null,
			"provider_title":null,
			"quantity":1,
			"street":null,
			"kind": "api"
		}
	     }'
```
 
<a name="accountsystem"/>

## Création de compte(s) à partir d'application tierce

C'est une option utile si, en tant qu'utilisateur de VosFactures, vous avez une application tierce et souhaitez offrir à vos clients/utilisateurs de votre application une solution de facturation. Il est en effet possible via l'API de créer et configurer des comptes de facturation sur VosFactures à partir d'une application tierce (exemple: site e-commerce, système de réservation, etc...).<br/>Ainsi directement depuis votre portail, votre client/utilisateur peut créer un compte avec un seul bouton et commencer immédiatement à émettre des factures (il n'a pas besoin de créer son compte depuis le site vosfactures.fr).

<b>Création d'un nouveau compte </b>
</br>Pour créer un compte depuis votre application intégrée, vous avez besoin d'envoyer :</br> 
   - le paramètre ```integration_token``` (code d'intégration) lié à votre compte. Vous devez simplement nous contacter par email à info@vosfactures.fr afin de l'obtenir.</br>
   - le code API de votre compte<br/>
   - le préfixe du compte à créer<br/>
   - l'utilisateur qui sera propriétaire du compte à créer (si ce n'est pas vous-même)<br/>
<br/>Les champs suivants ne sont pas obligatoires : ```user.login```, ```user.from_partner```, ```user```, ```company``` (département du compte à créer). 

```shell
curl https://votrecompte.vosfactures.fr/account.json \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
            "api_token": "API_TOKEN",
            "account": {
                "prefix": "ABC"
		"lang": "fr"
            },
            "user": {
                "login": "identifiantABC",
                "email": "email@abc.com",
                "password": "motdepasseABC",
                "from_partner": "code_parrainage"
            },
            "company": {
                "name": "Société ABC",
                "tax_no": "FR5252445700",
                "post_code": "06000",
                "city": "Nice",
                "street": "Rue de la Joie",
                "person": "Julie Durand",
                "bank": "Crédit Niçois",
                "bank_account": "111222333444555666111"
            },
	    "integration_token": ""
        }'
```
REMARQUE: le paramètre ```integration_token``` est requis pour télécharger le code API actuel de l'utilisateur.

<b>Après avoir créé le nouveau compte :</b>


```shell
{
	"prefix":"ABC", - préfixe du compte créé (notez qu'il peut être différent de celui voulu lorsqu'un compte avec le même préfixe existe déjà)
	"api_token":"62YPJfIekoo111111", - code API du compte créé
	"url":"https://ABC.vosfactures.fr", - url du compte créé
	"login":"identifiantABC", - identifiant de l'utilisateur (notez qu'il peut être différent de celui voulu lorsqu'un utilisateur avec le même identifiant existe déjà)
	"email":"email@abc.com"
}
```

<b>Autres champs disponibles lors de la création d'un nouveau compte (utile pour l'intégration)</b>

```shell
	"account": {
		"prefix": "ABC",
		"lang": "fr",
		"integration_fast_login": true - permet la connexion automatique de vos utilisateurs dans VosFactures
		"integration_logout_url": "https://votresite.com/" - vous permet de renvoyer vos utilisateurs sur votre site après la déconnexion des utilisateurs de VosFactures
	}
```
Obtenir des informations sur le compte:

```shell
curl "https://votrecompte.vosfactures.fr/account.json?api_token=API_TOKEN&integration_token="
```

<a name="connect"/>

## Connexion via API

La requête suivante (qui nécessite le mot de passe) renvoie le code API du compte et les informations sur le compte VosFactures :
```shell
curl https://app.vosfactures.fr/login.json \
    -H 'Accept: application/json'  \
    -H 'Content-Type: application/json' \
    -d '{
            "login": "identifiant_ou_email",
            "password": "mot_de_passe"
	    "integration_token": ""
    }'
``` 
REMARQUE: Pour recevoir le "integration_token", veuillez nous contacter par email à info@vosfactures.fr.

Voici la réponse retournée, qui inclut notamment le `prefixe`, l' `url` et le code API du compte : 
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
Notez que le code API (```api_token```) n'est retourné que si l'utilisateur indiqué a préalablement généré le code API (l'utilisateur peut l'ajouter depuis Paramètres -> Paramètres du compte -> Intégration -> Code d'autorisation API). 

<a name="exemples"/>

## Exemples 


CURL: https://github.com/vosfactures/API/blob/master/example.curl

PHP: https://github.com/vosfactures/API/blob/master/example1.php

Ruby: https://github.com/vosfactures/API/blob/master/example1.rb

