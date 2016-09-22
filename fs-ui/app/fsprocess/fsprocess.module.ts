import { NgModule }      from '@angular/core';
import { CommonModule }       from '@angular/common';
import { HttpModule, JsonpModule } from '@angular/http';
import { FSProcessListComponent }   from './fsprocess-list.component';
import { FSProcessDetailComponent, ComponentOutlet }   from './fsprocess-detail.component';
import { FSProcessService }   from '../fsprocess/fsprocess-service';
import { FSObjectService }   from '../fsprocess/fsobject-service';

@NgModule({
    imports:      [
        HttpModule,
        JsonpModule,
        CommonModule
    ],
    declarations: [FSProcessListComponent, FSProcessDetailComponent, ComponentOutlet],
    exports: [FSProcessListComponent, FSProcessDetailComponent, ComponentOutlet],
    providers: [FSProcessService, FSObjectService]
})
export class FSProcessModule { }
