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
var fsobject_service_1 = require('../fsservice/fsobject-service');
var fsprocess_service_1 = require('../fsservice/fsprocess-service');
var ShoutOutCreateComponent = (function () {
    function ShoutOutCreateComponent(_fsProcessService, _fsObjectService, _router, _route) {
        this._fsProcessService = _fsProcessService;
        this._fsObjectService = _fsObjectService;
        this._router = _router;
        this._route = _route;
        this.shoutOut = {};
    }
    ShoutOutCreateComponent.prototype.getFSProcess = function (procesId) {
        var _this = this;
        this._fsProcessService.getFSProcess(procesId).subscribe(function (fsProcess) {
            _this.fsProcess = fsProcess;
            _this.reasons = fsProcess.objects[0].fields[0].options;
        });
    };
    ShoutOutCreateComponent.prototype.getUsers = function (processId) {
        var _this = this;
        this._fsObjectService.getFSLookups('User', 'ShoutOut2', { 'processId': processId }).subscribe(function (receivers) { return _this.receivers = receivers; });
    };
    ShoutOutCreateComponent.prototype.getOpportunities = function (processId) {
        var _this = this;
        this._fsObjectService.getFSLookups('Opportunity', 'ShoutOut2', { 'processId': processId }).subscribe(function (opportunities) { return _this.opportunities = opportunities; });
    };
    ShoutOutCreateComponent.prototype.ngOnInit = function () {
        var _this = this;
        this._route.parent.params.forEach(function (params) {
            var processId = params['processId'];
            _this.getFSProcess(processId);
            _this.getUsers(processId);
            _this.getOpportunities(processId);
        });
    };
    ShoutOutCreateComponent.prototype.onSubmit = function () {
        var _this = this;
        this._fsObjectService.createFSObject('ShoutOut2', {}, this.shoutOut).subscribe(function (shoutOut) {
            _this.shoutOut = {};
            _this.cancel();
        });
    };
    ShoutOutCreateComponent.prototype.cancel = function () {
        this._router.navigate(['list'], { relativeTo: this._route.parent });
    };
    ShoutOutCreateComponent = __decorate([
        core_1.Component({
            selector: 'shoutout-create',
            templateUrl: 'app/shoutout/shoutout-create.component.html',
            styleUrls: ['app/shoutout/shoutout-create.component.css'],
            providers: []
        }), 
        __metadata('design:paramtypes', [fsprocess_service_1.FSProcessService, fsobject_service_1.FSObjectService, router_1.Router, router_1.ActivatedRoute])
    ], ShoutOutCreateComponent);
    return ShoutOutCreateComponent;
}());
exports.ShoutOutCreateComponent = ShoutOutCreateComponent;
//# sourceMappingURL=shoutout-create.component.js.map