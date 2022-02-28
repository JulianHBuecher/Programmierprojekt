@AbapCatalog.sqlViewName: 'ZIFAPPCUSTOMERTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transactional Interface-View: Customer'
define view ZI_FAPP_CustomerTP
  as select from ZI_FAPP_Customer
  association [0..*] to ZI_FAPP_BookingTP as _Bookings on $projection.ID = _Bookings.CustomerID
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
      _Bookings
}
