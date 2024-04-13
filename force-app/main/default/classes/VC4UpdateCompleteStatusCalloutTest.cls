@IsTest
public with sharing class VC4UpdateCompleteStatusCalloutTest {
    private static final String SERVICE_ID = '12345';
    private static final Id ACCOUNT_RECORDTYPE_CONSUMER = Utils.getRecordTypeId('Account','Consumer');
    private static final String PRODUCT_FAMILY_WIFI = 'Wi-Fi';
    private static final String PRODUCT_FAMILY_FIBER = 'Fiber Broadband';
    
    
static TestMethod void prepareEnviroment(){
        
        List<Product2> products = new List<Product2>();
        List<Asset> assets = new List<Asset>();
        List<WorkOrderLineItem> wolis = new List<WorkOrderLineItem>();
        
        
        WorkType MRWT = new WorkType(
                Name ='Make Ready',
                DurationType = 'Hours',
                EstimatedDuration = 2,
                ShouldAutoCreateSvcAppt = false
        );
        
        insert MRWT;
        
        Id consumerAccRecordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        Id serviceAccRecordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Service').getRecordTypeId();
        String ADDRESSID = 'CAF77864-A995-11ED-AFA1-0242AC120002';
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
        ShippingCountry = 'United States');
        insert consumerAcc;
        TypeOfSite__c typeSite = new TypeOfSite__c( Code__c = 1, LEC__c = 'Test', Name = 'Test');
        insert typeSite;
        Account serviceAcc = new Account (Name = 'service Account',RecordTypeId = serviceAccRecordtypeId, ParentId = consumerAcc.Id, Phone = '1234567890', BillingStreet = '456 Main St', BillingCity = 'Anytown', BillingState = 'California', BillingPostalCode = '12345', BillingCountry = 'United States',ShippingStreet = '456 Main St', ShippingCity = 'Anytown', ShippingState = 'California',ShippingPostalCode = '12345',ShippingCountry = 'United States');
        insert serviceAcc;
        Account consumerAccount = new Account(Name = 'Test Account BACC',RecordTypeId = ACCOUNT_RECORDTYPE_CONSUMER,BillingCity ='Virginia Beach',BillingCountry ='United States', BillingPostalCode ='23454',BillingState = 'VA', BillingStreet = '1701 Will O Wisp Drive');
        insert consumerAccount;
        
        Product2 productOffer = new Product2(
            Name = 'Fiber Internet - 1 Gig With Wifi Offer',
            vlocity_cmt__SpecificationType__c = 'Offer'
        );

        products.add(productOffer);

        Product2 productFiber = new Product2(
            Name = 'Fiber Internet 1000x1000',
            vlocity_cmt__SpecificationType__c = 'Product',
            Family = PRODUCT_FAMILY_FIBER
        );
        
        products.add(productFiber);

        insert products;

        Asset offerAsset = new Asset(
            Name = 'Fiber Internet - 1 Gig With Wifi Offer',
            AccountId = consumerAccount.Id,
            vlocity_cmt__AssetReferenceId__c = 'cc5a5cb7-a39c-c177-d880-29e96j0527c2b',
            Product2Id = productOffer.Id                
        );
        
        assets.add(offerAsset);
        
        Asset fiberBrodbandAsset = new Asset(
            Name = 'Fiber Internet 1000x1000',
            AccountId = consumerAccount.Id,
            vlocity_cmt__ParentItemId__c = 'cc5a5cb7-a39c-c177-d880-29e96j0527c2b',
            Product2Id = productFiber.Id,
            RGSerialNumber__c = 'RG001SN',
            ONTSerialNumber__c = 'ONT001SN'
        );
        
        insert assets;
        
        WorkOrder wo = new WorkOrder(
            WorkTypeId = MRWT.Id,
            Status = 'New',
            AssetId = offerAsset.Id,
            AccountId = consumerAccount.Id);

        insert wo;
        
        WorkOrderLineItem woliFiber = new WorkOrderLineItem(
            Service_Id__c = SERVICE_ID,
            WorkOrderId = wo.Id,
            AssetId = fiberBrodbandAsset.Id,
            RelatedResource__c = '130001',
            MainResource__c = '130000',
            RGSerialNumber__c = 'RG001SN',
            ONTSerialNumber__c = 'ONT001SN',
            Vc4FromPortAux__c = 'OUTPUT 0003',
            Vc4ToPortAux__c = 'OUTPUT 0004',
            LCPAssignmentVC4InternalId__c = '660354',
            VC4GetAssignmentsResponse__c = '{"x_from":[{"nodeName":"11562S_LCC_SPLITTER1","name":"OUTPUT 0003","internalId":"6417939"}],"to":[{"name":"OUTPUT 0004","internalId":"154272","fromName":"11562S_LCC, 008"}]}'
        );
        insert woliFiber;
        woliFiber.Status='Completed';
        Update woliFiber;
    }
    
}