@AbapCatalog.sqlViewName: 'ZIFAPPFLTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transactional Interface-View: Flights'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'zvfappflights',

    modelCategory: #BUSINESS_OBJECT,
    semanticKey: ['CarrierID','ConnectionID','FlightDate'],
    representativeKey: ['CarrierID','ConnectionID','FlightDate'],

    createEnabled: false,
    updateEnabled: false,
    deleteEnabled: false
}
define view ZI_FAPP_FLIGHTSTP
  as select from ZI_FAPP_FLIGHTS as Flights
  association [1..1] to ZI_FAPP_CONNECTIONTP as _Connection on  _Connection.ID        = Flights.ConnectionID
                                                            and _Connection.CarrierID = Flights.CarrierID
  association [1..*] to ZI_FAPP_BookingTP    as _Bookings   on  _Bookings.CarrierID    = Flights.CarrierID
                                                            and _Bookings.ConnectionID = Flights.ConnectionID
                                                            and _Bookings.FlightDate   = Flights.FlightDate
{
  key CarrierID,
  key ConnectionID,
  key FlightDate,
      Price,
      Currency,
      PlaneType,
      SeatsMax,
      SeatsOccupied,
      @EndUserText.label: 'Load Factor'
      @EndUserText.quickInfo: 'Percentage of all occupied seats'
      @Semantics.quantity.unitOfMeasure: 'Percentage'
      cast(division(SeatsOccupied,SeatsMax,2) * 100 as abap.int4) as LoadFactor,
      @Semantics.unitOfMeasure: true
      cast(' % ' as abap.unit(3))                                 as Percentage,
      _Connection,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Bookings
}
