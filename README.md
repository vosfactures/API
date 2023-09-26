# API du Logiciel de Facturation en ligne VosFactures


Intégrer votre site internet ou une application externe avec le logiciel de facturation en ligne [VosFactures](https://vosfactures.fr)



Grâce à l'API de VosFactures, vous pouvez créer automatiquement des factures et autres documents (devis, bon de commande, bon de livraison ...), produits, contacts, ou paiements depuis des applications externes.</br>Par exemple, si vous avez un E-commerce et que vous vendez en ligne depuis votre site internet, vous pouvez via l'API faire en sorte qu'à chaque vente réalisée sur votre site, la facture correspondante soit automatiquement générée sur votre compte VosFactures, et même envoyée directement par email à votre client.</br> 
</br>Vous pouvez créer un compte gratuitement sur <https://vosfactures.fr/> et tester notre API. </br>Des exemples pratiques de requêtes API sont également disponibles depuis votre compte VosFactures (onglet Paramètres > API) et sur <https://app.vosfactures.fr/api>.</br>Les exemples sont basés sur l'interface CURL mais vous pouvez utiliser n'importe quel autre outil. Les requêtes peuvent être envoyées sous format <b>JSON ou XML</b> (il suffit de changer l'extension json par xml). Toutes les requêtes fonctionnent avec SSL. Il est donc conseillé de remplacer <b>http par https</b> en production. 

## Menu
+ [Code API](#token)
+ [Documents de facturation - actions et champs](#invoices)
+ [Paramètres additionnels disponibles pour les téléchargements par API](#list_params)
+ [Factures (et autres documents) - exemples d'appels API](#examples)  
	+ [Télécharger la liste de factures du mois en cours](#download)
	+ [Télécharger la liste de factures d'une période donnée](#downloadmore)
	+ [Télécharger les dernières factures modifiées](#downloadmore2)
	+ [Télécharger la liste de factures avec les produits listés](#downloadpdt)
	+ [Télécharger les factures d'un client](#downloadclient)	
	+ [Télécharger un document (ex: facture) par son numéro d'ID](#downloadid)
	+ [Télécharger un document par son numéro](#downloadnr)
	+ [Télécharger les documents liés à un document donné](#download_id)
	+ [Télécharger les documents créés à partir d'un document donné](#download_from)
	+ [Télécharger sous format PDF](#downloadpdf)
	+ [Remarques : Paiement en ligne. Marge d'un document](#notedoc)
	+ [Envoyer une facture par email](#send)
	+ [Créer un nouveau document](#create)
	+ [Créer une nouvelle facture (version rapide)](#create2)
	+ [Créer une facture avec réduction](#create3a)
	+ [Créer une facture avec sous-total](#create3b)
	+ [Créer une facture avec ligne de texte](#create3c)
	+ [Créer une facture en autoliquidation](#create3d)
	+ [Créer une facture pour une vente OSS](#create3e)
	+ [Créer un document similaire (ex: devis -> facture , facture -> facture)](#create4)
	+ [Créer une facture d'acompte](#create5)
	+ [Créer une facture de solde](#create6)
	+ [Créer une facture d'avoir (partielle)](#credit)
	+ [Créer une facture d'avoir (totale)](#credittotal)
	+ [Créer une facture à compléter](#completed)
	+ [Modifier une facture](#update)
	+ [Modifier un produit listé sur une facture](#update2)
	+ [Supprimer un produit listé sur une facture](#update3)
	+ [Ajouter un produit sur une facture](#update4)
	+ [Changer l'état d'une facture](#status)
	+ [Ajouter une pièce jointe à une facture](#file)
	+ [Télécharger les pièces jointes d'une facture dans un fichier ZIP](#filezip)
	+ [Supprimer une facture](#deleteinvoice)
	+ [Annuler une facture](#cancelinvoice)
	+ [Télécharger la liste des récurrences](#downloadrecurring)
	+ [Créer une nouvelle récurrence](#createrecurring)
	+ [Modifier une récurrence existante](#updaterecurring)
+ [Liens vers l'aperçu de la facture et le téléchargement en PDF](#view_url) 
+ [Département vendeur](#department)
	+ [Créer un département](#departadd)
	+ [Modifier un département](#departupdate)
	+ [Télécharger la liste des départements](#departlist)
	+ [Obtenir un département selon ID](#departID)
	+ [Supprimer un département selon ID](#departdelete)
	+ [Ajouter un logo à un département](#departlogo)
	+ [Remarque : Champs](#departnote)
+ [Contacts](#clients)  
	+ [Télécharger la liste des contacts](#client)
	+ [Télécharger les derniers contacts modifiés](#client2)
	+ [Obtenir un contact selon son ID](#clientID)
	+ [Obtenir un contact selon le "Réf/code client"](#externalclientID)
	+ [Obtenir un contact selon son N° d'identification fiscale](#clienttax)
	+ [Obtenir un contact selon son nom](#clientname)
	+ [Obtenir un contact selon son nom d'usage](#clientshortname)
	+ [Obtenir un contact selon son adresse email](#clientemail)
	+ [Remarque](#noteclient1)
	+ [Créer un contact](#addclient)
	+ [Modifier un contact](#updateclient)
	+ [Supprimer un contact](#deleteclient)
	+ [Remarque: Champs](#noteclient)	
+ [Produits](#products)
	+ [Télécharger les produits](#productlist)
	+ [Télécharger les produits et quantités par entrepôt](#warehouse)
	+ [Obtenir un produit par son ID](#productID)
	+ [Obtenir un produit et quantité par son ID par entrepôt](#warehouseID)
	+ [Créer un produit](#productadd)
	+ [Créer un produit lot](#productaddlot)
	+ [Modifier un produit](#productupdate) 
	+ [Remarque: Champs](#noteproduct)
+ [Multi-Tarifs](#tarifs)
	+ [Télécharger la liste des Tarifs](#tarifs1)
	+ [Créer un Tarif](#tarifs2)
	+ [Modifier un Tarif](#tarifs3)
	+ [Supprimer un Tarif](#tarifs4)
	+ [Facturer avec un Tarif](#tarifs5)
+ [Catégories](#categorie)
	+ [Télécharger la liste des catégories](#categorielist)
	+ [Obtenir une catégorie selon son ID](#categorieID)
	+ [Créer une catégorie](#categorienew)
	+ [Modifier une catégorie](#categorieupdate)
	+ [Supprimer une catégorie avec l'ID donné](#categoriedelete)
+ [Documents de stock](#warehouse_documents) 
	+ [Télécharger les documents de stock](#wd1)
	+ [Télécharger les documents de stock d'une période donnée](#wd1bis)
	+ [Obtenir un document de stock par son ID](#wd2) 
	+ [Créer un bon d'entrée (BE)](#wd3) 
	+ [Créer un bon de livraison (BL)](#wd4) 
	+ [Créer un bon de transfert (BT)](#wd4t) 
	+ [Créer un bon d'entrée (BE) pour un contact, département, ou produit existant](#wd5) 
	+ [Modifier un document de stock](#wd6) 
	+ [Supprimer un document de stock](#wd7) 
+ [Entrepôts](#warehouse)
	+ [Liste des entrepôts](#warehouselist)
	+ [Téléchargement de l'entrepôt sélectionné par son ID](#warehouseID)
	+ [Créer un entrepôt](#warehousenew)
	+ [Modifier un entrepôt](#warehouseupdate)
	+ [Supprimer un entrepôt sélectionné par son ID](#warehousedelete)
+ [Opérations des stocks](#warehouseaction)
	+ [Télécharger la liste des opérations](#warehouseactionlist)
	+ [Paramètres additionnels de téléchargement](#warehouseactionpara)
+ [Paiements](#paiements)
	+ [Champs disponibles](#paiementschamps)
	+ [Télécharger la liste des Paiements](#paiementslist)
	+ [Télécharger la liste des Paiements avec les factures liées](#paiementsinvoice)
	+ [Obtenir un paiement par son ID](#paiementsid)
	+ [Ajouter un nouveau paiement](#paiementsadd)
	+ [Ajouter un nouveau paiement à plusieurs factures](#paiementsadd2)
	+ [Modifier un paiement](#updatepayment)
	+ [Supprimer un paiement](#deletepayment)
+ [Gestion des Comptes](#accountsystem)
	+  [Créer de compte](#accountsystem1)
	+  [Télécharger les informations de compte](#accountsystem2)
	+  [Supprimer un compte](#accountsystem3)
+ [Création d'utilisateur](#usersystem)
+ [Connexion via API](#connect)
+ [Webhooks](#webhooks)
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


<b>Exemple</b> - Vous pouvez ajouter une nouvelle facture (ou autre) en complétant seulement les champs obligatoires (version minimale): si seuls les ID du produit (`product_id`), de l'acheteur (`buyer_id`) et du vendeur (`department_id`) sont indiqués, la facture créée sera datée du jour et aura une date limite de règlement de 5 jours. Le champ `department_id` représente l'ID du département vendeur (depuis Paramètres > Compagnies/Départments, cliquez sur le nom de la compagnie/département pour visualiser l'ID dans l'url affiché). Si aucun "department_id" n'est renseigné, le département principal sera choisi. 
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
"kind" : "vat" - type du document : "vat" pour facture, "correction" pour avoir, "receipt" pour reçu, "advance" pour facture d'acompte, "final" pour facture de solde, "invoice_other" pour autre type de document comptable, "estimate" pour devis, "proforma" pour facture proforma, "client_order" pour bon de commande client, "maintenance_request" pour bon d'intervention, "payment_receipt" pour reçu de paiment, "kw" pour versements en espèces, "kp" pour reçus en espèces.
"income" : "1" - revenu (1) ou dépense (0)
"user_id" : "" - numéro ID de l'utilisateur ayant créé le document (en cas de compte Multi-utilisateurs : https://aide.vosfactures.fr/2703898-Multi-utilisateurs-cr-ation-fonctions-et-restrictions)
"issue_date" : "2013-01-16" - date de création 
"place" : "Paris" - lieu de création
"sell_date" : "2013-01-16" - date additionnelle (ex: date de vente) : date complète ou juste mois et année:YYYY-MM. Pour ne pas faire apparaître cette date, indiquez "off" (ou décochez l'option "Afficher la Date additionnelle" depuis vos paramètres du compte).
"test" : "true" ou "false" - document test ou non (en savoir plus ici: https://aide.vosfactures.fr/15399051-Cr-er-un-Document-ou-Paiement-Test) 
"category_id" : "" - ID ou Nom de la catégorie : le système va d'abord regarder si la valeur renseignée correspond à un n° ID d'une catégorie existante, et ensuite à un Nom d'une catégorie existante. Si aucune valeur ne correspond, le système va créer une  nouvelle catégorie. 
"department_id" : "1" - ID du département vendeur (depuis Paramètres > Compagnies/Départments, cliquer sur le nom de la compagnie/département pour visualiser l'ID dans l'url affiché). Le système affichera alors automatiquement les coordonnées du département vendeur (nom, adresse...) sur le document (les autres champs "seller_" ne sont plus nécessaires). 
"seller_name" : "Ma Société" - Nom du département vendeur. Si ce champ n'est pas renseigné, le département principal est sélectionné par défaut. Préférez plutôt "department_id". Si vous utilisez toutefois "seller_name", le système tentera d'identifier le département portant ce nom, sinon il créera un nouveau département. 
"seller_tax_no" : "FR5252445767" - numéro d'identification fiscale du vendeur (ex: n° TVA)
"seller_tax_no_kind" : "", - initulé du numéro d'identification du vendeur : si non renseigné, il s'agit de "Numéro TVA", sinon il faut spécifier l'intitulé préalablement listé dans vos paramètres du compte, comme par exemple "SIREN" ou "CIF" (en savoir plus ici: https://aide.vosfactures.fr/1802938-Num-ro-d-identification-fiscale-de-votre-entreprise-TVA-SIREN-IDE-CIF-)
"seller_bank_account" : "24 1140 1977 0000 5921 7200 1001" - coordonnées bancaires du vendeur
"seller_bank" : "CREDIT AGRICOLE" - domiciliation bancaire
"seller_bank_swift" : "" - code bancaire BIC. Attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"seller_bank_swift":"BIC"} lors de la création d'un document de facturation. 
"seller_post_code" : "75007" - code postal du vendeur
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
"disable_tax_no_validation" : ""
"use_oss" (précédemment "use_moss"): "" - document à identifier comme une vente "OSS" (true) ou non (false) car les conditions s'appliquent (= vente B2C avec la TVA du pays d'un acheteur européen non assujetti). En savoir plus ici: https://aide.vosfactures.fr/96973539-E-Commerce-TVA-OSS
"identify_oss" : "true" - document automatiquement identifié par le logiciel comme une vente "OSS" si les conditions s'appliquent. 
"force_tax_oss" : "true" - document identifié par le logiciel comme une vente "OSS" peu importe les taux de taxe envoyés si la condition d'un acheteur européen non assujetti s'applique.
"reverse_charge" : "true" - document identifié comme soumis à autoliquidation ("true") ou non ("false") : correspond à l'option "Autoliquidation" qui, si cochée sur un document, supprime la colonne taxe (montant HT uniquement) et affiche la mention d'autoliquidation. En savoir plus ici : https://aide.vosfactures.fr/11598606-Facturer-en-Autoliquidation-de-TVA
"buyer_post_code" : "06000" - code postal du contact
"buyer_city" : "Nice" - ville du contact
"buyer_street" : "44 Rue des Plans" - numéro et nom de rue du contact
"buyer_country" : "" - pays du contact (ISO 3166)
"buyer_note" : "", description additionnelle du contact
"delivery_address" : "" - contenu du champ "Adresse supplémentaire" du contact
"use_delivery_address": "true" ou "false" - afficher ou non le champ "Adresse supplémentaire" du contact sur le document
"buyer_email" : "" - email du contact
"buyer_phone" : "" - numéro de tel du contact
"buyer_mobile_phone" : "" - numéro de portable du contact
"additional_info" : "0" - afficher (1) ou non (0) la colonne aditionnelle sur le document de facturation (dont l'intitulé est à définir dans Paramètres du compte > Options par défaut)
"additional_info_desc" : "" - contenu de la colonne aditionnelle (contenu que vous retrouvez sur la fiche du produit correspondant) 
"additional_invoice_field" : "" - contenu du champ additionnel (dont l'intitulé est à définir dans Paramètres du compte > Options par défaut). Attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"additional_invoice_field":"contenu"} lors de la création d'un document de facturation. 
"show_discount" : "0" - afficher (1) ou non (0) la colonne réduction
"discount_kind": "" - type de réduction: "amount" (pour un montant ttc), "percent_unit" (pour un % sur le prix unitaire ht), "percent_unit_gross" (pour un % sur le prix unitaire ttc)ou  "percent_total" (pour un % calculé sur le prix total)
"payment_type" : "card" - mode de règlement. Les valeurs par défaut disponibles sont listées plus bas dans le paragraphe "Valeurs des Champs".
"payment_to_kind" : "5" - date limite de règlement (parmi les options proposées). Si vous indiquez "5", la date d'échéance est de 5 jours. Si l'option est "Autre" ("other_date"), vous pouvez définir une date spécifique grâce au champ "payment_to". Pour ne pas afficher ce champ, indiquez "off". 
"payment_to" : "2013-01-16" - date limite de règlement
"sum_recovery" : "client_particulier" - afficher (client_professionnel) ou non (client_particulier) la mention "Indemnité forfaitaire de recouvrement". Attention, en json vous devez envoyer ce paramètre comme ceci: "additional_fields": {"sum_recovery":"client_professionnel"} lors de la création d'un document de facturation.
"interest_rate" : "10%" - Taux de pénalité en cas de retard de paiement (attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"interest_rate":"10%"} lors de la création d'un document de facturation. 
"advanced_payment_discount": "" - Escompte en % (attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"advanced_payment_discount":"10"} lors de la création d'un document de facturation)
"status" : "Créé" - état du document 
"paid" : "0,00" - montant payé
"paid_from" et "paid_to" - "Payé à partir du" et "Payé jusqu'au" : paramètres renvoyés lors du téléchargement d'une facture  
"oid" : "10021" - numéro de commande (ex: numéro généré par une application externe)
"oid_unique": si la valeur est "yes", alors il ne sera pas permis au système de créer 2 factures avec le même OID (cela peut être utile en cas de synchronisation avec une boutique en ligne)
"warehouse_id" : "1090" - numéro d'identification de l'entrepôt
"description" : "" - Informations spécifiques 
"paid_date" : "" - Date du paiement ("Paiement reçu le")
"currency" : "EUR" - devise
"lang" : "fr" - langue du document
"exchange_currency" : "USD" - convertir en (la conversion en une autre devise du montant total et du montant de la taxe selon taux de change du jour)
"exchange_kind" : "" - Source du taux de change utilisé en cas de conversion ("ecb" pour la Banque Centrale Européenne, "nbp" pour la Banque Nationale de Pologne, "cbr" pour la Banque Centrale de Russie, "nbu" pour la Banque Nationale d'Ukraine, "nbg" pour la Banque Nationale de Géorgie, "nbt" Banque Nationale Tchèque, "own" pour un taux propre)
"exchange_currency_rate" : "" - Taux de change personnalisé (à utiliser uniquement si le paramètre "exchange_kind" est égal à "own")
"title" : "" - Objet (attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"title":"contenu de l'objet"} lors de la création d'un document de facturation). 
"description":"" - Informations spécifiques
"conditional_notes" : "" - Mentions spécifiques (ajoutées automatiquement selon les critères définis dans les Paramètres du compte (https://aide.vosfactures.fr/109954556-Ventes-en-ligne-Mentions-sp-cifiques) 
"description_long" : "" - Texte additionnel (imprimé sur la page suivante) 
"internal_note" : "" - Notes privées  
"invoice_template_id" : "1" - format d'impression
"from_invoice_id" : "" - ID du document à partir duquel le document a été généré (utile par ex quand une facture est générée depuis un devis)
"invoice_id" : "" - ID du document de référence ayant un lien fonctionnel avec le document (ex: le devis de référence pour un acompte). 
"positions":
   		"product_id" : "1" - ID du produit
   		"name" : "Produit A" - nom du produit 
		"description" : "" - description du produit
   		"code" : "" - Référence du produit
   		"additional_info" : "" - contenu de la colonne additionnelle
   		"discount_percent" : "" - % de la réduction
   		"discount" : "" - montant ttc de la réduction
   		"quantity" : "1" - quantité 
   		"quantity_unit" : "kg" - unité 
   		"price_net" : "59,00", - prix unitaire HT (calculé automatiquement si non indiqué)
   		"tax" : "23" - % de taxe (les valeurs "disabled" ou "np" rendent la taxe inactive)
   		"price_gross" : "72,57" - prix unitaire TTC (calculé automatiquement si non indiqué)
   		"total_price_net" : "59,00" - total HT (calculé automatiquement si non indiqué)
   		"total_price_gross" : "72,57" - total TTC
                "kind":"text_separator" - pour insérer une ligne de texte (voir exemple plus bas)
		"kind":"subtotal" - pour insérer un sous-total (voir exemple plus bas)
"hide_tax" : "1" - Montant TTC uniquement (ne pas afficher de montant HT ni de taxe) (attention, en json vous devez envoyer ce paramètre comme ceci:  "additional_fields": {"hide_tax":"1"} lors de la création d'un document de facturation)
"tax_split": "" - résumé des différents taux de taxe : paramètres renvoyés lors du téléchargement d'une facture
"calculating_strategy" : 
{
  "position": "default" ou "keep_gross" - Comment se calcule le total de chaque ligne 
  "sum": "sum" ou "keep_gross" ou "keep_net" - Comment se calcule le total des colonnes 
  "invoice_form_price_kind": "net" ou "gross" - prix unitaire (HT ou TTC)
}
"split_payment": "1" - 1 ou 0 selon que la facture fait ou non l'objet d'un paiement partiel
"corrected_content_before": "" - contenu à corriger (champ disponible lors de la création de facture d'avoir)
"corrected_content_after": "" - contenu corrigé (champ disponible lors de la création de facture d'avoir)
```
<b>Remarque: Le paramètre "calculating_strategy"</b> correspond aux options de méthode de calcul, paramétrables par défaut depuis Paramètres > Paramètres du compte > Options par défaut > Section Montants, et également depuis le formulaire de création de chaque document de facturation. Si vous souhaitez utiliser le paramètre "calculating_strategy", il faut obligatoirement envoyer les 3 valeurs: "position",  "sum" et "invoice_form_price_kind". 

<b>Valeurs des Champs</b>

Champ: `kind`- Type du document
```shell
	"vat" - facture 
	"advance" - facture d'acompte
	"final" - facture de solde
	"correction" - facture d'avoir
	"receipt" - reçu
	"invoice_other" - Autre type de facture
	"estimate" - devis
	"client_order" - bon de commande
	"maintenance_request" - bon d'intervention
	"proforma" -  facture Proforma
	"payment_receipt" - reçu de paiement 
	"kp" - bon d'entrée de caisse
	"kw" - bon de sortie de caisse	
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
	"el" - Grec
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
	"percent_unit" - % calculé sur le prix unitaire ht
	"percent_unit_gross" - % sur le prix unitaire ttc
	"percent_total" - % calculé sur le montant total
	"amount" - montant
```

<a name="list_params"/>

## Paramètres additionnels des téléchargements (filtres)

Des paramètres additionnels peuvent être transmis aux appels, ex: `page=`, `period=` etc... En effet vous pouvez utiliser les mêmes filtres que ceux du module de recherche proposé par le logiciel pour affiner les listes des documents/contacts/produits/paiements.</br>

Le paramètre `page =` vous permet de parcourir des enregistrements paginés.
Par défaut, il prend la valeur `1` et affiche les N premiers enregistrements - N étant défini par le paramètre `per_page =` (valeur maximale 100) qui correspond à nombre maximal d’enregistrements retournés par page. Pour obtenir N autres enregistrements, appelez l’action avec le paramètre `page = 2`, etc.</br>

Le paramètre `period=` vous permet de limiter les recherches à une période donnée. Voici les valeurs possibles :
```shell
- last_12_months (12 derniers mois) qui est l'option par défaut
- this_month (mois en cours)
- last_30_days (30 derniers jours)
- last_month (mois dernier)
- this_year (année en cours)
- last_year (année dernière)
- all (tous)
- more (autre : dans ce cas, il faut spécifier les paramètres additionels `date_from (date de début) et `date_to` (date de fin))
```

En utilisant le paramètre `search_date_type` vous pouvez spécifier le type de date à prendre en compte pour une recherche par période. Pour les documents de facturation, vous pouvez rechercher par date de création (`issue_date`), date additionnelle (`sell_date`), ou date de paiement (`paid_date`). Vous pouvez aussi trier les factures par date de la dernière modification (`order=updated_at`)
Pour les documents de stock, vous pouvez rechercher par date de création (`issue_date`) ou date de vente (`transaction_date`).</br>

Le paramètre `income =` vous permet d'obtenir soit la liste des documents de vente (avec la valeur `1`) soit la liste des dépenses (avec la valeur `0`).</br>

Le paramètre `invoice_ids =` permet d'obtenir des documents de facturation via leur numéro ID. Par exemple : `invoice_ids=123,456,789`

Le paramètre `include_positions =` (avec la valeur `true`) vous permet d'obtenir la liste des documents avec les produits listés sur ces documents.</br> 

Le paramètre `number =` permet de télécharger un document de facturation via son numéro.</br>

Le paramètre `kind =` permet de rechercher un seul type de document (exemple : `kind=vat`).</br>

Le paramètre `kinds =` permet de rechercher plusieurs types de documents (exemple : `&kinds[]=vat&kinds[]=estimate`).</br>

Le paramètre `order =` permet de choisir comment les factures appelées seront triées. Voici les valeurs possibles pour un tri ascendant : 

```shell
`number` - par numéro de facture
`updated_at` - par date de dernière modificationi
`price_net` - par total HT
`price_gross` - par total TTC
`price_tax` - par total de Taxe
`issue_date` - par date d'envoi 
`payment_to` - par date limite de règlement
`paid_date` - par date de paiement effectif
`transaction_date` - par date additionnelle
`buyer_name` - par nom de l'acheteur
`buyer_tax_no` - par n° fiscal de l'acheteur
`seller_name` - par nom du vendeur
`oid` - par n° de commande
```
Pour un tri déscendant, il suffit d'ajouter le suffixe <b>.desc</b> - par exemple `updated_at.desc`.

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
<a name="downloadmore2"/>
<b>Télécharger les dernières factures modifiées</b>

```shell
curl "https://votrecompte.vosfactures.fr/invoices.json?order=updated_at&api_token=API_TOKEN&per_page=50"
```

<a name="downloadclient"/>
<b>Télécharger les factures d'un client</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?client_id=ID_CLIENTA&api_token=API_TOKEN
```

<a name="downloadpdt"/>
<b>Télécharger la liste des factures avec les produits listés</b>	

```shell
curl https://votrecompte.vosfactures.fr/invoices.json?include_positions=true&api_token=API_TOKEN&page=1
```

<a name="downloadid"/>
<b>Télécharger une facture par numéro d'ID</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices/100.json?api_token=API_TOKEN
```
<b>Remarque :</b>	 
En cas de facture d'avoir, vous pouvez télécharger les deux champs supplémentaires "Contenu à corriger" et "Contenu corrigé" :
```shell
curl https://votrecompte.vosfactures.fr/invoices/100.json?api_token=API_TOKEN&additional_fields[invoice]=corrected_content_before,corrected_content_after
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
<b>Remarques :</b><br> 
Le paramètre `payment_url` vous permet d'obtenir l'url du paiement en ligne d'une facture (dans le cadre de la fonction Paiement en ligne).</br> 
La variable `products-margin` est retournée lors de l'appel API d'une facture. Cette variable correspond au montant de la marge brute totale de la facture de vente.<br> <br> 


<a name="send"/>
<b>Envoyer une facture par email</b><br>

<b>Par défaut :</b><br> 

-> A l'adresse email indiquée sur la facture ou à défaut sur la fiche contact :
```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?api_token=API_TOKEN
```

-> lorsqu'aucune adresse email n'a été précédemment renseignée sur la facture ou la fiche contact : utilisez le paramètre ``email_to``, qui peut contenir jusqu'à 5 adresses email.
```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?email_to=emailA@exemple.com,emailB@exemple.com&api_token=API_TOKEN
```

-> A une adresse email différente de celle indiquée sur la facture ou fiche contact : rajoutez le paramètre ``update_buyer_email``. 
```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?email_to=emailautre@exemple.com&update_buyer_email=yes&api_token=API_TOKEN
```

-> A une adresse email en copie : utilisez le paramètre ``email_cc`` (5 adresses email max) : 
```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?email_cc=emailencopie@exemple.com&api_token=API_TOKEN
```
-> En joignant le PDF du document envoyé : utilisez le paramètre ``email_pdf``.
```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?email_pdf=true&api_token=API_TOKEN
```

Remarque : Afin d'éviter le risque de spams, le système n'autorise pas l'envoi répété d'un même document avant un délai de 3 jours, à moins d'utiliser le paramètre ``force : true``. Par exemple, écrivez: 
```shell
curl -X POST https://votrecompte.vosfactures.fr/invoices/100/send_by_email.json?api_token=API_TOKEN&force=true
```

<b>Pour une requête XML sans envoyer de code API</b> (méthode d'autentification différente) :  
```shell
curl -X POST -u 'username:password' https://votrecompte.vosfactures.fr/invoices/100/send_by_email.xml
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
		}}'
```

</br><b>Remarques importantes</b></br></br>
<b>Coordonnées vendeur</b></br>
Si votre département (fiche entreprise) a déjà été créé, envoyez le paramètre ```department_id```(et non ```seller_name```).</br>
<b>Documents Tests</b></br>
Si vous faites des essais, pensez à utiliser le paramètre ```test``` (dont la valeur peut être "true" ou "false") afin de créer des documents de facturation qui seront distingués en tant que documents "test" (au niveau du numéro et de la présentation).</br> 
<b>Contact : nouveau ou existant </b></br>
Lors de la création d'un nouveau document, le système effectue une reconnaissance automatique du contact envoyé en se basant sur le nom (```buyer_name``` et pour le client particulier ```buyer_first_name``` et ```buyer_last_name```), l'adresse email (```buyer_email```) et/ou le n° fiscal (```buyer_tax_no```): si aucun contact ne correspond, le système crée un nouveau contact. Si un contact correspond, le système le sélectionne. Ainsi :</br>- il est recommandé d'envoyer l'ID (``client_id``) d'un client existant plutôt que son nom seul, sachant que des particuliers peuvent avoir le même nom.</br>- le système affiche sur la facture les coordonnées du contact existant telles qu'indiquées dans la fiche du contact. Si vous envoyez d'autres coordonnées (ex: adresse), ajouter le paramètre `"buyer_override": true` pour afficher et mettre à jour les nouvelles coordonnées du contact existant. Exemple : 
```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
		"invoice": {
			"kind":"vat", 
			"number": null, 
			"sell_date": "2013-01-16", 
			"issue_date": "2013-01-16", 
			"payment_to": "2013-01-23",
			"seller_name": "Société Chose", 
			"seller_tax_no": "FR5252445767",
			"client_id": 1,
				"buyer_post_code": "06000",
           			"buyer_city": "Nice",
           			"buyer_street": "11 Rue de la Joie",
         			"buyer_country": "FR",
          			"buyer_override": true,
			"positions":[
				{"name":"Produit A1", "tax":23, "total_price_gross":10.23, "quantity":1},
				{"name":"Produit A2", "tax":0, "total_price_gross":50, "quantity":3}
			]
	    }}'
```

<b>Nouveaux produits</b></br>
Vous pouvez créer un document de facturation en renseignant un nouveau produit (avec au minimum les nom, quantité et prix unitaire TTC), comme dans les exemples précédents. Tout nouveau produit sera ajouté par défaut à votre catalogue (à moins que vous ayez opté pour l'option contraire - voir https://aide.vosfactures.fr/271837-D-sactiver-l-ajout-automatique-des-nouveaux-Produits-Services), avec les attributs indiqués (nom, taux de taxe, prix unitaire, code ean ...).</br>
<b>Produits existants</b></br>
Pour facturer un produit existant, vous devez envoyez l'ID du produit (```product_id```) avec la quantité facturée. 
Si vous souhaitez modifier le nom du produit existant sur le document créé, vous pouvez le faire directement en ajoutant le paramètre ```update_product_name``` : 

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
		"invoice": {
			"kind":"vat", 
			"number": null, 
			"sell_date": "2013-01-16", 
			"issue_date": "2013-01-16", 
			"payment_to": "2013-01-23",
			"department_id": 1, 
			"client_id": 1,
		        "update_product_name" : true,
			"positions":[
				{"product_id": 1, name: "Autre Nom de Produit", "quantity":2}
			]
	    }}'
```

<b>Informations spécifiques et Texte additionnel automatiques</b></br>
Lors d'une création manuelle, les 'Informations spécifiques' et/ou le 'Texte additionnel (imprimé sur la page suivante)' éventuellement définis par défaut dans les Paramètres du compte ou du département sont automatiquement ajoutés. En revanche, par API cet ajout automatique a besoin d'être spécifié en envoyant : 
- soit le paramètre `department_id` du département vendeur : les 'Informations spécifiques' de la fiche du département seront envoyées. 
```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
	“fill_default_descriptions”:true,
		"invoice": {
			"kind":"vat", 
			"number": null, 
			"sell_date": "2013-01-16", 
			"issue_date": "2013-01-16", 
			"payment_to": "2013-01-23",
			"department_id": 1, 
			"client_id": 1,
			"positions":[
				{"name":"Produit A1", "tax":23, "total_price_gross":10.23, "quantity":1},
			]
	    }}'
```
- soit le paramètre `fill_default_descriptions` : les 'Informations spécifiques' et/ou 'Texte additionnel' du paramètres du compte seront envoyés. 
```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
	“fill_default_descriptions”:true,
		"invoice": {
			"kind":"vat", 
			"number": null, 
			"sell_date": "2013-01-16", 
			"issue_date": "2013-01-16", 
			"payment_to": "2013-01-23",
			"seller_name": "Société Chose", 
			"seller_tax_no": "FR5252445767",
			"client_id": 1,
			"positions":[
				{"name":"Produit A1", "tax":23, "total_price_gross":10.23, "quantity":1},
			]
	    }}'
```


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

<a name="create3a"/>

<b>Créer une nouvelle facture avec réduction</b>

Il faut indiquer : </br>
- dans la partie document ("invoice") : l'affichage (`show_discount`) et le type (`discount_kind`) de réduction</br> 
- et dans la partie produit ("positions") : la valeur (`discount` ou `discount_percent`) de la réduction</br> 
Notez que les prix des produits sont à envoyer avant réduction (`total_price_gross`).</br> 
-> Exemple avec une réduction en tant que montant ttc : 

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
				"tax":20,
				"total_price_gross":10,20,
				 "discount":"5.20"
				 },
				{"name":"Produit B",
				"quantity":2,
				"tax":0,
				"total_price_gross":50,
				}   
			     ]   
		}}'
```

-> Exemple avec une réduction en tant que pourcentage sur le prix unitaire TTC : 

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
			 "discount_kind":"percent_unit_gross",
			 "show_discount":true,
			 "positions":[
			 	{"name":"Produit A",
				"quantity":1,
				"tax":20,
				"total_price_gross":10,20,
				 "discount_percent":"20"
				 },
				{"name":"Produit B",
				"quantity":2,
				"tax":0,
				"total_price_gross":50,
				}   
			     ]   
		}}'
```

<a name="create3b"/>

<b>Créer une nouvelle facture avec sous-total</b>

Dans l'exemple ci-dessous, la facture est créée avec un sous-total des produits A et B.  

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
                -H 'Accept: application/json' \
                -H 'Content-Type: application/json' \
                -d '{
                "api_token": "API_TOKEN",
                "invoice": {
                    "kind":"vat",
                    "number": null,
                    "sell_date": "2020-10-26",
                    "issue_date": "2020-10-26",
                    "payment_to": "2020-11-02",
                    "buyer_name": "Client Untel",
                    "buyer_tax_no": "FR5252445767",
                    "positions":[
                        {"name":"Product A", "tax":23, "total_price_gross":30.94, "quantity":3},
                        {"name":"Product B", "tax":23, "total_price_gross":17.23, "quantity":1},
                        {"name":"Subtotal", "tax":"disabled", "total_price_gross":0, "quantity":0, "kind":"subtotal"},
                        {"name":"Product C", "tax":0, "total_price_gross":50, "quantity":2}
                    ]
                }}'
```

<a name="create3c"/>
<b>Créer une nouvelle facture avec une ligne de texte </b>


```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
                -H 'Accept: application/json' \
                -H 'Content-Type: application/json' \
                -d '{
                "api_token": "API_TOKEN",
                "invoice": {
                    "kind":"vat",
                    "number": null,
                    "sell_date": "2020-10-26",
                    "issue_date": "2020-10-26",
                    "payment_to": "2020-11-02",
                    "buyer_name": "Client Untel",
                    "buyer_tax_no": "FR5252445767",
                    "positions":[
                        {"name":"Chambre", "kind":"text_separator"},
			{"name":"Product A", "tax":23, "total_price_gross":30.94, "quantity":3},
                        {"name":"Product B", "tax":0, "total_price_gross":50, "quantity":2}
                    ]
                }}'
```

<a name="create3d"/>

<b>Créer une facture en autoliquidation</b></br>
Le document sera créé par défaut avec les informations spécifiques correspondant à l'autoliquidation ("Mécanisme d'autoliquidation : la TVA est due par le preneur assujetti"). Si vous souhaitez afficher des informations spécifiques différentes, spécifiez-les via le paramètre ```description``` correspondant.

```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
				-H 'Accept: application/json' \
				-H 'Content-Type: application/json' \
				-d '{
				"api_token": "API_TOKEN",
				"invoice": {
					"kind":"vat",
					"number": null,
					"sell_date": "2021-08-05",
					"issue_date": "2021-08-05",
					"payment_to": "2021-08-12",
					"buyer_name": "ClientABC",
					"buyer_tax_no": "BE1234567",
					"reverse_charge": true,
					"positions":[
						{"name":"Produit A1", "total_price_gross":10.50, "quantity":1},
						{"name":"Produit A2", "total_price_gross":50, "quantity":2}
					]
				}}'
```

<a name="create3e"/>

<b>Créer une facture OSS</b></br>
Vous pouvez gérer facilement la facturation de vos ventes intracommunautaires B2C soumises à la TVA de destination ou "TVA OSS" grâce à la fonction OSS du logiciel. En savoir plus ici : https://aide.vosfactures.fr/96973539-E-Commerce-TVA-OSS</br>
     <b>   1) Facturation OSS simple :</b></br>
Si vous avez coché "Option OSS" dans vos paramètres du compte, vous pouvez créer une facture identifiée comme vente OSS en envoyant la paramètre `use_oss`, et en respectant les conditions attendues (client européen non assujetti et taux de tva de destination). 

```shell
curl -X POST --location "https://votrecompte.vosfactures.fr/invoices.json" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{
          "api_token": "API_TOKEN",
          "invoice": {
            "kind": "vat",
            "seller_name": "Société A",
            "seller_country": "FR",
            "buyer_name": "Client Y",
            "buyer_country": "PL",
            "use_oss": true,
            "positions": [
              {
                "name": "Produit AB",
                "tax": 23,
                "total_price_gross": 1.23,
                "quantity": 1
              }
            ]
          }
        }"
```
 <b>   2) Facturation OSS automatique</b></br>
Si vous avez coché "Option OSS" et l'option "Automatiser la reconnaissance des ventes éligibles au OSS" dans vos paramètres du compte, vous pouvez créer une facture en envoyant la paramètre `identify_oss` : le logiciel identifiera automatiquement la facture à créer comme une vente OSS si les conditions sont respectées : client européen non assujetti et taux de tva de destination. Cela est utile si votre solution est capable d'envoyer le taux de TVA de destination. 

```shell
curl -X POST --location "https://votrecompte.vosfactures.fr/invoices.json" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{
          "api_token": "API_TOKEN",
          "identify_oss": true,
          "invoice": {
            "kind": "vat",
            "seller_name": "Société A",
            "seller_country": "FR",
            "buyer_name": "Client Y",
            "buyer_country": "PL",
            "positions": [
              {
                "name": "Produit AB",
                "tax": 23,
                "total_price_gross": 1.23,
                "quantity": 1
              }
            ]
          }
        }"
```
<b>   3) Facturation OSS automatique et forcée</b></br>
Si vous avez coché "Option OSS" et l'option "Automatiser la reconnaissance des ventes éligibles au OSS" dans vos paramètres du compte, vous pouvez créer une facture en envoyant les paramètres `identify_oss` et `oss_force_tax`: le logiciel identifiera automatiquement la facture à créer comme une vente OSS uniqument si les conditions suivantes sont respectées : client européen non assujetti, et ne tiendra pas en compte des taux de tva envoyées dans la requête : à la place les taux de tva de destiniation seront appliqués à la facture. Cela est utile si vous ne pouvez pas envoyer le bon taux de TVA (Tva de destination) car votre solution n'est pas capable de distinguer les ventes OSS des autres ventes. 

```shell
curl -X POST --location "https://votrecompte.vosfactures.fr/invoices.json" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{
          "api_token": "API_TOKEN",
          "identify_oss": true,
          "oss_force_tax": true,
          "invoice": {
            "kind": "vat",
            "seller_name": "Test",
            "seller_country": "FR",
            "buyer_name": "Client",
            "buyer_country": "PL",
            "positions": [
              {
                "name": "Product",
                "tax": 20,
                "total_price_gross": 1.23,
                "quantity": 1
              }
            ]
          }
        }"
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

<b>Remarque</b>: vous pouvez spécifier lors de la requête "copy_invoice_from" les paramètres `payment_to_kind =` ou `payment_to =`, si vous souhaitez créer un document simlilaire avec une date limite de règlement différente de celle du document copié. 

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
		"kind":"correction",
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

<a name="completed"></a>
<b>Créer une facture à compléter</b></br>
Le logiciel vous permet par API de créer et envoyer une facture de vente à votre client afin qu'il complète/vérifie ses coordonnées de facturation, avant de valider celle-ci et pouvoir la télécharger et/ou la recevoir par email. En effet, une fois la facture incomplète créée par API, vous pouvez envoyer le lien de l’aperçu de la facture au client, qui verra un message l’invitant à compléter ses coordonnées, avec un bouton pour valider (situé sous les champs de coordonnées de l’acheteur). Une fois validée, la facture ne peut plus être modifiée par l’acheteur.</br>
La création de la facture est classique, avec les champs usuels - sauf que : </br>
- Les coordonnées de l'acheteur dans la requête sont facultatives,</br> 
- l’état de la facture à créer est `incomplete`, </br>
- des paramètres spécifiques peuvent être inclus dans la requête : </br>
	- ` prevent_send_email_to_complete ` : par défaut lorsque la facture à compléter est créée, l'acheteur reçoit le lien de la facture par email, l’invitant à la compléter. Pour ne pas envoyer cet email à l'acheteur, ajouter ce paramètre avec la valeur ` true ` </br>
	- ` paid_after_completion ` : par défaut la facture est créée avec l’état “A compléter”. Avec ce paramètre ayant la valeur ` true `, l’état de la facture est changée automatiquement en “payé” une fois la facture validée par le client.</br>
	- ` send_after_completion ` : par défaut après avoir cliqué sur le bouton “Sauvegarder” pour valider la facture, le client peut télécharger la facture en PDF. En envoyant ce paramètre ayant la valeur ` true `, le bouton change d’intitulé en “Valider et recevoir par email” et la facture est envoyée au client par email. </br> 

```shell
curl -X POST --location "https://votrecompte.vosfactures.fr/invoices.json" \
    -H "Content-Type: application/json" \
    -d "{
          \"api_token\": \"API_TOKEN",
          \"invoice\": {
            \"status\": \"incomplete\",
            \"lang\": \"fr\",
            \"buyer_company\": false,
            \"buyer_first_name\": \"Jean\",
            \"buyer_last_name\": \"Dupont\",
            \"buyer_email\": \"email1@vemail.fr\",
            \"buyer_mobile_phone\": \"003300000000\",
            \"buyer_street\": \"50 rue des Fleurs\",
            \"buyer_post_code\": \"06000\",
            \"buyer_city\": \"Nice\",
            \"paid_after_completion\": true,
            \"send_after_completion\": true,
            \"send_completion_to\": \"email2@email.fr\",
            \"prevent_send_email_to_complete\": true,
            \"positions\": [
              {
                \"name\": \"Produit 1\",
                \"quantity\": 1,
                \"total_price_gross\": 24.00,
                \"tax\": 20
              },
              {
                \"name\": \”produit 2\",
                \"quantity\": 1,
                \"total_price_gross\": 12.00,
                \"tax\": 20
              }
            ]
          }
        }"
```

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
curl "https://votrecompte.vosfactures.fr/invoices/INVOICE_ID/change_status.json?api_token=API_TOKEN&status=STATUS" -X POST
```

<b>Remarque : Documents "Exportés"</b> </br>
En terme de suivi comptable, vous avez la possibilité d'afficher la colonne "Exporté" sur la liste des documents, vous permettant ainsi de visualiser rapidement les documents ayant fait l'objet d'un export - cet état "exporté" étant mis à jour automatiquement par le système après un export. Vous pouvez forcer cet état en envoyant le paramètre :</br> "accounting_status" : "exported"
</br>P.S: Depuis l'aperçu du document, dans l'encadré "suivi du document" il y a aura la trace d'une activité "Modification" avec la date et l'heure.  

<a name="file"/>
<b>Ajouter une pièce jointe à une facture</b>

1. Téléchargement des données nécessaires à l'envoi de la pièce jointe :
    ```shell
    curl https://votrecompte.vosfactures.fr/invoices/INVOICE_ID/get_new_attachment_credentials.json?api_token=API_TOKEN
    ```

2. Envoi de la pièce jointe :
    ```shell
    curl -F 'AWSAccessKeyId=received_AWSAccessKeyId' \
         -F 'key=received_key' \
         -F 'policy=received_policy' \
         -F 'signature=received_signature' \
         -F 'acl=received_acl' \
         -F 'success_action_status=received_success_action_status' \
         -F 'file=@/file_path/name.ext' \
         received_url
    ```

3. Ajout de la pièce jointe à la facture :
    ```shell
    curl -X POST https://votrecompte.vosfactures.fr/invoices/INVOICE_ID/add_attachment.json?api_token=API_TOKEN&file_name=name.ext
    ```

4. Rendre visible la pièce jointe </br>
Par défaut les pièces jointes aux documents de facturation ne sont pas visibles par les clients (destinataires du document). Pour les rendre visibles, envoyer le paramètre ```show_attachments```. 
 ```shell
curl https://votrecompte.vosfactures.fr/invoices/INVOICE_ID.json \
    -X PUT \
    -H 'Accept: application/json'  \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN",
        "invoice": {
            "show_attachments": true
        }
    }'


<a name="filezip"/>
<b>Télécharger les pièces jointes d'une facture dans un fichier ZIP</b>

```shell
curl -o attachments.zip https://votrecompte.vosfactures.fr/invoices/INVOICE_ID/attachments_zip.json?api_token=API_TOKEN
```

<a name="deleteinvoice"/>
<b>Supprimer une facture</b>

```shell
curl -X DELETE "https://votrecompte.vosfactures.fr/invoices/INVOICE_ID.json?api_token=API_TOKEN"
```

<a name="cancelinvoice"/>
<b>Annuler une facture</b>

```shell
curl https://votrecompte.vosfactures.fr/invoices/cancel.json \
        -X POST \
	-H 'Accept:application/json' \
	-H 'Content-Type:application/json' \
	-d '{
	         "api_token": "API_TOKEN",
               "cancel_invoice_id": "INVOICE ID",
		   "cancel_reason": "Raison de l'annulation (optionnelle)"
	 }'
 ```

Remarque : Pour visualiser la raison de l'annulation indiquée sur un document annulé, incluez le paramètre `additional_fields[invoice]=cancel_reason`à votre url de requête. Exemple : https://moncompte.vosfactures.fr/invoices/ID.json?api_token=API_TOKEN&additional_fields[invoice]=cancel_reason
 
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

vers l'aperçu : `https://votrecompte.vosfactures.fr/invoice/{{token}}`

vers le pdf : `https://votrecompte.vosfactures.fr/invoice/{{token}}.pdf` ou pour plus directement `https://votrecompte.vosfactures.fr/invoice/{{token}}.pdf?inline=yes`

Par exemple, pour un token égal à `HBO3Npx2OzSW79RQL7XV2`, le PDF sera accessible à l'url suivant: `https://votrecompte.vosfactures.fr/invoice/HBO3Npx2OzSW79RQL7XV2.pdf`


<a name="department"/>

## Département vendeur

<a name="departadd"/>
<b>Créer un département</b>

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

Vous pouvez modifier un département par son ID :

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

<a name="departID"/>
<b>Obtenir un département selon ID</b>

```shell
curl "https://votrecompte.vosfactures.fr/departments/100.json?api_token=API_TOKEN"
```

<a name="departdelete"/>
<b>Supprimer un département selon ID</b>

```shell
curl -X DELETE "https://votrecompte.vosfactures.fr/departments/100.json?api_token=API_TOKEN"
```

<a name="departlogo"/>
<b>Ajouter un logo à un département</b>

```shell
curl -X PUT  https://votrecompte.vosfactures.fr/departments/100.json \
    -F 'api_token=API_TOKEN' \
    -F 'department[logo]=@/file_path/logo.png'
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
"person" : "Nom vendeur" - Nom du vendeur (en savoir plus ici:https://aide.vosfactures.fr/468616-Nom-du-vendeur)
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

Remarque : si les contacts ont des tags, ceux-ci seront visibles dans la réponse API par défaut. Si vous ne souhaitez obtenir les tags, envoyez le paramètre `with_tags=false` : 

```shell
curl "https://votrecompte.vosfactures.fr.com/clients.json?with_tags=false&api_token=API_TOKEN&page=1"
```

<a name="client2"/>
<b>Télécharger les derniers contacts modifiés</b>

```shell
curl "https://votrecompte.vosfactures.fr.com/clients.json?order=updated_at&api_token=API_TOKEN&page=1"
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
La variable `panel_url` est retournée lors de l'appel API d'un contact. Cette variable correspond au lien url de l'Espace Facturation du contact.
<br><br>

<a name="addclient"/>
<b>Créer un contact</b>
</br>Seul le paramètre `name` est obligatoire.</br>

```shell
curl https://votrecompte.vosfactures.fr/clients.json \ 
	-H 'Accept: application/json' \  
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
		"client": {
			"name" : "Client1",
			"tax_no" : "FR5252445333",
			"bank" : "banque1",
			"bank_account" : "IBAN1",
			"city" : "Nice",
			"street" : "13 Rue des Fleurs",
			"country" : "",
			"email" : "client@email.fr",
			"post_code" : "06000",
			"phone" : "0400000000",
			"mobile_phone" : "0600000000"			
			
	    }}'
```
<b>Nature : Professionnel ou particulier</b></br> 

La nature du contact créé est par défaut un professionel. Pour créer un contact particulier, vous devez envoyer également le paramètre ```company``` avec la valeur "false" et le paramètre ```last_name``` (nom de famille du contact).

```shell
curl https://votrecompte.vosfactures.fr/clients.json \ 
	-H 'Accept: application/json' \  
	-H 'Content-Type: application/json' \
	-d '{"api_token": "API_TOKEN",
		"client": {
			"name" : "Client1",
			"last_name": "Nom de famille",
        		"company": false
			"bank" : "banque1",
			"bank_account" : "IBAN1",
			"city" : "Nice",
			"street" : "13 Rue des Fleurs",
			"country" : "",
			"email" : "client@email.fr",
			"post_code" : "06000",
			"phone" : "0400000000",
			"mobile_phone" : "0600000000"
			
	    }}'
```

<a name="updateclient"/>
<b>Modifier un contact</b>

Vous pouvez modifier un contact par son ID :

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
<a name="deleteclient"/>
<b>Supprimer un contact</b>

```shell
curl -X DELETE "https://votrecompte.vosfactures.fr/clients/CLIENT_ID.json?api_token=API_TOKEN"
```

<a name="noteclient"/>
<b>Remarque: Champs fiche contact</b>

```shell
"name": "" - nom (obligatoire)
"company": - nature du contact : professionnel (valeur true par défaut) ou un particulier (valeur false)
"shortcut": "" - nom d'usage
"title":"" - Civilité
"last_name": "" - nom de famille 
"first_name": ""  - prénom 
"post_code": "" - code postal
"city": "" - Ville
"street": "" - N° et nom de rue
"country": "FR" - pays (code ISO 3166)
"use_delivery_address":"" - Pour indiquer une adresse additionnelle ("1")
"delivery_address":"" - adresse additionnelle
"tax_no_kind": "" - type du n° d'identification fiscale
"tax_no": "" - n° d'identfication fiscale
"external_id":"" - Réf/code client
"note":"" -  description additionnelle
"fax" : "" - N° de fax
"www": "" - site internet
"bank": "" - Nom de la banque
"bank_account": "" - IBAN
"tag_list": ["tag1", "tag2"] - tags associés au contact
"category_id":"" - ID de la catégorie du contact
"price_list_id":"" - ID du Tarif éventuel applicable au contact
"kind":"" - Type de contact : acheteur ("buyer"), vendeur ("seller") ou les deux ("both")
"payment_to_kind":"" -  Date limite de règlement par défaut
"discount":"10.0" - Pourcentrage de réduction par défaut
"default_tax":"0" - Pourcentrage de taxe par défaut
"default_payment_type": "" -  Mode de règlement par défaut
"disable_auto_reminders": - Envoyer (par défaut `false`) ou ne pas envoyer (`true`) de relances automatiques 
"default_payment_type": "" -  Mode de règlement par défaut
"department_id":"" - Nom du département lié dans le cadre de l'option "Visibilité des Contacts restreinte"
"panel_url":"" - lien url de l'espace client
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
<b>Créer un produit</b>


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

<a name="productaddlot"/>
<b>Créer un produit lot</b></br>
Pour créer un produit en tant que lot, vous devez spécifier dans le paramètre `package_products_details` l'ID et la quantité respective de chaque produit le composant, en numérotant à partir de 0 (0, 1, 2, 3 ...).  

```shell
curl https://votrecompte.vosfactures.fr/products.json \ 
    -H 'Accept: application/json'  \
    -H 'Content-Type: application/json'  \
    -d '{"api_token": "API_TOKEN",
        "product": {
            "name": "Lot ABC",
            "price_net": "100",
            "tax": "20",
            "service": "true",
            "package": "true",
            "package_products_details": {
                "0": {
                    "quantity": 1,
                    "id": id_produitA
                },
                "1": {
                    "quantity": 1,
                    "id": id_produitB
                },
                "2": {
                    "quantity": 1,
                    "id": id_produitC
                }
            },
        }}'
```

<a name="productupdate"/>
<b>Modifier un produit</b>

Vous pouvez modifier un produit par son ID : 

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

Vous pouvez aussi modifier un produit par sa référence ("code") :

```shell
curl https://votrecompte.vosfactures.fr/products/REFABC.json
        -X PUT \
	-H 'Accept: application/json' \ 
	-H 'Content-Type: application/json' \  
	-d '{"api_token": "API_TOKEN",
	      "find_by": "code",
              "product": {
            		"name": "Product A",
 			"tax": "20",
   			"price_gross": "102",
   			"description": "Test 123"
  }}'
```


<b>Mise à jour du Prix HT</b>: Le prix HT d'un produit est calculé par le système sur la base du prix TTC et du taux de taxe - il ne peut donc pas être directement mis à jour par API.


<a name="noteproduct"/>
<b>Remarques</b></br>
<b>Champs fiche produit</b>

```shell
"name":"" - nom du produit 
"description":"" - description du produit
"code":""- référence du produit
"quantity_unit":"" - unité
"price_gross": "" - prix unitaire ttc de vente
"price_net": "" - prix unitaire ht de vente
"tax":"20": "" - taux de taxe (vente)
"price_tax":"" - montant de taxe (vente)
"purchase_price_gross": "" - prix unitaire ttc d'achat
"purchase_price_net": "" - prix unitaire ht d'achat
"purchase_tax":"" - taux de taxe (achat)
"purchase_price_tax":"" - montant de taxe (achat)
"currency": "EUR" - devise
"stock_level": "" - quantité disponible
"disabled": - produit actif (false) ou inactif (true)
"kind":"" - Type du produit : à la vente ("sell"), à l'achat ("buy"), ou les deux ("both")
"category_id":"" - ID de la catégorie du produit
"department_id":"" - Nom du département lié dans le cadre de l'option "Visibilité des Produits restreinte"
"tag_list": ["tag1", "tag2"] - tags associés au produit    
"service": "" - si le produit est un service ("1") ou non ("0")
"limited": "" - si l'option Restriction de quantité est cochée ("1") ou non ("0")
"warehouse_quantity":"-1.0" - quantité en stock (avec fonction Gestion de Stock)
"quantity": "" - Quantité vendue par défaut
"package":false - si le produit est un lot (true) ou non (false)
"package_product_ids":"" - ID des produits composant le lot
"ean_code":"" - Code-barres (code EAN13) du produit
"weight":"" - poids
"weight_unit":"" - unité du poids "kg" ou "g"
"size_height":"" - hauteur
"size_width":"" - largeur
"size":null"" - longueur
size_unit":"" - unité longueur ("m" ou "cm")
"supplier_code":"" - Référence fournisseur
"use_moss":"" - si le produit est soumis à la TVA OSS ("1") ou non ("0")
"additional_info":"" - Code nature du produit (dans le cadre de l'option API Tiers de Prestation de l'URSSAF)
"accounting_id" : "" - Compte comptable (produits) (de la fonction Plan Comptable: https://aide.vosfactures.fr/3069258-Exports-comptables-journaux-comptes-comptables )
"accounting_id2" : "" - Compte comptable (charges) 
"accounting_tax_code" : "" -  Compte comptable TVA (vente)
"accounting_tax_code_exp" : "" - Compte comptable TVA (achat)
"is_delivery":true - si le produit représente des frais de livraison
"accounting_activity_code" : "" - Code Activité
"accounting_sheet_code" : "" - Code Journal
```

<b>Filtres</b>
```shell
"disabled" pour rechercher les produits inactifs, ex: 
curl "https://votrecompte.vosfactures.fr/products.json?filter=disabled&api_token=API_TOKEN&page=1"
```

## Multi-Tarifs

<a name="tarifs1">
<b>Télécharger la liste des Tarifs</b>

```shell
curl "https://votrecompte.vosfactures.fr/price_lists.json?api_token=API_TOKEN"
```	
Vous pouvez utiliser les paramètres `price_list_ids =` (ID des tarifs) et `page=` (numéro de la page) pour filtrer la liste des tarifs.</br>
Vous obtiendrez la réponse suivante : 
```shell
[
  {
    "id": 1,
    "name": "Nom Tarif 1",
    "description": "description Tarif 1",
    "currency": "EUR",
    "deleted": false,
    "account_id": 2,
    "created_at": "2021-07-28T09:28:04.000+02:00",
    "updated_at": "2021-07-28T09:29:04.000+02:00"
  },
  ...
]
```
<b>Remarque:</b></br>
Pour obtenir le prix d'un ou plusieurs produits dans un Tarif donné : 
```shell
curl "https://votrecompte.vosfactures.fr/price_lists/100/prices_for_products.json?api_token=API_TOKEN&product_ids[]=1&product_ids[]=2"
```
où 100 est l'ID du Tarif, et 1 et 2 sont les ID de deux produits. Vous obtiendrez la réponse suivante : 

```shell
{
  "1": {
    "price_net": "23.0",
    "price_gross": "27.6",
    "tax": "",
    "currency": "EUR",
    "category_id": null
  },
  ...
}
```

<a name="tarifs2">
<b>Créer un Tarif</b>

```shell
curl https://votrecompte.vosfactures.fr/price_lists.json
                -H 'Accept: application/json'
                -H 'Content-Type: application/json'
                -d '{
                "api_token": "API_TOKEN",
                "price_list": {
                    "name": "Nom du Tarif",
		    "description": "Description du Tarif",
		    "currency": "EUR",
                    "price_list_positions_attributes": {
		    	"0": {
				"priceable_id": "ID de la position",
				"priceable_name": "Nom du produit",
				"priceable_type": "Product",
				"use_percentage": "0",
				"percentage": "",
				"price_net": "100.0",
				"price_gross": "120.00",
				"use_tax": "1",
				"tax": "20"
			}
		    }
                }}'
```

<a name="tarifs3">
<b>Modifier un Tarif</b>

Vous pouvez modifier un Tarif par son ID :
	
```shell
curl https://votrecompte.vosfactures.fr/price_lists/100.json
		-X PUT
                -H 'Accept: application/json'
                -H 'Content-Type: application/json'
                -d '{
                "api_token": "API_TOKEN",
                "price_list": {
                    "name": "Nouveau nom du Tarif",
		    "description": "Description du Tarif",
		    "currency": "EUR",
	            "price_list_positions_attributes": {
                        "0": {
                            "id": "ID pozycji",
                            "priceable_id": "ID du produit",
                            "price_net": "10.0",
                            "price_gross": "10.80"
                            "use_tax": "1",
                            "tax": "8"
                }}'
```	

<a name="tarifs4">
<b>Supprimer un Tarif</b>

```shell
curl -X DELETE "https://votrecompte.vosfactures.fr/price_lists/100.json?api_token=API_TOKEN"
```

<a name="tarifs5">
<b>Facturer avec un Tarif</b>
	
```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
                -H 'Accept: application/json' \
                -H 'Content-Type: application/json' \
                -d '{
                "api_token": "API_TOKEN",
	        "invoice": {
                    "use_prices_from_price_lists": true,
                    "price_list_id": 123             
	            "kind":"vat",
                    "number": null,
                    "sell_date": "2020-10-26",
                    "issue_date": "2020-10-26",
                    "payment_to": "2020-11-02",
                    "buyer_name": "Client Untel",
                    "buyer_tax_no": "FR5252445767",
                    "positions":[
                       	{"product_id":111, "quantity":3},
                        {"product_id":222, "quantity":1}
                    ]
                }}'
```
Remarque : Vous pouvez identifier le tarif à appliquer aux produits facturés soit via le paramètre `price_list_id=`(ID du Tarif) soit via le paramètre `client_id` (ID du client) : 
	
```shell
curl https://votrecompte.vosfactures.fr/invoices.json \
                -H 'Accept: application/json' \
                -H 'Content-Type: application/json' \
                -d '{
                "api_token": "API_TOKEN",
	        "invoice": {
                    "use_prices_from_price_lists": true,
	            "kind":"vat",
                    "number": null,
                    "sell_date": "2020-10-26",
                    "issue_date": "2020-10-26",
                    "payment_to": "2020-11-02",
                    "client_id": 555
                    "positions":[
                       	{"product_id":111, "quantity":3},
                        {"product_id":222, "quantity":1}
                    ]
                }}'
```
	
<a name="categorie"/>
	 
## Catégories

<a name="categorielist"/>
<b>Télécharger la liste des catégories</b>

```shell
curl " https://votrecompte.vosfactures.fr/categories.json?api_token=API_TOKEN "
```

<a name="categorieID"/>
<b>Obtenir une catégorie selon son ID</b>

```shell
curl " https://votrecompte.vosfactures.fr/categories/100.json?api_token=API_TOKEN "
```

<a name="categorienew"/>
<b>Créer une catégorie </b>

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
<b> Modifier une catégorie </b>
	
Vous pouvez modifier une catégorie par son ID :

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
Vous pouvez utiliser en général les mêmes paramètres que ceux décrits pour les documents de facturation. 

<a name="wd1bis"/>
<b>Télécharger les documents de stock d'une période donnée</b>

```shell 
curl "https://votrecompte.vosfactures.fr/warehouse_documents.json?api_token=API_TOKEN&period=more&date_from=2018-01-01&date_to=2018-04-30&search_date_type=issue_date"
``` 
Pour la recherche pour une période entre deux dates, vous pouvez rechercher les documents de stock par date de création (`issue_date`) ou date de vente (`transaction_date`) en utilisant le paramètre `search_date_type`. 
 
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
<b>Modifier un document de stock</b>

Vous pouvez modifier un document de stock par son ID :

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
<b>Créer un entrepôt</b>

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
<b>Modifier un entrepôt</b>

Vous pouvez modifier un entrepôt par son ID :
	
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

<a name="warehouseaction"/> 

## Opération des stocks
	
<a name="warehouseactionlist"/>	
	
## Télécharger la liste des opérations
	
```shell 
curl "https://votrecompte.vosfactures.fr/warehouse_actions.json?api_token=API_TOKEN"
```
<a name="warehouseactionpara"/>

## Paramètres additionnels de téléchargement
	
Des paramètres supplémentaires peuvent être passés aux appels API. En effet vous pouvez utiliser les mêmes filtres que ceux proposés par le logiciel dans le moteur de recherche, par exemple `page=`, `per_page=` etc.
	
Le paramètre `warehouse_id=` (ID de l'entrepôt) listera uniquement les opérations d'un entrepôt donné. 

Le paramètre `kind=` (type d'opération) listera uniquement les types d'opération donnés.

Le paramètre `product_id=` (ID produit) permet de filtrer les opérations concernant un produit donné. 

`date_from=` et `date_to=` ciblent les opérations créées depuis ou avant une date donnée. 

Le paramètre `from_warehouse_document=` ciblent les opérations de sortie depuis un entrepôt donné. 

Le paramètre `to_warehouse_document=` ciblent les opérations d'entrée dans un entrepôt donné. 

Le paramètre `warehouse_document_id=` (ID du document de stock) ciblent les opérations liées à un document de stock en particulier. 
	
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

Vous pouvez utiliser les mêmes paramètres de filtre que ceux disponibles pour une recherche manuelle depuis l'onglet Paiements.</br>

XML
```shell
curl "https://votrecompte.vosfactures.fr/banking/payments.xml?api_token=API_TOKEN"
```

JSON
```shell
curl "https://votrecompte.vosfactures.fr/banking/payments.json?api_token=API_TOKEN"
```
<a name="paiementsinvoice"/>
<b>Télécharger la liste des Paiements avec les factures liées</b>

XML
```shell
curl "https://votrecompte.vosfactures.fr/banking/payments.xml?include=invoices&api_token=API_TOKEN"
```

JSON
```shell
curl "https://votrecompte.vosfactures.fr/banking/payments.json?include=invoices&api_token=API_TOKEN"
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
<a name="paiementsadd2"/>
<b>Ajouter un nouveau paiement lié à plusieurs factures</b>

```shell
curl https://votrecompte.vosfactures.fr/banking/payments.json \
				-H 'Accept: application/json' \
				-H 'Content-Type: application/json' \
				-d '{
					"api_token": "API_TOKEN",
					"banking_payment": {
						"name":"Titre du paiement",
						"price": 200,
						"invoice_ids": [555, 666],
						"paid":true,
						"kind": "api"
						}}'
```
Attention : l'ordre dans lequel vous spécifiez l'ID des factures dans le paramètre `invoice_ids` est important, car le montant du paiement sera appliqué dans cet ordre. Dans notre exemple, si le montant à payer de la facture ID 555 est de 100 euros, et celui de la facture ID 666 est de 150 euros, le paiement de 200 euros s'applique d'abord à la facture 555 (payée en totalité) et ensuite à la facture 666 (payée en partie).

<a name="updatepayment"/>
<b>Modifier un paiement</b>

Vous pouvez modifier un paiement par son ID :
	
```shell 
curl https://votrecompte.vosfactures.fr/banking/payments/100.json 
				-X PATCH
				-H 'Accept: application/json'  
				-H 'Content-Type: application/json'  
				-d '{
				"api_token": "API_TOKEN",
				"banking_payment": {
					"name":"Nouveau titre du Paiement",
			                "price": 120.00,			
				}}'
``` 

<a name="deletepayment"/>
<b>Supprimer un paiement</b>

```shell 
curl -X DELETE "https://votrecompte.vosfactures.fr/banking/payments/100.json?api_token=API_TOKEN" 
``` 


<a name="accountsystem"/>
<b>Gestion des Comptes(s) à partir d'application tierce</b></br></br>
C'est une option utile si, en tant qu'utilisateur de VosFactures, vous avez une application tierce et souhaitez offrir à vos clients/utilisateurs de votre application une solution de facturation. Il est en effet possible via l'API de créer et configurer des comptes de facturation sur VosFactures à partir d'une application tierce (exemple: site e-commerce, système de réservation, etc...).<br/>Ainsi directement depuis votre portail, votre client/utilisateur peut créer un compte avec un seul bouton et commencer immédiatement à émettre des factures (il n'a pas besoin de créer son compte depuis le site vosfactures.fr).</br></br>

<a name="accountsystem1"/>
<b>Créer un nouveau compte</b></br>
</br>Pour créer un compte depuis votre application intégrée, vous avez besoin d'envoyer :</br> 
   - le code API de votre compte</br>
   - le préfixe du compte à créer</br>
   - l'utilisateur éventuel qui sera propriétaire du compte à créer (si vous souhaitez que le propriétaire du nouveau compte créé soit le même que celui de votre compte, il suffira de ne pas inclure dans votre requête de section "user")</br>
   - le paramètre `integration_token` (code d'intégration) lié à votre compte. Contactez-nous par email à info@vosfactures.fr afin de l'obtenir.</br>
<br/>Les champs suivants ne sont pas obligatoires : `user.login`, `user.from_partner`, `user`, `company` (département du compte à créer). 


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
REMARQUE: le paramètre ```integration_token``` est requis pour télécharger le code API actuel de l'utilisateur.</br></br>

Après avoir créé le nouveau compte :
	
```shell
{
	"prefix":"ABC", - préfixe du compte créé (notez qu'il peut être différent de celui voulu lorsqu'un compte avec le même préfixe existe déjà)
	"api_token":"62YPJfIekoo111111", - code API du compte créé
	"url":"https://ABC.vosfactures.fr", - url du compte créé
	"login":"identifiantABC", - identifiant de l'utilisateur (notez qu'il peut être différent de celui voulu lorsqu'un utilisateur avec le même identifiant existe déjà)
	"email":"email@abc.com"
}
```

Autres champs disponibles lors de la création d'un nouveau compte (utile pour l'intégration) :

```shell
	"account": {
		"prefix": "ABC",
		"lang": "fr",
		"integration_fast_login": true - permet la connexion automatique de vos utilisateurs dans VosFactures
		"integration_logout_url": "https://votresite.com/" - vous permet de renvoyer vos utilisateurs sur votre site après la déconnexion des utilisateurs de VosFactures
	}
```

<a name="accountsystem2"/>
</br><b>Télécharger les informations du compte</b></br>

```shell
curl "https://votrecompte.vosfactures.fr/account.json?api_token=API_TOKEN&integration_token="
```
<a name="accountsystem3"/>

</br><b>Supprimer un compte</b><br/></br>
Après l'envoi de la requête ci-dessous, la procédure de suppression du compte par API est la même qu'une suppression manuelle : un e-mail de confirmation est envoyé. En savoir plus : https://aide.vosfactures.fr/20342070-Supprimer-son-compte-VosFactures. 

```shell
curl https://votrecompte.vosfactures.fr/account/delete.json \
    -X POST \
    -H 'Accept:application/json' \
    -H 'Content-Type: application/json' \
    -d '{
        "api_token": "API_TOKEN"
    }'
```	
Exemple de réponse :
	
```shell
{
    "code": "success",
    "message": "Email de suppression du compte envoyé !"
}
```
	
	
<a name="usersystem"/>

</br><b>Création d'utilisateur</b></br>
	
Une fois que vous avez créé un compte par API et défini son propritéaire (voir ci-dessus), vous pouvez ajouter par API d'autres utilisateurs au compte, et définir leur rôle. Pour ajouter un utilisateur à un compte, vous avez besoin d'envoyer :</br> 
   - le code API du compte (```api_token```)<br/>
   - votre code d'intégration (```integration_token```). Contactez-nous par email à info@vosfactures.fr afin de l'obtenir.</br>
   - le paramètre ```invite``` pour spécifier :<br/> 
	 - si l'utilisateur doit être créé ("false") : vous devez alors choisir un mot de passe en plus d'envoyer l'adresse email
	 - si l'utilisateur existe déjà car lié à un autre compte VosFactures ("true") : seule son adresse email est nécessaire<br/> 
   - le rôle de l'utilisateur (```role```):<br/>
	 - pour un des rôles par défaut, choisissez la valeur : "member" pour un utilisateur simple, "admin" pour un administrateur, ou "accountant" pour un comptable.
	 - pour un rôle personnalisé, envoyez la valeur "role_1234" où 1234 représente l'ID du rôle personnalisé du compte.<br/>	  
   - le ou les ID des départements (```department_ids```) auxquels l'utilisateur non administrateur a accès.<br/>

Pour en savoir plus sur les différents rôles des utilisateurs : https://aide.vosfactures.fr/29416365-R-les-des-Utilisateurs.<br/>	

```shell
POST https://votrecompte.vosfactures.fr/account/add_user.json
Content-Type: application/json
{
  "api_token": "API_TOKEN",
  "integration_token": "INTEGRATION_TOKEN",
  "user": {
    "invite": true,
    "email": "email@test.fr",
    "password": "Password123",
    "role": "member",
    "department_ids": []
  }
}	
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

<a name="webhooks"/>

## Webhooks

Vous pouvez gérer vos webhooks soit depuis l'interface du logiciel (Paramètres > Paramètres du compte > Intégrations), soit directement par API.</br>
Les différents types de webhooks disponibles sont : </br>
`client:create` - création d'un contact</br>
`client:update` - modification d'un contact</br>
`client:destroy` - suppression d'un contact</br>
`invoice:create` - création d'un document de facturation</br>
`invoice:update` - modification d'un document de facturation</br>
`invoice:destroy` - suppression d'un document de facturation</br>
`product:create` - création d'un produit</br>
`product:update` - modification d'un produit</br>
`product:destroy` - suppression d'un produit</br>

</br><b>Télécharger la liste des webhooks existants</b></br>
```shell
curl "https://votrecompte.vosfactures.fr/webhooks.json?api_token=API_TOKEN"
```
</br><b>Télécharger un webhook donné</b></br>
```shell
curl "https://votrecompte.vosfactures.fr/webhooks/1.json?api_token=API_TOKEN"
```

</br><b>Créer un nouveau webhook</b></br>
```shell 
curl -X POST --location "https://votrecompte.vosfactures.fr/webhooks.json" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{
          \"api_token\": \"API_TOKEN\",
          \"webhook\": {
            \"kind\": \"client:create\",
            \"url\": \"https://votrepage.fr/webhook_endpoint\",
            \"api_token\": \"MY_ENDPOINT_API_TOKEN\",
            \"active\": true
          }
        }"
```

</br><b>Modifier un webhook donné</b></br>
```shell 
curl -X PUT --location "https://votrecompte.vosfactures.fr/webhooks/1.json" \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d "{
          \"api_token\": \"API_TOKEN\",
          \"webhook\": {
            \"kind\": \"client:create\",
            \"url\": \"https://votrepage.fr/webhook_endpoint\",
            \"api_token\": \"MY_ENDPOINT_API_TOKEN\",
            \"active\": true
          }
        }"
```

</br><b>Supprimer un webhook donné</b></br>
```shell 
curl -X DELETE "https://votrecompte.vosfactures.fr/webhooks/1.json?api_token=API_TOKEN" 
``` 

<a name="exemples"/>

## Exemples 


CURL: https://github.com/vosfactures/API/blob/master/example.curl

PHP: https://github.com/vosfactures/API/blob/master/example1.php

Ruby: https://github.com/vosfactures/API/blob/master/example1.rb

