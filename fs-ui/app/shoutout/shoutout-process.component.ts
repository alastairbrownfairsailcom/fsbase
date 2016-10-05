import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, Params } from '@angular/router';
import { FSProcessService } from '../fsservice/fsprocess-service';
import { FSProcess } from '../interfaces/fsprocess'

@Component({
    selector: 'shoutout-process',
    templateUrl:'app/shoutout/shoutout-process.component.html',
    styleUrls:['app/shoutout/shoutout-process.component.css'],
    providers: []
})

export class ShoutOutProcessComponent implements OnInit {
    ok : boolean =false;
    fsProcess : FSProcess;
    html: string;
    constructor(
        private _fsprocessService: FSProcessService,
        private _route: ActivatedRoute,
        private _router: Router
    ) {}
    ngOnInit() {
        console.log('Starting ShoutOutProcessComponent');

        this._route.params.forEach((params: Params) => {
            this.getFSProcess(params['processId']);
        });
    }
    getFSProcess(id: string) {
        this._fsprocessService.getFSProcess(id).subscribe(fsProcess => {
            this.fsProcess = fsProcess;
            console.log('Loading component ' + this.fsProcess.componentName);

            this.html = this.fsProcess.componentName;
        });
    }
}
