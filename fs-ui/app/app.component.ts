import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
    selector: 'my-app',
    template: `
    <h1>FS Framework Demo</h1>
    <br/>
    <div id="navigation">
        <fsprocess-list></fsprocess-list>
    </div>
    <div id="detail">
        <router-outlet></router-outlet>
    </div>
    `
})

export class AppComponent { }
