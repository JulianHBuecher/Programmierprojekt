@AbapCatalog.sqlViewName: 'ZCFAPPFLIGHTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transaction Consumption-View: Flights'
@VDM.viewType: #CONSUMPTION
@OData.publish: true
@Metadata.allowExtensions: true
@Search.searchable: true
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
      LoadFactor,
      Percentage,
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
      _Bookings
}
where FlightDate > $session.system_date
