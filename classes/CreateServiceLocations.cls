public class CreateServiceLocations {

  public PageReference addLocations(){
    return null;
  }

  public CreateServiceLocations(){

  }

  Opportunity opp;
  Id acctID;

  //Gets the Opp.ID. Stores it in Variable acctID
  public CreateServiceLocations(
    ApexPages.StandardSetController controller)
    {
      this.opp = (Opportunity)controller.getRecord();

      List<Opportunity> opptys = new List<Opportunity>();
      opptys = [SELECT  Account.Id FROM Opportunity WHERE id= :opp.Id];
      acctID = opptys[0]. Account.Id;
    }

    public ApexPages.StandardSetController setCon{
      get {
        if(setCon == null){
          setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
            [SELECT Name FROM Account]
            ));
        }
        return setCon;
      }
      set;
    }

    public List<Account> getLocations(){
      return (List<Account>) setCon.getRecords();
    }
}
