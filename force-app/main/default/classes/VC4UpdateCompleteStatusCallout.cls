public with sharing class VC4UpdateCompleteStatusCallout {
  private static final String PON_IDENTIFIER_SUFFIX = '-RES_PON';
    @Future(callout=true)
  public static void sendCallout(String woliId) {
    String postBody;
    try {
      WorkOrderLineItem woli = [
        SELECT Id, Service_Id__c, MainResource__c, VC4GetAssignmentsResponse__c,
        RelatedResource__c, ONTSerialNumber__c, RGSerialNumber__c, Vc4toPortAux__c,
        Vc4FromPortAux__c, LCPAssignmentVC4InternalId__c, WorkOrderId, VC4LCPToInternalId__c,
        VC4LCPFromInternalId__c,WorkOrder.WorkType.Name
        FROM WorkOrderLineItem
        WHERE Id = :woliId
      ];
      List<VC4_Status_Mapping__mdt> VC4Status= new List<VC4_Status_Mapping__mdt>([Select id,Label,Status__c from VC4_Status_Mapping__mdt where Label=:woli.WorkOrder.WorkType.Name]);
      
     
      
      system.debug('Debug::VC4Status'+VC4Status);
      if(!VC4Status.IsEmpty())
      {
      String jsonBody = '{';
      jsonBody=jsonBody+'"_type":"xPONService",';
      jsonBody=jsonBody+'"status":"'+VC4Status[0].Status__c+'"';
      jsonBody=jsonBody+'}';
      
      //getting Token from Configuration custom Metadata Type
      String token = [
        SELECT Id, Key__c, SubKey__c, Value__c
        FROM Configuration__mdt
        WHERE Key__c = :'VC4' AND SubKey__c = 'Token'
      ].Value__c;
      
      String path = '/lumos/vlocity/ws/xponService/byId';
      //Setting request Data
      HttpRequest req = new HttpRequest();
      req.setEndpoint('callout:VC4' + path + '/' + woli.Service_Id__c + PON_IDENTIFIER_SUFFIX);
      system.debug(req.getEndpoint());
      req.setHeader('Content-Type', 'application/json');
      if (token != 'deprecated') {
        req.setHeader('Authorization', 'Bearer ' + token);
      }
      req.setMethod('PATCH');
      req.setBody(jsonBody);
      Http http = new Http();
      HttpResponse response = http.send(req);
      System.debug(response.getBody());
      if (response.getStatusCode() == 200) {
        System.debug('Status was updated Successfully');
        
      }
     } 
    } catch (Exception e) {
      postBody = 'There was an error when trying to update the Status: ' + e.getMessage();
    }
    
  }

}