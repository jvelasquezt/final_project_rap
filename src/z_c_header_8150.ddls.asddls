@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption header'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity Z_C_HEADER_8150
  provider contract transactional_query
  as projection on Z_R_HEADER_8150
{
      @Search.defaultSearchElement: true
  key IdHeader,
      Email,
      Firstname,
      Lastname,
      Country,
      Creaton,
      DeliveryDate,
      @ObjectModel.text.element: [ 'Text' ]
      @Consumption.valueHelpDefinition: [{ entity: {
                                           name: 'Z_R_STATUS_8150',
                                           element: 'Id' }}]
      OrderStatus,
      _Status.Text,
      
      ImageUrl,
      /* Associations */
      _Items : redirected to composition child ZC_C_ITEM_8150
}
