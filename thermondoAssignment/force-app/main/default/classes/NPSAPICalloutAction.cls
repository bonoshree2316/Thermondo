/*
* Name            :    NPSAPICalloutAction
* Description     :    This class contains invocable method which will be fired from flow when order status will be fullfilled
* Created Date    :    [24th November , 2022]
* Created By      :    [Bonoshree Mondal]
*
* Date Modified        Modified By             Description of the update
   24th-Nov-2022      Bonoshree Mondal          Created
*/
public class NPSAPICalloutAction {
  @InvocableMethod(label='Call NPS API' description='Sends order data to NPS API when order status is changed to Fulfilled' category= 'Order')
  public static void callNPSAPI(List<Id> ordersIds) {
        List<NPSAPIWrapper> orderWrapper = new List<NPSAPIWrapper>();
        try{
            for(Order o : [select id, Account.PersonEmail, OrderNumber from Order where Id = : ordersIds]){
                orderWrapper.add(new NPSAPIWrapper(o));
            }
        
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:NPSAPI');
            request.setMethod('POST');
            System.debug('orderWrapper'+ orderWrapper);
            request.setBody(JSON.serialize(orderWrapper));
            HttpResponse response = http.send(request);
            System.debug('Status code'+ response.getBody());
        }
      	catch(CalloutException ex){
            System.debug('Callout Exception occurred :'+ ex);
      	}
      	catch(Exception ex){
            System.debug('Exception occurred :'+ ex);
      	}
  }

}