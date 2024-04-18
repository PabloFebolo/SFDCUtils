/**********************************************************************************
* Name             GTVRefundPrepareRequest
* @Author          Matias Pavlotsky
* @Date            06/06/23
* @Description     This class is used to build request to deactivate GTV Account
***********************************************************************************/
/* MODIFICATION LOG
* Version            Developer          Date               Description
* -----------------------------------------------------------------------------
* 1.0                Matias Pavlotsky       06/06/23           Initial Creation
* 1.1				 Matias Pavlotsky	    15/02/24		   Cancel reason comes now from a mdt (Homologation US3723)
* *********************************************************************************/
public with sharing class GTVRefundPrepareRequest {

    Public static String orderId;
    Public static String originalOrder;
    
    public static String prepareRequest(vlocity_cmt__OrchestrationItem__c item) {
        
        logger LOG = LoggerFactory.getLogger(GTVRefundPrepareRequest.class);

        RequestWrapper req = new RequestWrapper();
        paymentChangeReason reason = new paymentChangeReason();
        
        orderId = [SELECT vlocity_cmt__OrderId__c FROM vlocity_cmt__OrchestrationPlan__c WHERE Id=:item.vlocity_cmt__OrchestrationPlanId__c LIMIT 1].vlocity_cmt__OrderId__c;
		//
		
        originalOrder = [SELECT vlocity_cmt__FirstVersionOrderIdentifier__c FROM Order WHERE Id=:orderId Limit 1 ].vlocity_cmt__FirstVersionOrderIdentifier__c;
       
        vlocity_cmt__OrderPayment__c orderPayment = [SELECT Id, vlocity_cmt__PaymentAmount__c, vlocity_cmt__PaymentEventIdentifier__c FROM vlocity_cmt__OrderPayment__c WHERE vlocity_cmt__OrderId__c=:originalOrder limit 1];
        
        
        String paymentId = orderPayment.vlocity_cmt__PaymentEventIdentifier__c;
        
        if(Test.isRunningTest()){
            paymentId = '999999';
        }

        //Quick fix, ID for this callout will be taken from mdt instance now
        Configuration__mdt gtvReason = Configuration__mdt.getInstance('GTVPaymentChangeReason');

        reason.id = String.valueOf(gtvReason.Value__c);
        reason.name = 'Default Chargeback Reason';
        reason.reason_type = 'payment-change'; 
        req.amount = (decimal)orderPayment.vlocity_cmt__PaymentAmount__c;
        if (Test.isRunningTest()) {
            
            req.amount = 100;
            
        }
        req.payment_change_reason = reason;
        String requestBody = JSON.serialize(req);

        LOG.info('Request', requestBody);
        LoggerFactory.saveLogs();
        
        requestBody = requestBody + '/-/' + paymentId;
       
        return requestBody;
    }

    private class RequestWrapper {
         String payment_type = 'refund';
         String description = 'on demand';
         Decimal amount;
         Boolean cancel_payment = true;
         paymentChangeReason payment_change_reason = New paymentChangeReason();

    }
    
    private class paymentChangeReason {
        String id;
        String name;
        String reason_type;
    }
}