import { Component, OnInit } from '@angular/core';
import {Router, RouterLink} from '@angular/router';

import {ShoutOut} from './ShoutOut';
//import {HeroDetailComponent} from './ShoutOut-detail.component';
import {FSObjectService} from '../fsprocess/fsobject-service';

@Component({
    selector: 'shoutout-list',
    templateUrl:'app/shoutout/shoutout-list.component.html',
    styleUrls:['app/shoutout/shoutout-list.component.css'],
    providers: []
})

export class ShoutOutListComponent implements OnInit {
    shoutOuts: ShoutOut[];
    selectedShoutOut: ShoutOut;
    constructor(
        private _router: Router,
        private _fsObjectService: FSObjectService) { }
    getShoutOuts() {
        this._fsObjectService.getFSObjects().subscribe(shoutOuts => this.shoutOuts = <ShoutOut[]> shoutOuts);
    }
    ngOnInit() {
        this.getShoutOuts();
    }
    onSelect(shoutOut: ShoutOut) {
        this.selectedShoutOut = shoutOut;

        this._router.navigate(['/ShoutOut', shoutOut.id]);
    }
}