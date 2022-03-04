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
  association [1..1] to ZC_FAPP_CONNECTIONTP as _Connection      on  _Connection.CarrierID = Flights.CarrierID
                                                                 and _Connection.ID        = Flights.ConnectionID
  association [1..*] to ZC_FAPP_BookingTP    as _Bookings        on  _Bookings.CarrierID    = Flights.CarrierID
                                                                 and _Bookings.ConnectionID = Flights.ConnectionID
                                                                 and _Bookings.FlightDate   = Flights.FlightDate
  association [0..*] to ZC_FAPP_CarrierText  as _CarrierText     on  $projection.CarrierID = _CarrierText.Carrier
  association [0..*] to ZC_FAPP_AIRPORTTEXT  as _AirportTextTo   on  $projection.airportto = _AirportTextTo.ID
  association [0..*] to ZC_FAPP_AIRPORTTEXT  as _AirportTextFrom on  $projection.airportfrom = _AirportTextFrom.ID
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 1
      @ObjectModel.text.association: '_CarrierText'
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
      case
        when LoadFactor < 80 then 3
        when (LoadFactor > 80 and LoadFactor < 95) then 2
        else 1
      end as Criticality,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @ObjectModel.text.association: '_AirportTextFrom'
      _Connection.AirportFrom,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @ObjectModel.text.association: '_AirportTextTo'
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
      _Bookings,
      _CarrierText,
      _AirportTextTo,
      _AirportTextFrom
}
where
  FlightDate > $session.system_date
