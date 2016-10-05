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
var common_1 = require('@angular/common');
var shoutout_process_component_1 = require('./shoutout-process.component');
var shoutout_list_component_1 = require('./shoutout-list.component');
var shoutout_detail_component_1 = require('./shoutout-detail.component');
var shoutout_create_component_1 = require('./shoutout-create.component');
var fsservice_module_1 = require('../fsservice/fsservice.module');
var shoutout_routing_1 = require('./shoutout.routing');
var forms_1 = require('@angular/forms');
var ShoutOutModule = (function () {
    function ShoutOutModule() {
    }
    ShoutOutModule = __decorate([
        core_1.NgModule({
            imports: [
                common_1.CommonModule,
                fsservice_module_1.FSServiceModule,
                shoutout_routing_1.shoutOutRouting,
                forms_1.FormsModule
            ],
            declarations: [shoutout_process_component_1.ShoutOutProcessComponent, shoutout_list_component_1.ShoutOutListComponent, shoutout_detail_component_1.ShoutOutDetailComponent, shoutout_create_component_1.ShoutOutCreateComponent],
            exports: [shoutout_process_component_1.ShoutOutProcessComponent, shoutout_list_component_1.ShoutOutListComponent, shoutout_detail_component_1.ShoutOutDetailComponent, shoutout_create_component_1.ShoutOutCreateComponent],
            providers: []
        }), 
        __metadata('design:paramtypes', [])
    ], ShoutOutModule);
    return ShoutOutModule;
}());
exports.ShoutOutModule = ShoutOutModule;
//# sourceMappingURL=shoutout.module.js.map