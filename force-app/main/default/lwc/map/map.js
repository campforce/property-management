import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['Property__c.City__c', 'Property__c.Country__c', 'Property__c.Street__c'];

export default class Map extends LightningElement {

    @api recordId;
    
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    property;
    
    get mapMarkers() {
        return [
            {
                location: {
                    City: this.property.fields.City__c.value,
                    Country: this.property.fields.Country__c.value,
                    Street: this.property.fields.Street__c.value,
                },           
                icon: 'standard:account',
            },
        ];
    }
}