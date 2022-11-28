/*
* Name            :    NPSAPICalloutActionTest
* Description     :    This is the test class for NPSAPICalloutAction.
* Created Date    :    [24th November , 2022]
* Created By      :    [Bonoshree Mondal]
*
* Date Modified        Modified By             Description of the update
   24th-Nov-2022      Bonoshree Mondal          Created
*/
@isTest()
public class NPSAPICalloutActionTest {
/*
* Created Date    :    [24th Nov, 2022]
* Created By      :    [Bonoshree Mondal] 
* Description :  This will test the NPSAPI callout for Fulfilled order in Success senario
*/
    static testmethod void makeCalloutvalidateAndUpsertLegalEntitySuccessTest() {
       
      Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorForNPSAPI());
        Contract c = TestUtility.createContract(true);
        c.status = 'Activated';
        update c;
        List<Order> orderList = TestUtility.createOrder(true, c, 100);
        List<Id> orderIds = new List<Id>();
        for(Order o : orderList){
            o.status = 'Fulfilled';
            orderIds.add(o.Id);
        }
        update orderList;
        Test.startTest();
        NPSAPICalloutAction.callNPSAPI(orderIds);
        Integer callouts = Limits.getCallouts();
        Test.stopTest();  
		System.assertEquals(1, callouts, 'A callout should be made');
    }
/*
* Created Date    :    [24th Nov, 2022]
* Created By      :    [Bonoshree Mondal] 
* Description :  This will test the NPSAPI callout for Fulfilled order and if any exception occurred
*/
    static testmethod void makeCalloutvalidateAndUpsertLegalEntityExceptionTest() {
       
      Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorForNPSAPI());
      Test.startTest();
      NPSAPICalloutAction.callNPSAPI(null);
      Integer callouts = Limits.getCallouts();
      Test.stopTest();
	  System.assertEquals(0, callouts, 'A callout should not be made due to Exception');

    }
/*
* Created Date    :    [24th Nov, 2022]
* Created By      :    [Bonoshree Mondal] 
* Description :  This will test the NPSAPI callout for Fulfilled order and if any callout exception occurred
*/    
    static testmethod void makeCalloutvalidateAndUpsertLegalEntityCalloutExceptionTest() {
      Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorForNPSAPI());
        Contract c = TestUtility.createContract(true);
        c.status = 'Activated';
        update c;
        List<Order> orderList = TestUtility.createOrder(true, c, 100);
        List<Id> orderIds = new List<Id>();
        for(Order o : orderList){
            o.status = 'Fulfilled';
            orderIds.add(o.Id);
        }
        Test.startTest();
        update orderList;
        NPSAPICalloutAction.callNPSAPI(orderIds);
        Integer callouts = Limits.getCallouts();
        Test.stopTest();  
		System.assertEquals(0, callouts, 'A callout should not be made but callout exception will occur');

    }
    
    
}