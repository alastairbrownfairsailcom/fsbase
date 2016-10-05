import { NgModule }      from '@angular/core';
import { CommonModule }       from '@angular/common';
import { HttpModule, JsonpModule } from '@angular/http';
import { FSProcessListComponent }   from './fsprocess-list.component';
import { FSServiceModule }   from '../fsservice/fsservice.module';

@NgModule({
    imports:      [
        HttpModule,
        JsonpModule,
        CommonModule,
        FSServiceModule
    ],
    declarations: [FSProcessListComponent],
    exports: [FSProcessListComponent],
    providers: []
})
export class FSProcessModule { }
