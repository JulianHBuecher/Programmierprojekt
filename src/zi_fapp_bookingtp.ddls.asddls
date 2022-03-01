@AbapCatalog.sqlViewName: 'ZIFAPPBOOKINGTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transactional Interface-View: Booking'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    writeActivePersistence: 'ZVFAPPBOOKING',
    semanticKey: ['ID', 'CarrierID', 'ConnectionID', 'FlightDate'],
    representativeKey: ['ID'],

    createEnabled: false,
    updateEnabled: true,
    deleteEnabled: false
}
define view ZI_FAPP_BookingTP
  as select from ZI_FAPP_Booking
  association [1..1] to ZI_FAPP_CustomerTP as _Customer on $projection.CustomerID = _Customer.ID
  association [1..1] to ZI_FAPP_FLIGHTSTP as _Flight on $projection.CarrierID = _Flight.CarrierID and
                                                        $projection.ConnectionID = _Flight.ConnectionID and
                                                        $projection.FlightDate = _Flight.FlightDate
{
  key ID,
  key CarrierID,
  key ConnectionID,
  key FlightDate,
      CustomerID,
      CustomerType,
      LuggageWeight,
      WeightUnit,
      Invoice,
      Class,
      Amount,
      AmmountCurrency,
      LocalAmount,
      LocalAmountCurrency,
      OrderDate,
      Cancelled,
      Passname,
      Passform,
      Passbirth,
      _Customer,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Flight
}
