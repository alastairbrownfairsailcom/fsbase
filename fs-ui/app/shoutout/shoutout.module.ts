import { NgModule }      from '@angular/core';
import { CommonModule }       from '@angular/common';
import { ShoutOutProcessComponent }   from './shoutout-process.component';
import { ShoutOutListComponent }   from './shoutout-list.component';
import { ShoutOutDetailComponent }   from './shoutout-detail.component';
import { ShoutOutCreateComponent }   from './shoutout-create.component';
import { FSServiceModule }   from '../fsservice/fsservice.module';
import { shoutOutRouting } from './shoutout.routing';
import { FormsModule }   from '@angular/forms';

@NgModule({
    imports: [
        CommonModule,
        FSServiceModule,
        shoutOutRouting,
        FormsModule
    ],
    declarations: [ShoutOutProcessComponent, ShoutOutListComponent, ShoutOutDetailComponent, ShoutOutCreateComponent],
    exports: [ShoutOutProcessComponent, ShoutOutListComponent, ShoutOutDetailComponent, ShoutOutCreateComponent],
    providers: []
})
export class ShoutOutModule { }
