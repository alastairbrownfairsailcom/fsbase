"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var core_1 = require('@angular/core');
var AppComponent = (function () {
    function AppComponent() {
    }
    AppComponent = __decorate([
        core_1.Component({
            selector: 'my-app',
            template: "\n\t<div class=\"slds-page-header\">\n        <h1 class=\"slds-text-heading--large\">FS Framework (Angular2)</h1>\n    </div>\n\n    <div class=\"slds-grid slds-m-top--large\">\n      <div class=\"slds-col slds-col-rule--right slds-p-right--large slds-size--4-of-12\">\n        <div class=\"slds-box slds-box--small slds-theme--shade\">\n            <fsprocess-list></fsprocess-list>\n        </div>\n      </div>\n      <div class=\"slds-col slds-p-left--large slds-size--8-of-12\">\n        <div class=\"slds-box slds-box--small\">\n            <router-outlet></router-outlet>\n        </div>\n      </div>\n    </div>\n    "
        }), 
        __metadata('design:paramtypes', [])
    ], AppComponent);
    return AppComponent;
}());
exports.AppComponent = AppComponent;
//# sourceMappingURL=app.component.js.map