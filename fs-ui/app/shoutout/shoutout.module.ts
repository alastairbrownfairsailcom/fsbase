import { NgModule }      from '@angular/core';
import { CommonModule }       from '@angular/common';
import { ShoutOutProcessComponent }   from './shoutout-process.component';

@NgModule({
    imports: [
        CommonModule
    ],
    declarations: [ShoutOutProcessComponent],
    exports: [ShoutOutProcessComponent],
    providers: []
})
export class ShoutOutModule { }
