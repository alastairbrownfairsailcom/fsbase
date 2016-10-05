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
var ShoutOutDetailComponent = (function () {
    function ShoutOutDetailComponent(_fsObjectService, _router, _route) {
        this._fsObjectService = _fsObjectService;
        this._router = _router;
        this._route = _route;
    }
    ShoutOutDetailComponent.prototype.getShoutOut = function (shoutOutId) {
        var _this = this;
        this._fsObjectService.getFSObject('ShoutOut2', shoutOutId, {}).subscribe(function (shoutOut) { return _this.shoutOut = shoutOut; });
    };
    ShoutOutDetailComponent.prototype.ngOnInit = function () {
        var _this = this;
        this._route.params.forEach(function (params) {
            var shoutOutId = params['shoutOutId'];
            _this.getShoutOut(shoutOutId);
        });
    };
    ShoutOutDetailComponent.prototype.listShoutOuts = function () {
        this._router.navigate(['list'], { relativeTo: this._route.parent });
    };
    ShoutOutDetailComponent = __decorate([
        core_1.Component({
            selector: 'shoutout-detail',
            templateUrl: 'app/shoutout/shoutout-detail.component.html',
            styleUrls: ['app/shoutout/shoutout-detail.component.css'],
            providers: []
        }), 
        __metadata('design:paramtypes', [fsobject_service_1.FSObjectService, router_1.Router, router_1.ActivatedRoute])
    ], ShoutOutDetailComponent);
    return ShoutOutDetailComponent;
}());
exports.ShoutOutDetailComponent = ShoutOutDetailComponent;
//# sourceMappingURL=shoutout-detail.component.js.map