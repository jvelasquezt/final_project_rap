@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root entity header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_R_HEADER_8150 
  as select from ztheader_8150
  composition [1..*] of Z_R_ITEMS_8150                as _Items
  association [1..1] to Z_R_STATUS_8150 as _Status on $projection.OrderStatus = _Status.Id

{
  key id_header     as IdHeader,
      email         as Email,
      firstname     as Firstname,
      lastname      as Lastname,
      country       as Country,
      creaton       as Creaton,
      delivery_date as DeliveryDate,
      order_status  as OrderStatus,
      image_url     as ImageUrl,

      _Items,
      _Status

}
