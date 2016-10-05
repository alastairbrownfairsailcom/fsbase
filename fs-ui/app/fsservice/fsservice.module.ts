import { NgModule }      from '@angular/core';
import { CommonModule }       from '@angular/common';
import { HttpModule, JsonpModule } from '@angular/http';
import { FSProcessService }   from './fsprocess-service';
import { FSObjectService }   from './fsobject-service';

@NgModule({
    imports:      [
        HttpModule,
        JsonpModule,
        CommonModule
    ],
    declarations: [],
    exports: [],
    providers: [FSProcessService, FSObjectService]
})
export class FSServiceModule { }
