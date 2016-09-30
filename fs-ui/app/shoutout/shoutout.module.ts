import { NgModule }      from '@angular/core';
import { CommonModule }       from '@angular/common';
import { ShoutOutProcessComponent }   from './shoutout-process.component';
import { ShoutOutListComponent }   from './shoutout-list.component';

@NgModule({
    imports: [
        CommonModule
    ],
    declarations: [ShoutOutProcessComponent, ShoutOutListComponent],
    exports: [ShoutOutProcessComponent,ShoutOutListComponent],
    providers: []
})
export class ShoutOutModule { }
