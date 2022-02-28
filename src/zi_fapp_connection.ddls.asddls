@AbapCatalog.sqlViewName: 'ZIFAPPCONN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View: Connection'
@VDM.viewType: #BASIC
define view ZI_FAPP_CONNECTION
  as select from spfli
{
  key connid    as ID,
  key carrid    as CarrierID,
      countryfr as CountryFrom,
      cityfrom  as CityFrom,
      airpfrom  as AirportFrom,
      countryto as CountryTo,
      cityto    as CityTo,
      airpto    as AirportTo,
      fltime    as FlightTime,
      deptime   as DepatureTime,
      arrtime   as ArrivalTime,
      distance  as Distance,
      distid    as DistanceUnit,
      fltype    as FlightType,
      period    as Period
}
