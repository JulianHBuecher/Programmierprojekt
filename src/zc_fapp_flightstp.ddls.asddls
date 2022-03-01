@AbapCatalog.sqlViewName: 'ZCFAPPFLIGHTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transaction Consumption-View: Flights'
@VDM.viewType: #CONSUMPTION
@OData.publish: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel: {
    transactionalProcessingDelegated: true,

    createEnabled: false,
    updateEnabled: false,
    deleteEnabled: false
}
define view ZC_FAPP_FLIGHTSTP
  as select from ZI_FAPP_FLIGHTSTP as Flights
  association [1..1] to ZC_FAPP_CONNECTIONTP as _Connection on  _Connection.CarrierID = Flights.CarrierID
                                                            and _Connection.ID        = Flights.ConnectionID
  association [1..*] to ZC_FAPP_BookingTP    as _Bookings   on  _Bookings.CarrierID    = Flights.CarrierID
                                                            and _Bookings.ConnectionID = Flights.ConnectionID
                                                            and _Bookings.FlightDate   = Flights.FlightDate
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 1
  key CarrierID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 1
  key ConnectionID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 1
  key FlightDate,
      Price,
      Currency,
      PlaneType,
      SeatsMax,
      SeatsOccupied,
      @EndUserText.label: 'Load Factor'
      @EndUserText.quickInfo: 'Percentage of all occupied seats'
      @Semantics.quantity.unitOfMeasure: 'Percentage'
//      @ObjectModel.virtualElement: true
      division(SeatsOccupied,SeatsMax,2) * 100 as LoadFactor,
      @Semantics.unitOfMeasure: true
//      @ObjectModel.virtualElement: true
      cast(' % ' as abap.unit(3))           as Percentage,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      _Connection.AirportFrom,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      _Connection.AirportTo,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      _Connection.CityFrom,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      _Connection.CityTo,
      /* Associations */
      _Connection,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Bookings
}
where FlightDate > $session.system_date
