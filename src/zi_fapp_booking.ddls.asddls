@AbapCatalog.sqlViewName: 'ZIFAPPBOOKING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View: Booking'
@VDM.viewType: #BASIC
define view ZI_FAPP_Booking
  as select from sbook
{

  key bookid     as ID,
  key carrid     as CarrierID,
  key connid     as ConnectionID,
  key fldate     as FlightDate,
      customid   as CustomerID,
      custtype   as CustomerType,
      luggweight as LuggageWeight,
      wunit      as WeightUnit,
      invoice    as Invoice,
      class      as Class,
      forcuram   as Amount,
      forcurkey  as AmmountCurrency,
      loccuram   as LocalAmount,
      loccurkey  as LocalAmountCurrency,
      order_date as OrderDate,
      cancelled  as Cancelled,
      passname   as Passname,
      passform   as Passform,
      passbirth  as Passbirth

}
