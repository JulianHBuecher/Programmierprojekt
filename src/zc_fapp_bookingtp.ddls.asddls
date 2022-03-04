@AbapCatalog.sqlViewName: 'ZCFAPPBOOKINGTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View: Booking'
@VDM.viewType: #CONSUMPTION
@Search.searchable: true
@Metadata.allowExtensions: true
@ObjectModel: {
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: false
}
define view ZC_FAPP_BookingTP
  as select from ZI_FAPP_BookingTP
  association [1..1] to ZC_FAPP_CustomerTP as _Customer on  _Customer.ID = ZI_FAPP_BookingTP.CustomerID
  association [1..1] to ZC_FAPP_FLIGHTSTP  as _Flight   on  $projection.CarrierID    = _Flight.CarrierID
                                                        and $projection.ConnectionID = _Flight.ConnectionID
                                                        and $projection.FlightDate   = _Flight.FlightDate
  association [1..1] to ZC_FAPP_CUSTOMERNAMEVH as _CustomerVH on _CustomerVH.ID = ZI_FAPP_BookingTP.CustomerID
  association [1..1] to ZC_FAPP_CURRENCIEVH as _CurrencyVH on $projection.AmountCurrency = _CurrencyVH.Currkey
  association [1..1] to ZC_FAPP_WEIGHTUNITVH as _WeightUnitVH on $projection.WeightUnit = _WeightUnitVH.WeightShortage
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
  key ID,
      @ObjectModel.readOnly: true
      @ObjectModel.mandatory: false
  key CarrierID,
      @ObjectModel.readOnly: true
      @ObjectModel.mandatory: false
  key ConnectionID,
      @ObjectModel.readOnly: true
      @ObjectModel.mandatory: false
  key FlightDate,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Consumption.valueHelp: '_CustomerVH'
      @ObjectModel.mandatory: true
      CustomerID,
      CustomerType,
      LuggageWeight,
      @Consumption.valueHelp: '_WeightUnitVH'
      WeightUnit,
      Invoice,
      Class,
      Amount,
      @Consumption.valueHelp: '_CurrencyVH'
      AmountCurrency,
      LocalAmount,
      LocalAmountCurrency,
      @ObjectModel.readOnly: true
      OrderDate,
      @ObjectModel.readOnly: true
      Cancelled,
      Passname,
      Passform,
      Passbirth,
      /* Associations */
      _Customer,
      _CustomerVH,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @ObjectModel.readOnly: true
      _Customer.Name,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Flight,
      _CurrencyVH,
      _WeightUnitVH
}
where
  Cancelled <> 'X'
