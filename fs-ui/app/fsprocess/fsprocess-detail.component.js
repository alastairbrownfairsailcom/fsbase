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
var platform_browser_1 = require('@angular/platform-browser');
var router_1 = require('@angular/router');
var fsprocess_service_1 = require('./fsprocess-service');
var shoutout_module_1 = require("../shoutout/shoutout.module");
var common_1 = require('@angular/common');
var ComponentOutlet = (function () {
    function ComponentOutlet(vcRef, compiler) {
        this.vcRef = vcRef;
        this.compiler = compiler;
    }
    ComponentOutlet.prototype.ngOnChanges = function () {
        var _this = this;
        try {
            if (!this.template) {
                console.log('no template');
                return;
            }
            var tmpl = '<' + this.template + '></' + this.template + '>';
            var DynamicComponent_1 = (function () {
                function DynamicComponent_1() {
                }
                __decorate([
                    core_1.Input(), 
                    __metadata('design:type', Object)
                ], DynamicComponent_1.prototype, "data", void 0);
                DynamicComponent_1 = __decorate([
                    core_1.Component({
                        selector: 'dynamic-comp',
                        template: tmpl
                    }), 
                    __metadata('design:paramtypes', [])
                ], DynamicComponent_1);
                return DynamicComponent_1;
            }());
            ;
            var DynamicModule = (function () {
                function DynamicModule() {
                }
                DynamicModule = __decorate([
                    core_1.NgModule({
                        imports: [
                            platform_browser_1.BrowserModule,
                            shoutout_module_1.ShoutOutModule,
                            common_1.CommonModule
                        ],
                        declarations: [DynamicComponent_1]
                    }), 
                    __metadata('design:paramtypes', [])
                ], DynamicModule);
                return DynamicModule;
            }());
            console.log('Loading template ' + tmpl);
            this.compiler.compileModuleAndAllComponentsAsync(DynamicModule)
                .then(function (moduleWithComponentFactories) {
                var compFactory = moduleWithComponentFactories.componentFactories.find(function (x) { return x.componentType === DynamicComponent_1; });
                var injector = core_1.ReflectiveInjector.fromResolvedProviders([], _this.vcRef.parentInjector);
                var cmpRef = _this.vcRef.createComponent(compFactory, 0, injector, []);
                //cmpRef.instance.data = data;
            });
        }
        catch (ex) {
            console.error(ex);
        }
    };
    __decorate([
        core_1.Input('componentOutlet'), 
        __metadata('design:type', String)
    ], ComponentOutlet.prototype, "template", void 0);
    __decorate([
        core_1.Input('componentOutletSelector'), 
        __metadata('design:type', String)
    ], ComponentOutlet.prototype, "selector", void 0);
    __decorate([
        core_1.Input('componentOutletContext'), 
        __metadata('design:type', Object)
    ], ComponentOutlet.prototype, "context", void 0);
    ComponentOutlet = __decorate([
        core_1.Directive({
            selector: '[componentOutlet]',
        }), 
        __metadata('design:paramtypes', [core_1.ViewContainerRef, core_1.Compiler])
    ], ComponentOutlet);
    return ComponentOutlet;
}());
exports.ComponentOutlet = ComponentOutlet;
var FSProcessDetailComponent = (function () {
    function FSProcessDetailComponent(route, router, _fsprocessService) {
        this.route = route;
        this.router = router;
        this._fsprocessService = _fsprocessService;
    }
    FSProcessDetailComponent.prototype.getFSProcess = function (id) {
        var _this = this;
        this._fsprocessService.getFSProcess(id).subscribe(function (fsProcess) {
            _this.fsProcess = fsProcess;
            console.log('Loading component ' + _this.fsProcess.componentName);
            _this.html = _this.fsProcess.componentName;
            //this.html = '<span>Process goes here...</span><div '+this.fsProcess.componentName+'=""></div>';
            // this.html = '<fsprocess-list></fsprocess-list>';
        });
    };
    FSProcessDetailComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.route.params.forEach(function (params) {
            var id = params['id'];
            // lookup id from route
            if (id) {
                _this.getFSProcess(id);
            }
        });
    };
    FSProcessDetailComponent = __decorate([
        core_1.Component({
            selector: 'fsprocess-detail',
            templateUrl: 'app/fsprocess/fsprocess-detail.component.html',
            styleUrls: ['app/fsprocess/fsprocess-detail.component.css'],
            providers: []
        }), 
        __metadata('design:paramtypes', [router_1.ActivatedRoute, router_1.Router, fsprocess_service_1.FSProcessService])
    ], FSProcessDetailComponent);
    return FSProcessDetailComponent;
}());
exports.FSProcessDetailComponent = FSProcessDetailComponent;
//# sourceMappingURL=fsprocess-detail.component.js.map