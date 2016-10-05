import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute, RouterLink} from '@angular/router';

import {ShoutOut} from './shoutout';
import {FSObjectService} from '../fsservice/fsobject-service';

@Component({
    selector: 'shoutout-list',
    templateUrl:'app/shoutout/shoutout-list.component.html',
    styleUrls:['app/shoutout/shoutout-list.component.css'],
    providers: []
})

export class ShoutOutListComponent implements OnInit {
    givenShoutOuts: ShoutOut[];
    receivedShoutOuts: ShoutOut[];
    constructor(
        private _router: Router,
        private _route: ActivatedRoute,
        private _fsObjectService: FSObjectService) { }
    getShoutOuts() {
        this._fsObjectService.getFSObjects('ShoutOut2', {given: 'true'}).subscribe(shoutOuts => this.givenShoutOuts = <ShoutOut[]> shoutOuts);
        this._fsObjectService.getFSObjects('ShoutOut2', {}).subscribe(shoutOuts => this.receivedShoutOuts = <ShoutOut[]> shoutOuts);
    }
    ngOnInit() {
        this.getShoutOuts();
    }
    selectShoutOut(shoutOut: ShoutOut) {
        this._router.navigate([shoutOut.id], { relativeTo: this._route.parent });
    }
    createShoutOut() {
        this._router.navigate(['create'], { relativeTo: this._route.parent });
    }
}
