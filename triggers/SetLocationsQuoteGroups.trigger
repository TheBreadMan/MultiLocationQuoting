trigger SetLocationsQuoteGroups on SBQQ__Quote__c (after insert) {

    for(SBQQ__Quote__c q : Trigger.New){
        
        Service_Location__c[] locations = [Select Name, Group_Name__c, Id From Service_Location__c where Service_Location__c.Opportunity__c = :q.Opportunity_Id__c];
        
        SBQQ__QuoteLineGroup__c[] groups = new SBQQ__QuoteLineGroup__c[]{};
        Integer counter = 1;
        
        for(Service_Location__c loc: locations){
        
            SBQQ__QuoteLineGroup__c groupLine = new SBQQ__QuoteLineGroup__c();
            groupLine.SBQQ__Quote__c = q.Id;
            groupLine.Name = loc.Group_Name__c;
            groupLine.SBQQ__Number__c = counter;
            counter = counter + 1;
            groupLine.SBQQ__NetTotal__c = 0.00;
            groupLine.SBQQ__CustomerTotal__c = 0.00;
            groupLine.SBQQ__ListTotal__c = 0.00;
            groupLine.Service_Location__c = loc.Id;

            groups.add(groupLine);
            
        }
        insert groups;
    }
    
}