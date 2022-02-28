@AbapCatalog.sqlViewName: 'ZIFAPPCUSTOMER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View: Customer'
@VDM.viewType: #BASIC
define view ZI_FAPP_Customer
  as select from scustom
{

  key id        as ID,
      name      as Name,
      form      as Form,
      street    as Street,
      postbox   as Postbox,
      postcode  as Postcode,
      city      as City,
      country   as Country,
      region    as Region,
      telephone as Telephone,
      custtype  as CustomerType,
      discount  as Discount,
      langu     as Language,
      email     as Email,
      webuser   as Webuser

}
