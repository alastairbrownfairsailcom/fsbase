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
var http_1 = require('@angular/http');
var fsprocess_service_1 = require('./fsprocess-service');
var fsobject_service_1 = require('./fsobject-service');
var FSServiceModule = (function () {
    function FSServiceModule() {
    }
    FSServiceModule = __decorate([
        core_1.NgModule({
            imports: [
                http_1.HttpModule,
                http_1.JsonpModule,
                common_1.CommonModule
            ],
            declarations: [],
            exports: [],
            providers: [fsprocess_service_1.FSProcessService, fsobject_service_1.FSObjectService]
        }), 
        __metadata('design:paramtypes', [])
    ], FSServiceModule);
    return FSServiceModule;
}());
exports.FSServiceModule = FSServiceModule;
//# sourceMappingURL=fsservice.module.js.map