/**********************************************************************************
* Name             GTVRefundPrepareRequestTest
* @Author          Matías Pavlotsky
* @Date            05/24/23
* @Description     GTVRefundPrepareRequestTest Test class
***********************************************************************************/
/* MODIFICATION LOG
* Version            Developer          Date               Description
* -----------------------------------------------------------------------------
* 1.0                Matías Pavlotsky       06/10/23           Initial Creation
* *********************************************************************************/
@IsTest
public class GTVRefundPrepareRequestTest {
	
    @TestSetup
    static void setup(){
        Id consumerAccRecordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        Id serviceAccRecordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Service').getRecordTypeId();
        Id pricebookId = Test.getStandardPricebookId();
        String FRLJsonAttribute = '{"4b93336c-6c18-9cba-94dd-40f94422e7c6": [{"$$AttributeDefinitionStart$$": null,"categorycode__c": "4b93336c-6c18-9cba-94dd-40f94422e7c6","attributeid__c": "a1M6t000000xtycEAA","attributeuniquecode__c": "ATT_VC4_ADDRESSID","attributedisplayname__c": "Address ID","id": "","objectid__c": "","objecttype__c": null,"categoryname__c": "Category","valuedatatype__c": "Text","displaysequence__c": null,"attributecategoryid__c": "","attributedisplaysequence__c": null,"hasrule__c": false,"isactive__c": true,"ishidden__c": false,"isnotassetizable__c": false,"isreadonly__c": false,"isquerydriven__c": false,"isconfigurable__c": true,"attributefilterable__c": true,"attributeconfigurable__c": true,"isrequired__c": false,"formatmask__c": null,"valueinnumber__c": null,"querycode__c": null,"querylabel__c": null,"rulemessage__c": null,"uidisplaytype__c": null,"value__c": null,"valuedescription__c": null,"attributeRunTimeInfo": {"dataType": "Text","default": "","value": "CAF77864-A995-11ED-AFA1-0242AC120002"},"Name": "Address ID","Code": "ATT_VC4_ADDRESSID","Filterable": false,"SegmentValue": "CAF77864-A995-11ED-AFA1-0242AC120002","$$AttributeDefinitionEnd$$": null},{"$$AttributeDefinitionStart$$": null,"categorycode__c": "4b93336c-6c18-9cba-94dd-40f94422e7c6","attributeid__c": "a1M6t000000xtydEAA","attributeuniquecode__c": "ATT_VC4_CONTACTID","attributedisplayname__c": "Contact ID","id": "","objectid__c": "","objecttype__c": null,"categoryname__c": "Category","valuedatatype__c": "Text","displaysequence__c": null,"attributecategoryid__c": "","attributedisplaysequence__c": null,"hasrule__c": false,"isactive__c": true,"ishidden__c": false,"isnotassetizable__c": false,"isreadonly__c": false,"isquerydriven__c": false,"isconfigurable__c": true,"attributefilterable__c": true,"attributeconfigurable__c": true,"isrequired__c": false,"formatmask__c": null,"valueinnumber__c": null,"querycode__c": null,"querylabel__c": null,"rulemessage__c": null,"uidisplaytype__c": null,"value__c": null,"valuedescription__c": null,"attributeRunTimeInfo": {"dataType": "Text","default": "","value": "0036t00000O5iggAAB"},"Name": "Contact ID","Code": "ATT_VC4_CONTACTID","Filterable": false,"SegmentValue": "0036t00000O5iggAAB","$$AttributeDefinitionEnd$$": null}]}';
        String productJsonAttribute = '{ "4b93336c-6c18-9cba-94dd-40f94422e7c6": [        { "$$AttributeDefinitionStart$$": null, "objectid__c": "01t6t000001ypTQAAY", "attributeid__c": "a1M6t000000xv5LEAQ", "attributecategoryid__c": "a1L6t000000KMBoEAO", "categorycode__c": "4b93336c-6c18-9cba-94dd-40f94422e7c6", "categoryname__c": "VC4 Technical Attributes", "attributeuniquecode__c": "ATT_VC4_ONT_MODEL", "attributeconfigurable__c": true, "attributedisplaysequence__c": "70", "attributefilterable__c": true, "attributecloneable__c": true, "isactive__c": true, "attributedisplayname__c": "ONT_Model", "displaysequence__c": "100", "categorydisplaysequence__c": 100, "customconfiguitemplate__c": null, "formatmask__c": null, "hasrule__c": false, "isconfigurable__c": false, "ishidden__c": false, "valueinnumber__c": null, "objecttype__c": "vlocity_cmt__ObjectClass__c", "querycode__c": null, "isreadonly__c": false, "isnottranslatable__c": false, "isquerydriven__c": false, "querylabel__c": null, "id": "a1J6t000000I0gVEAS", "isrequired__c": false, "rulemessage__c": null, "uidisplaytype__c": "Text", "value__c": null, "valuedatatype__c": "Text", "valuedescription__c": null, "attributegrouptype__c": null, "isnotassetizable__c": false, "attributeRunTimeInfo": { "dataType": "Text", "uiDisplayType": "Text" }, "$$AttributeDefinitionEnd$$": null }, { "$$AttributeDefinitionStart$$": null, "objectid__c": "01t6t000001ypTQAAY", "attributeid__c": "a1M6t000000xv5MEAQ", "attributecategoryid__c": "a1L6t000000KMBoEAO", "categorycode__c": "4b93336c-6c18-9cba-94dd-40f94422e7c6", "categoryname__c": "VC4 Technical Attributes", "attributeuniquecode__c": "ATT_VC4_ONT_VENDOR", "attributeconfigurable__c": true, "attributedisplaysequence__c": "50", "attributefilterable__c": true, "attributecloneable__c": true, "isactive__c": true, "attributedisplayname__c": "ONT_Vendor", "displaysequence__c": "100", "categorydisplaysequence__c": 100, "customconfiguitemplate__c": null, "formatmask__c": null, "hasrule__c": false, "isconfigurable__c": false, "ishidden__c": false, "valueinnumber__c": null, "objecttype__c": "vlocity_cmt__ObjectClass__c", "querycode__c": null, "isreadonly__c": false, "isnottranslatable__c": false, "isquerydriven__c": false, "querylabel__c": null, "id": "a1J6t000000I0gWEAS", "isrequired__c": false, "rulemessage__c": null, "uidisplaytype__c": "Text", "value__c": null, "valuedatatype__c": "Text", "valuedescription__c": null, "attributegrouptype__c": null, "isnotassetizable__c": false, "attributeRunTimeInfo": { "dataType": "Text", "uiDisplayType": "Text" }, "$$AttributeDefinitionEnd$$": null }, { "$$AttributeDefinitionStart$$": null, "objectid__c": "01t6t000001ypTQAAY", "attributeid__c": "a1M6t000000xv5NEAQ", "attributecategoryid__c": "a1L6t000000KMBoEAO", "categorycode__c": "4b93336c-6c18-9cba-94dd-40f94422e7c6", "categoryname__c": "VC4 Technical Attributes", "attributeuniquecode__c": "ATT_VC4_RG_MODEL", "attributeconfigurable__c": true, "attributedisplaysequence__c": "80", "attributefilterable__c": true, "attributecloneable__c": true, "isactive__c": true, "attributedisplayname__c": "RG_Model", "displaysequence__c": "100", "categorydisplaysequence__c": 100, "customconfiguitemplate__c": null, "formatmask__c": null, "hasrule__c": false, "isconfigurable__c": false, "ishidden__c": false, "valueinnumber__c": null, "objecttype__c": "vlocity_cmt__ObjectClass__c", "querycode__c": null, "isreadonly__c": false, "isnottranslatable__c": false, "isquerydriven__c": false, "querylabel__c": null, "id": "a1J6t000000I0gXEAS", "isrequired__c": false, "rulemessage__c": null, "uidisplaytype__c": "Text", "value__c": null, "valuedatatype__c": "Text", "valuedescription__c": null, "attributegrouptype__c": null, "isnotassetizable__c": false, "attributeRunTimeInfo": { "dataType": "Text", "uiDisplayType": "Text" }, "$$AttributeDefinitionEnd$$": null }, { "$$AttributeDefinitionStart$$": null, "objectid__c": "01t6t000001ypTQAAY", "attributeid__c": "a1M6t000000xv5OEAQ", "attributecategoryid__c": "a1L6t000000KMBoEAO", "categorycode__c": "4b93336c-6c18-9cba-94dd-40f94422e7c6", "categoryname__c": "VC4 Technical Attributes", "attributeuniquecode__c": "ATT_VC4_RG_VENDOR", "attributeconfigurable__c": true, "attributedisplaysequence__c": "60", "attributefilterable__c": true, "attributecloneable__c": true, "isactive__c": true, "attributedisplayname__c": "RG_Vendor", "displaysequence__c": "100", "categorydisplaysequence__c": 100, "customconfiguitemplate__c": null, "formatmask__c": null, "hasrule__c": false, "isconfigurable__c": false, "ishidden__c": false, "valueinnumber__c": null, "objecttype__c": "vlocity_cmt__ObjectClass__c", "querycode__c": null, "isreadonly__c": false, "isnottranslatable__c": false, "isquerydriven__c": false, "querylabel__c": null, "id": "a1J6t000000I0gYEAS", "isrequired__c": false, "rulemessage__c": null, "uidisplaytype__c": "Text", "value__c": null, "valuedatatype__c": "Text", "valuedescription__c": null, "attributegrouptype__c": null, "isnotassetizable__c": false, "attributeRunTimeInfo": { "dataType": "Text", "uiDisplayType": "Text" }, "$$AttributeDefinitionEnd$$": null }, { "$$AttributeDefinitionStart$$": null, "objectid__c": "01t6t000001ypTQAAY", "attributeid__c": "a1M6t000000xv5QEAQ", "attributecategoryid__c": "a1L6t000000KMBoEAO", "categorycode__c": "4b93336c-6c18-9cba-94dd-40f94422e7c6", "categoryname__c": "VC4 Technical Attributes", "attributeuniquecode__c": "ATT_VC4_TYPEOFSITE", "attributeconfigurable__c": true, "attributedisplaysequence__c": "40", "attributefilterable__c": true, "attributecloneable__c": true, "isactive__c": true, "attributedisplayname__c": "Type Of Site", "displaysequence__c": "100", "categorydisplaysequence__c": 100, "customconfiguitemplate__c": null, "formatmask__c": null, "hasrule__c": false, "isconfigurable__c": false, "ishidden__c": false, "valueinnumber__c": null, "objecttype__c": "vlocity_cmt__ObjectClass__c", "querycode__c": null, "isreadonly__c": false, "isnottranslatable__c": false, "isquerydriven__c": false, "querylabel__c": null, "id": "a1J6t000000I0gaEAC", "isrequired__c": false, "rulemessage__c": null, "uidisplaytype__c": "Single Value", "value__c": null, "valuedatatype__c": "Number", "valuedescription__c": null, "attributegrouptype__c": null, "isnotassetizable__c": false, "attributeRunTimeInfo": { "dataType": "Number", "uiDisplayType": "Single Value" }, "$$AttributeDefinitionEnd$$": null } ] }';
        String ADDRESSID = 'CAF77864-A995-11ED-AFA1-0242AC120002';
        String PRODUCTFAMILY = 'Fiber Broadband';

        Account consumerAcc = new Account (
            Name = 'consumer Account',
            RecordTypeId = consumerAccRecordtypeId,
            Phone = '1234567890',
            BillingStreet = '123 Main St',
            BillingCity = 'Anytown',
            BillingState = 'California',
            BillingPostalCode = '12345',
            BillingCountry = 'United States',
            ShippingStreet = '123 Main St',
            ShippingCity = 'Anytown',
            ShippingState = 'California',
            ShippingPostalCode = '12345',
            ShippingCountry = 'United States'
        );
        insert consumerAcc;

        TypeOfSite__c typeSite = new TypeOfSite__c(
        	Code__c = 1,
            LEC__c = 'TEST',
            Name = 'Test'
        );
        
        insert typeSite;

        ServiceAddress__c  servAddress = new ServiceAddress__c (            
            City__c = 'KERNERSVILLE',
            Street__c = 'ASHEBY WOODS',    
            Zip4__c = '27284-1234',
            State__c = 'NC',              
            Address_Id__c = ADDRESSID,
            TypeOfSite__c = typeSite.Id,
            TypeOfSiteExternalID__c = '1'

        );

        insert servAddress;

        Account serviceAcc = new Account (
            Name = 'service Account',
            RecordTypeId = serviceAccRecordtypeId,
            ParentId = consumerAcc.Id,
            Phone = '1234567890',
            BillingStreet = '456 Main St',
            BillingCity = 'Anytown',
            BillingState = 'California',
            BillingPostalCode = '12345',
            BillingCountry = 'United States',
            ShippingStreet = '456 Main St',
            ShippingCity = 'Anytown',
            ShippingState = 'California',
            ShippingPostalCode = '12345',
            ShippingCountry = 'United States',
            Service_Address__c = servAddress.Id
        );
        insert serviceAcc;
            
        Order order = new Order(
            AccountId = consumerAcc.Id,
            Status = 'Draft',
            vlocity_cmt__OrderStatus__c = 'Ready To Submit',
            Pricebook2Id= pricebookId,
            EffectiveDate = Date.today(),
            EndDate = Date.today().addDays(30),
            ReservedNumber__c = '1234567890'
        );

        insert order;
        
        order.vlocity_cmt__FirstVersionOrderIdentifier__c = order.id;
        
        update order;

        Product2 fiberProduct = new Product2 (
            Name = 'FiberInternetProduct',
            ProductCode = 'FiberInternetLine',
            Family = PRODUCTFAMILY,
            vlocity_cmt__JSONAttribute__c = productJsonAttribute,
            ConnectionType__c ='Connection Type',
            UploadSpeed__c = '100mb',
            DownloadSpeed__c = '100mb'
        );

        insert fiberProduct;

        Product2 voiceProduct = new Product2 (
            Name = 'voiceInternetProduct',
            ProductCode = 'voiceInternetLine',
            Family = 'Voice',
            vlocity_cmt__JSONAttribute__c = productJsonAttribute
            
        );

        insert voiceProduct;
        
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id = fiberProduct.Id,
            UnitPrice = 10.0,
            IsActive = true
        );

        insert pbe;

        PricebookEntry pbe2 = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id = voiceProduct.Id,
            UnitPrice = 10.0,
            IsActive = true
        );

        insert pbe2;

        OrderItem orderIt = new OrderItem(
            Product2Id = fiberProduct.Id,
            OrderId = order.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 1,
            UnitPrice = 10.0,
            vlocity_cmt__OneTimeCalculatedPrice__c= 30,
            vlocity_cmt__RecurringCalculatedPrice__c = 20
            
        );    

        insert orderIt;

        OrderItem orderIt2 = new OrderItem(
            Product2Id = voiceProduct.Id,
            OrderId = order.Id,
            PricebookEntryId = pbe2.Id,
            Quantity = 1,
            UnitPrice = 10.0,
            vlocity_cmt__OneTimeCalculatedPrice__c= 30,
            vlocity_cmt__RecurringCalculatedPrice__c = 20
            
        );    
            
        insert orderIt2;
        
        orderIt.vlocity_cmt__ServiceAccountId__c = serviceAcc.Id;

        update orderIt;

        orderIt2.vlocity_cmt__ServiceAccountId__c = serviceAcc.Id;

        update orderIt2;

        vlocity_cmt__OrchestrationPlan__c orchPlan = new vlocity_cmt__OrchestrationPlan__c();
        orchPlan.vlocity_cmt__OrderId__c = order.Id;
        orchPlan.vlocity_cmt__AccountId__c = consumerAcc.Id;
        insert orchPlan;

        vlocity_cmt__FulfilmentRequest__c FR = new vlocity_cmt__FulfilmentRequest__c(
            
            vlocity_cmt__OrderId__c = order.Id,
            vlocity_cmt__AccountId__c = consumerAcc.Id
        );

        insert FR;

        vlocity_cmt__FulfilmentRequestLine__c FRL = new vlocity_cmt__FulfilmentRequestLine__c(
            vlocity_cmt__Product2Id__c = fiberProduct.Id,           
            vlocity_cmt__FulfilmentRequestID__c =FR.Id,
            vlocity_cmt__JSONAttribute__c = FRLJsonAttribute
        );

        insert FRL;
        
        vlocity_cmt__OrchestrationItem__c orchItem = new vlocity_cmt__OrchestrationItem__c(
            vlocity_cmt__OrchestrationPlanId__c= orchPlan.Id,
            vlocity_cmt__FulfilmentRequestLineId__c =FRL.Id
        );
        insert orchItem;
        
        //Adding a canceled order
		vlocity_cmt__OrchestrationItem__c orchItemCancel = new vlocity_cmt__OrchestrationItem__c(
		    vlocity_cmt__OrchestrationPlanId__c= orchPlan.Id, //a4C6t0000004acVEAQ
            vlocity_cmt__FulfilmentRequestLineId__c =FRL.Id   //a396t000000yYPIAA2
            //vlocity_cmt__compensatedOrchestrationItemId__c = orchItem.Id
        ); 
        
        insert orchItemCancel;
        
        Order orderCancel = new Order(
            AccountId = consumerAcc.Id,
            vlocity_cmt__FirstVersionOrderIdentifier__c = order.Id,
            Status = 'Draft',
            vlocity_cmt__OrderStatus__c = 'Ready To Submit',
            Pricebook2Id= pricebookId,
            EffectiveDate = Date.today(),
            EndDate = Date.today().addDays(30),
            ReservedNumber__c = '1234567890'
        );
        
        insert orderCancel;
        
        vlocity_cmt__OrderPayment__c orderPayment = new vlocity_cmt__OrderPayment__c(
        	vlocity_cmt__PaymentAmount__c = 10,
            vlocity_cmt__PaymentEventIdentifier__c = '999999',
            vlocity_cmt__OrderId__c = order.Id
        );
        
        insert orderPayment;
        
        system.debug(orderPayment);
        
        
    }
    
    @isTest
    private static void Test_GTVRefundPrepareRequest(){
        
        vlocity_cmt__OrchestrationItem__c item = [SELECT 
                                                  vlocity_cmt__OrchestrationPlanId__c,
                                                  vlocity_cmt__OrchestrationPlanId__r.vlocity_cmt__OrderId__c,
                                                  vlocity_cmt__FulfilmentRequestLineId__c 
            									  FROM vlocity_cmt__OrchestrationItem__c 
                                                  LIMIT 1];
        
        system.debug(item.id);
        
        
        
        Configuration__mdt gtvReason = Configuration__mdt.getInstance('GTVPaymentChangeReason');
        
         //'{"amount":10.00,"cancel_payment":true,"description":"on demand","payment_change_reason":{"id":"220","name":"Default Chargeback Reason","reason_type":"payment-change"},"payment_type":"refund"}';
        String jsonStringExpected ='{\"payment_type\":\"refund\",\"payment_change_reason\":{\"reason_type\":\"payment-change\",\"name\":\"Default Chargeback Reason\",\"id\":\"' + String.valueOf(gtvReason.Value__c) + '\"},\"description\":\"on demand\",\"cancel_payment\":true,\"amount\":100}';
        system.debug(LoggingLevel.INFO, 'expected'+ jsonStringExpected);
                                   


        Test.startTest();
            String result = GTVRefundPrepareRequest.prepareRequest(item);
        Test.stopTest();
        
        	String res = result.substringBefore('/-/');
			
        system.debug(LoggingLevel.INFO, 'result  '+ Pattern.compile('(.{299})').matcher(JSON.serialize(res)).replaceAll('$1\n'));
        
		System.assert(jsonStringExpected.equals(res),'Request must match');
        
        
    }
       
}