@AbapCatalog.sqlViewName: 'ZCFAPPCARRNAME'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Carrier Text'
@ObjectModel.dataCategory: #TEXT

define view ZC_FAPP_CarrierText
  as select from scarr as TextProvider
{
  key TextProvider.carrid    as Carrier,
      @Semantics.language: true -- identifies the language
  key cast( 'E' as sylangu ) as Language,
      @Semantics.text: true -- identifies the first text field for names
      TextProvider.carrname  as CarrierName
}
