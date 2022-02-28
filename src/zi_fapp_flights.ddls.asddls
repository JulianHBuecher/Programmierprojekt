@AbapCatalog.sqlViewName: 'ZIFAPPFLIGHTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View: Flights'
@VDM.viewType: #BASIC
define view ZI_FAPP_FLIGHTS
  as select from sflight
{
  key carrid    as CarrierID,
  key connid    as ConnectionID,
  key fldate    as FlightDate,
      price     as Price,
      currency  as Currency,
      planetype as PlaneType,
      seatsmax  as SeatsMax,
      seatsocc  as SeatsOccupied
}
