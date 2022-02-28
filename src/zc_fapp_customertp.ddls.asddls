@AbapCatalog.sqlViewName: 'ZCFAPPCUSTOMERTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View: Customer'
@VDM.viewType: #CONSUMPTION
@Metadata.allowExtensions: true
define view ZC_FAPP_CustomerTP
  as select from ZI_FAPP_CustomerTP
  association [0..*] to ZC_FAPP_BookingTP as _Bookings on _Bookings.CustomerID = ZI_FAPP_CustomerTP.ID
{
  key ID,
      Name,
      Form,
      Street,
      Postbox,
      Postcode,
      City,
      Country,
      Region,
      Telephone,
      CustomerType,
      Discount,
      Language,
      Email,
      Webuser,
      /* Associations */
      _Bookings
}
