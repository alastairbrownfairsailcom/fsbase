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
            var template = this.template;
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
                        template: template
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
                        imports: [platform_browser_1.BrowserModule],
                        declarations: [DynamicComponent_1]
                    }), 
                    __metadata('design:paramtypes', [])
                ], DynamicModule);
                return DynamicModule;
            }());
            console.log('Loading template ' + template);
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
//# sourceMappingURL=componentoutlet-directive.js.map