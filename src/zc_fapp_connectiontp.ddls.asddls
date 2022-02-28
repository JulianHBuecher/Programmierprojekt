@AbapCatalog.sqlViewName: 'ZCFAPPCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional Consumption-View: Connection'
@Metadata.allowExtensions: true
define view ZC_FAPP_CONNECTIONTP 
as select from ZI_FAPP_CONNECTIONTP as Connection
  association [0..*] to ZC_FAPP_FLIGHTSTP as _Flights on  _Flights.CarrierID    = Connection.CarrierID
                                                      and _Flights.ConnectionID = Connection.ID {
    key ID,
    key CarrierID,
    CountryFrom,
    CityFrom,
    AirportFrom,
    CountryTo,
    CityTo,
    AirportTo,
//    FlightTime,
    DepatureTime,
    ArrivalTime,
    Distance,
    DistanceUnit,
    FlightType,
    Period,
    /* Associations */
    _Flights
}
