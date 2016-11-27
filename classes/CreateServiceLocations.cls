public class CreateServiceLocations {

    public PageReference addLocations() {
        return null;
    }


    public CreateServiceLocations() {

    }

    // ApexPages.StandardSetController must be instantiated
    // for standard list controllers
    Opportunity opp;
    Id acctID;
    
    public CreateServiceLocations(
           ApexPages.StandardSetController controller) 
    {
           this.opp = (Opportunity)controller.getRecord(); 
           
           List<Opportunity> opptys = new List<Opportunity>();
           opptys = [Select Account_ID__c FROM Opportunity WHERE Id = :opp.Id];
           acctID = opptys[0].Account_ID__c;
    } 
    
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Name, Street_Address__c, City__c, State__c, Postal_Code__c FROM Location__c]));
            }
            return setCon;
        }
        set;
    }

    // Initialize setCon and return a list of records
    public List<Location__c> getLocations() {
        return (List<Location__c>) setCon.getRecords();
    }
}