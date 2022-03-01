@AbapCatalog.sqlViewName: 'ZCFAPPBOOKINGTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View: Booking'
@VDM.viewType: #CONSUMPTION
@Search.searchable: true
@Metadata.allowExtensions: true
@ObjectModel: {
    createEnabled: false,
    updateEnabled: false,
    deleteEnabled: false
}
define view ZC_FAPP_BookingTP
  as select from ZI_FAPP_BookingTP
  association [1..1] to ZC_FAPP_CustomerTP as _Customer on  _Customer.ID = ZI_FAPP_BookingTP.CustomerID
  association [1..1] to ZC_FAPP_FLIGHTSTP  as _Flight   on  $projection.CarrierID    = _Flight.CarrierID
                                                        and $projection.ConnectionID = _Flight.ConnectionID
                                                        and $projection.FlightDate   = _Flight.FlightDate
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
  key ID,
  key CarrierID,
  key ConnectionID,
  key FlightDate,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
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
      /* Associations */
      _Customer,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      _Customer.Name,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Flight
}
where Cancelled <> 'X'
