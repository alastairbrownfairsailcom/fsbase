import { Component, OnInit } from '@angular/core';
import {Router, RouterLink} from '@angular/router';
import {FSProcessService} from '../fsservice/fsprocess-service';
import { FSProcess } from '../interfaces/fsprocess'

@Component({
    selector: 'fsprocess-list',
    templateUrl:'app/fsprocess/fsprocess-list.component.html',
    styleUrls:['app/fsprocess/fsprocess-list.component.css'],
    providers: []
})

export class FSProcessListComponent implements OnInit {
    fsProcesses: FSProcess[];
    selectedFSProcess: FSProcess;
    constructor(
        private _router: Router,
        private _fsprocessService: FSProcessService) { }
    getFSProcesses() {
        this._fsprocessService.getFSProcesses().subscribe(fsProcesses => this.fsProcesses = fsProcesses);
    }
    ngOnInit() {
        this.getFSProcesses();
    }
    onSelect(fsProcess: FSProcess) {
        this.selectedFSProcess = fsProcess;

        this._router.navigate(['/'+fsProcess.componentName, {processId: fsProcess.id}]);
    }
}
