public class teamRecordDetail {
    
    
    @AuraEnabled
    public static List<MyTeam__c> teamRecord(String homeTeam, String awayTeam){
        
	List<MyTeam__c> myTeamList = new List<MyTeam__c>();
        
        if(homeTeam != NULL && awayTeam != NULL){
            
            MyTeam__c myTeam = new MyTeam__c();
            myTeam.HomeTeam__c = homeTeam;
            myTeam.AwayTeam__c = awayTeam;
            
			myTeamList.add(myTeam);          
        }
        if(!myTeamList.isEmpty()){
            insert myTeamList;         
        }
        return myTeamList;
    }
	
    @AuraEnabled(cacheable = true)
    public static List<MyTeam__c> showTeamDetail(){
        
        return [SELECT Id, HomeTeam__c,AwayTeam__c,HomeTeamScore__c,Status__c,AwayTeamScore__c FROM MyTeam__c where Status__c = 'Progress' order BY CreatedDate ];
    }
    
    @AuraEnabled(cacheable = true)
    public static List<MyTeam__c> fatchFinishedMatch(){
        return [SELECT Id, HomeTeam__c,AwayTeam__c,TotalScore__c,HomeTeamScore__c,Status__c,AwayTeamScore__c FROM MyTeam__c where Status__c = 'Finish' order BY TotalScore__c desc,CreatedDate desc ];
    }
    
    @AuraEnabled
    public static List<MyTeam__c> updateStatusOfTeam(Id recId){
        
        List<MyTeam__c> myTeamStatus = [SELECT id, Status__c FROM MyTeam__c where Id =:recId ];
        List<MyTeam__c> updatedStatus = new List<MyTeam__c>(); 
        for(MyTeam__c team : myTeamStatus){
            
            team.Status__c = 'Finish';
            updatedStatus.add(team);
            
        }
        update updatedStatus;
        return [SELECT Id, HomeTeam__c,AwayTeam__c,HomeTeamScore__c,Status__c,AwayTeamScore__c FROM MyTeam__c where Status__c = 'Progress' order BY HomeTeam__c desc ];
        
    }
}