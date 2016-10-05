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
var router_1 = require('@angular/router');
var fsprocess_service_1 = require('../fsservice/fsprocess-service');
var ShoutOutProcessComponent = (function () {
    function ShoutOutProcessComponent(_fsprocessService, _route, _router) {
        this._fsprocessService = _fsprocessService;
        this._route = _route;
        this._router = _router;
        this.ok = false;
    }
    ShoutOutProcessComponent.prototype.ngOnInit = function () {
        var _this = this;
        console.log('Starting ShoutOutProcessComponent');
        this._route.params.forEach(function (params) {
            _this.getFSProcess(params['processId']);
        });
    };
    ShoutOutProcessComponent.prototype.getFSProcess = function (id) {
        var _this = this;
        this._fsprocessService.getFSProcess(id).subscribe(function (fsProcess) {
            _this.fsProcess = fsProcess;
            console.log('Loading component ' + _this.fsProcess.componentName);
            _this.html = _this.fsProcess.componentName;
        });
    };
    ShoutOutProcessComponent = __decorate([
        core_1.Component({
            selector: 'shoutout-process',
            templateUrl: 'app/shoutout/shoutout-process.component.html',
            styleUrls: ['app/shoutout/shoutout-process.component.css'],
            providers: []
        }), 
        __metadata('design:paramtypes', [fsprocess_service_1.FSProcessService, router_1.ActivatedRoute, router_1.Router])
    ], ShoutOutProcessComponent);
    return ShoutOutProcessComponent;
}());
exports.ShoutOutProcessComponent = ShoutOutProcessComponent;
//# sourceMappingURL=shoutout-process.component.js.map