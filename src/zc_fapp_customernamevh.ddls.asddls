@AbapCatalog.sqlViewName: 'ZFAPPCNVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Helper: Customer Name'
define view ZC_FAPP_CUSTOMERNAMEVH 
    as select from scustom {
    key id as ID,
    name as Name,
    email as Email
}
