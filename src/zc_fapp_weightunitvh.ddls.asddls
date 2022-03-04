@AbapCatalog.sqlViewName: 'ZCFAPPWUVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Helper: Weight Unit'
define view ZC_FAPP_WEIGHTUNITVH
  as select from t006
{
  key msehi as WeightShortage,
      dimid as Dimension
}
where
  dimid = 'MASS'
