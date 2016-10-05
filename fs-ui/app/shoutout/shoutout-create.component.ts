import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute, Params} from '@angular/router';
import {ShoutOut} from './shoutout';
import {FSLookup} from '../interfaces/fslookup';
import {FSOption} from '../interfaces/fsprocess';
import {FSProcess} from '../interfaces/fsprocess';
import {FSObjectService} from '../fsservice/fsobject-service';
import {FSProcessService} from '../fsservice/fsprocess-service';

@Component({
    selector: 'shoutout-create',
    templateUrl:'app/shoutout/shoutout-create.component.html',
    styleUrls:['app/shoutout/shoutout-create.component.css'],
    providers: []
})

export class ShoutOutCreateComponent implements OnInit {
    fsProcess: FSProcess;
    shoutOut: ShoutOut;
    receivers: FSLookup[];
    opportunities: FSLookup[];
    reasons: FSOption[];
    constructor(
        private _fsProcessService: FSProcessService,
        private _fsObjectService: FSObjectService,
        private _router: Router,
    private _route : ActivatedRoute) {
        this.shoutOut = <ShoutOut> {};
    }

    getFSProcess(procesId) {
        this._fsProcessService.getFSProcess(procesId).subscribe(fsProcess => {
            this.fsProcess = <FSProcess> fsProcess;

            this.reasons = fsProcess.objects[0].fields[0].options;
        });
    }
    getUsers(processId) {
        this._fsObjectService.getFSLookups('User', 'ShoutOut2', {'processId' : processId}).subscribe(receivers => this.receivers = <FSLookup[]> receivers);
    }
    getOpportunities(processId) {
        this._fsObjectService.getFSLookups('Opportunity', 'ShoutOut2', {'processId' : processId}).subscribe(opportunities => this.opportunities = <FSLookup[]> opportunities);
    }
    ngOnInit() {
        this._route.parent.params.forEach((params: Params) => {

            let processId = params['processId'];

            this.getFSProcess(processId);
            this.getUsers(processId);
            this.getOpportunities(processId);
        });
    }
    onSubmit() {
        this._fsObjectService.createFSObject('ShoutOut2', {}, this.shoutOut).subscribe(shoutOut => {
                this.shoutOut = <ShoutOut> {};

                this.cancel();
            }
        );
    }
    cancel() {
        this._router.navigate(['list'], { relativeTo: this._route.parent });
    }
}
