/*
* Name            :    MockHttpResponseGeneratorForNPSAPI
* Description     :    This is a Mock class to create fake response
* Created Date    :    [24th November , 2022]
* Created By      :    [Bonoshree Mondal]
*
* Date Modified        Modified By             Description of the update
   24th-Nov-2022      Bonoshree Mondal          Created
*/
@isTest
global class MockHttpResponseGeneratorForNPSAPI implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('POST', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setBody('SUCCESS');
        res.setStatusCode(200);
        return res;
    }
}