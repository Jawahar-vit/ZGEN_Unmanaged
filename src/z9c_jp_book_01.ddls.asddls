@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Booking'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z9C_JP_BOOK_01
    as projection on Z9I_JP_BOOK_01
{
        //Z_I_BOOKING_U
        @Search.defaultSearchElement: true
    key TravelID,
        @Search.defaultSearchElement: true
    key BookingID,

        BookingDate,

        @Consumption.valueHelpDefinition: [{

            entity: {
                name: '/DMO/I_Customer',
                element: 'CustomerID'
            }}]
        @Search.defaultSearchElement: true
        @ObjectModel.text.element: ['CustomerName']
        CustomerID,
        _Customer.FirstName as CustomerName,

        @Consumption.valueHelpDefinition: [{

           entity: {
               name: '/DMO/I_Carrier',
               element: 'AirlineID'
           }}]
        @Search.defaultSearchElement: true
        @ObjectModel.text.element: ['AirlineName']

        AirlineID,
        _Carrier.Name       as AirlineName,

        @Consumption.valueHelpDefinition: [{
            entity: {
                name: '/DMO/I_Flight',
                element: 'ConnectionID'
            },
            additionalBinding: [
                {localElement: 'FlightDate', element: 'FlightDate'},
                {localElement: 'AirlineID',element: 'AirlineID' },
                {localElement: 'FlightPrice',element: 'Price'},
                {localElement: 'CurrencyCode',element: 'CurrencyCode'}]
        }]
        ConnectionID,

        @Consumption.valueHelpDefinition: [{
            entity: {
                name: '/DMO/I_Flight',
                element: 'FlightDate'
            },
            additionalBinding: [
                {localElement: 'ConnectionID', element: 'ConnectionID'},
                {localElement: 'AirlineID',element: 'AirlineID' },
                {localElement: 'FlightPrice',element: 'Price'},
                {localElement: 'CurrencyCode',element: 'CurrencyCode'}]
        }]
        FlightDate,

        @Semantics.amount.currencyCode: 'CurrencyCode'
        FlightPrice,

        @Consumption.valueHelpDefinition: [{
           entity: {
               name: 'I_Currency',
               element: 'Currency'
           }}]

        CurrencyCode,
        _Carrier,
        _Connection,
        _Customer,
        _Travel : redirected to parent Z9C_JP_TRAV_01
}
