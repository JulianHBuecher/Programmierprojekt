@AbapCatalog.sqlViewName: 'ZCFAPPAIRPNA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Airport Text'
@ObjectModel.dataCategory: #TEXT
define view ZC_FAPP_AIRPORTTEXT
  as select from sairport as TextProvider
{
  key TextProvider.id                     as ID,
      @Semantics.language: true -- identifies the language
  key cast( 'E' as sylangu ) as Language,
      @Semantics.text: true -- identifies the first text field for names
      TextProvider.name                   as AirportName

}
