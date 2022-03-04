@AbapCatalog.sqlViewName: 'ZFAPPCURRVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Helper: Currency'
define view ZC_FAPP_CURRENCIEVH as select from scurx {
    key currkey as Currkey
}
