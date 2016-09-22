import { Component, OnInit } from '@angular/core';

@Component({
    selector: 'shoutout-process',
    templateUrl:'app/shoutout/shoutout-process.component.html',
    styleUrls:['app/shoutout/shoutout-process.component.css'],
    providers: []
})

export class ShoutOutProcessComponent implements OnInit {
    ok : boolean =false;
    ngOnInit() {
        console.log('Starting ShoutOutProcessComponent');
    }

}
