import { LightningElement,track,api  } from 'lwc';
import teamRecord from '@salesforce/apex/teamRecordDetail.teamRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class CreateTeamButton extends LightningElement {
    @track isModalOpen = false;
    @track HomeTeam = '';
    @track AwayTeam = '';
    
    onCreateTeam(){
         this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }
    
    handleTeamName1Change(event){
        this.HomeTeam = event.target.value;
    }
    handleTeamName2Change(event){
        this.AwayTeam = event.target.value;
    }
    submitDetails(event) {
        this.isModalOpen = false;

        teamRecord({homeTeam:this.HomeTeam,awayTeam:this.AwayTeam})
        .then(result =>{
            
        })
        .catch(error => {
            console.log("Error"+JSON.stringify(error));
        })
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Team Created Successfully',
                variant:'success'
            })
        );
    }
}
