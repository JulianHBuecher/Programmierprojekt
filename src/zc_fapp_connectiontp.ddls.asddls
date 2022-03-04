@AbapCatalog.sqlViewName: 'ZCFAPPCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional Consumption-View: Connection'
@Metadata.allowExtensions: true
define view ZC_FAPP_CONNECTIONTP
  as select from ZI_FAPP_CONNECTIONTP as Connection
  association [0..*] to ZC_FAPP_FLIGHTSTP   as _Flights         on  _Flights.CarrierID    = Connection.CarrierID
                                                                and _Flights.ConnectionID = Connection.ID
  association [0..*] to ZC_FAPP_CarrierText as _CarrierText     on  $projection.CarrierID = _CarrierText.Carrier
  association [0..*] to ZC_FAPP_AIRPORTTEXT as _AirportTextTo   on  $projection.AirportTo = _AirportTextTo.ID
  association [0..*] to ZC_FAPP_AIRPORTTEXT as _AirportTextFrom on  $projection.AirportFrom = _AirportTextFrom.ID
{
  key ID,
      @ObjectModel.text.association: '_CarrierText'
  key CarrierID,
      CountryFrom,
      CityFrom,
      @ObjectModel.text.association: '_AirportTextFrom'
      AirportFrom,
      CountryTo,
      CityTo,
      @ObjectModel.text.association: '_AirportTextTo'
      AirportTo,
      //    FlightTime,
      DepatureTime,
      ArrivalTime,
      Distance,
      DistanceUnit,
      FlightType,
      Period,
      /* Associations */
      _Flights,
      _CarrierText,
      _AirportTextTo,
      _AirportTextFrom
}
