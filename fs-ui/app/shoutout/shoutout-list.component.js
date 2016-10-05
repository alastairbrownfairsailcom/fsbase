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
var ShoutOutListComponent = (function () {
    function ShoutOutListComponent(_router, _route, _fsObjectService) {
        this._router = _router;
        this._route = _route;
        this._fsObjectService = _fsObjectService;
    }
    ShoutOutListComponent.prototype.getShoutOuts = function () {
        var _this = this;
        this._fsObjectService.getFSObjects('ShoutOut2', { given: 'true' }).subscribe(function (shoutOuts) { return _this.givenShoutOuts = shoutOuts; });
        this._fsObjectService.getFSObjects('ShoutOut2', {}).subscribe(function (shoutOuts) { return _this.receivedShoutOuts = shoutOuts; });
    };
    ShoutOutListComponent.prototype.ngOnInit = function () {
        this.getShoutOuts();
    };
    ShoutOutListComponent.prototype.selectShoutOut = function (shoutOut) {
        this._router.navigate([shoutOut.id], { relativeTo: this._route.parent });
    };
    ShoutOutListComponent.prototype.createShoutOut = function () {
        this._router.navigate(['create'], { relativeTo: this._route.parent });
    };
    ShoutOutListComponent = __decorate([
        core_1.Component({
            selector: 'shoutout-list',
            templateUrl: 'app/shoutout/shoutout-list.component.html',
            styleUrls: ['app/shoutout/shoutout-list.component.css'],
            providers: []
        }), 
        __metadata('design:paramtypes', [router_1.Router, router_1.ActivatedRoute, fsobject_service_1.FSObjectService])
    ], ShoutOutListComponent);
    return ShoutOutListComponent;
}());
exports.ShoutOutListComponent = ShoutOutListComponent;
//# sourceMappingURL=shoutout-list.component.js.map