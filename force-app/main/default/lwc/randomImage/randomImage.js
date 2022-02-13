import { LightningElement, wire, track } from 'lwc';
import getRandomImageData from '@salesforce/apex/RandomImageContoller.getRandomImageData'

export default class RandomImage extends LightningElement {
    @track image;
    @track numOfLikes;
    @track photographerName;
    @track portfolio;

    @wire(getRandomImageData)
    async loadData({data, error}){
        if(error) {
            console.log(`error: ${JSON.stringify(error)}`);
        }else if(data) {
            console.log(`data: ${JSON.stringify(data)}`);
            this.image = data.image;
            this.numOfLikes = data.numOfLikes;
            this.photographerName= data.photographerName;
            this.portfolio = data.portfolio;

        }
    }
}