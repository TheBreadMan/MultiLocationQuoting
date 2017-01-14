public with sharing class wrapperClassController {


    //Our collection of the class/wrapper objects locationWrapper
    public List<locationWrapper> locationList {get; set;}
    public Opportunity opp;
    public Id acctID;

    public wrapperClassController(ApexPages.StandardController controller) {
        this.opp = (Opportunity)controller.getRecord();

        List<Opportunity> opptys = new List<Opportunity>();
        opptys = [
          SELECT Account.Id
          FROM Opportunity
          WHERE Opportunity.Id = :opp.id];
        acctID = opptys[0].Account.Id ;
    }

    //This method uses a simple SOQL query to return a List of Accounts
    public List<locationWrapper> getLocations() {
        if(locationList == null) {
            locationList = new List<locationWrapper>();
            for(Account l: [SELECT Name, BillingStreet, BillingCity, BillingState, BillingPostalCode FROM Account WHERE Parent.id = :acctID]) {
                // As each contact is processed we create a new locationWrapper object and add it to the locationList
                locationList.add(new locationWrapper(l));
            }
        }
        return locationList;
    }


    public PageReference processSelected() {

        Service_Location__c[] serviceLocations = new List<Service_Location__c>();

        for(locationWrapper lw: locationList){

            if(lw.selected == true){
                Service_Location__c servLoc = new Service_Location__c();
                servLoc.Opportunity__c = opp.Id;
                servLoc.A_Account__c = lw.loc.Id;
                serviceLocations.add(servLoc);
            }

        }

        upsert serviceLocations;

        PageReference pre = new PageReference('https://na30.salesforce.com/' + opp.Id);
        pre.setredirect(true);
        return pre;
    }


    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Contact and a Boolean value
    public class locationWrapper {
        public Account loc {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new locationWrapper object we pass a Contact that is set to the con property. We also set the selected value to false
        public locationWrapper(Account l) {
            loc = l;
            selected = false;
        }
    }
}
