import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute, Params} from '@angular/router';
import {ShoutOut} from './shoutout';
import {FSObjectService} from '../fsservice/fsobject-service';

@Component({
    selector: 'shoutout-detail',
    templateUrl:'app/shoutout/shoutout-detail.component.html',
    styleUrls:['app/shoutout/shoutout-detail.component.css'],
    providers: []
})

export class ShoutOutDetailComponent implements OnInit {
    shoutOut: ShoutOut;
    constructor(
        private _fsObjectService: FSObjectService,
        private _router: Router,
    private _route : ActivatedRoute) { }

    getShoutOut(shoutOutId) {
        this._fsObjectService.getFSObject('ShoutOut2', shoutOutId, {}).subscribe(shoutOut => this.shoutOut = <ShoutOut> shoutOut);
    }
    ngOnInit() {
        this._route.params.forEach((params:Params) => {
            let shoutOutId = params['shoutOutId'];
            this.getShoutOut(shoutOutId);
        });
    }
    listShoutOuts() {
        this._router.navigate(['list'], { relativeTo: this._route.parent });
    }
}
