@AbapCatalog.sqlViewName: 'ZIFAPPCONTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transactional Interface-View: Connection'
@VDM.viewType: #TRANSACTIONAL
define view ZI_FAPP_CONNECTIONTP
  as select from ZI_FAPP_CONNECTION as Connection
  association [0..*] to ZI_FAPP_FLIGHTSTP as _Flights on  _Flights.CarrierID    = Connection.CarrierID
                                                      and _Flights.ConnectionID = Connection.ID
{
  key ID,
  key CarrierID,
      CountryFrom,
      CityFrom,
      AirportFrom,
      CountryTo,
      CityTo,
      AirportTo,
      FlightTime,
      DepatureTime,
      ArrivalTime,
      Distance,
      DistanceUnit,
      FlightType,
      Period,
      _Flights
}
