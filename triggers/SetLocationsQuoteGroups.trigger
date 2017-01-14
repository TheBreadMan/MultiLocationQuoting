trigger SetLocationsQuoteGroups on SBQQ__Quote__c (after insert) {

    for(SBQQ__Quote__c q : Trigger.New){

        Service_Location__c[] locations =
          [SELECT Name, Group_Name__c, Id, Address__c, A_Account__r.ID
          FROM Service_Location__c
          WHERE Service_Location__c.Opportunity__c = :q.Opportunity_ID__c];

        SBQQ__QuoteLineGroup__c[] groups = new SBQQ__QuoteLineGroup__c[]{};
        Integer counter = 1;

        for(Service_Location__c loc: locations){

            SBQQ__QuoteLineGroup__c groupLine = new SBQQ__QuoteLineGroup__c();
            groupLine.SBQQ__Quote__c = q.Id;
            groupLine.Name = loc.Group_Name__c;
            groupLine.SBQQ__Number__c = counter;
            groupLine.SBQQ__Description__c = loc.Address__c;
            groupLine.SBQQ__Account__c = loc.A_Account__r.ID;
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
