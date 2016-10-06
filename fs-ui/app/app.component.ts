import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
    selector: 'my-app',
    template: `
	<div class="slds-page-header">
        <h1 class="slds-text-heading--large">FS Framework (Angular2)</h1>
    </div>

    <div class="slds-grid slds-m-top--large">
      <div class="slds-col slds-col-rule--right slds-p-right--large slds-size--4-of-12">
        <div class="slds-box slds-box--small slds-theme--shade">
            <fsprocess-list></fsprocess-list>
        </div>
      </div>
      <div class="slds-col slds-p-left--large slds-size--8-of-12">
        <div class="slds-box slds-box--small">
            <router-outlet></router-outlet>
        </div>
      </div>
    </div>
    `
})

export class AppComponent { }
