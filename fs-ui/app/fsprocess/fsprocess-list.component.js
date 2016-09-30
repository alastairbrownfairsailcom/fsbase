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
//import {HeroDetailComponent} from './fsprocess-detail.component';
var fsprocess_service_1 = require('./fsprocess-service');
var FSProcessListComponent = (function () {
    function FSProcessListComponent(_router, _fsprocessService) {
        this._router = _router;
        this._fsprocessService = _fsprocessService;
    }
    FSProcessListComponent.prototype.getFSProcesses = function () {
        var _this = this;
        this._fsprocessService.getFSProcesses().subscribe(function (fsProcesses) { return _this.fsProcesses = fsProcesses; });
    };
    FSProcessListComponent.prototype.ngOnInit = function () {
        this.getFSProcesses();
    };
    FSProcessListComponent.prototype.onSelect = function (fsProcess) {
        this.selectedFSProcess = fsProcess;
        this._router.navigate(['/fsprocess', fsProcess.id]);
    };
    FSProcessListComponent = __decorate([
        core_1.Component({
            selector: 'fsprocess-list',
            templateUrl: 'app/fsprocess/fsprocess-list.component.html',
            styleUrls: ['app/fsprocess/fsprocess-list.component.css'],
            providers: []
        }), 
        __metadata('design:paramtypes', [router_1.Router, fsprocess_service_1.FSProcessService])
    ], FSProcessListComponent);
    return FSProcessListComponent;
})();
exports.FSProcessListComponent = FSProcessListComponent;
//# sourceMappingURL=fsprocess-list.component.js.map