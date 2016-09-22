import {
    Component,
    NgModule,
    Directive,
    Compiler,
    Input,
    ReflectiveInjector,
    ViewContainerRef,
    OnInit,
    ApplicationRef
} from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { Router, ActivatedRoute, Params } from '@angular/router';

import {FSProcess} from './fsprocess';
import {FSProcessService} from './fsprocess-service';
import forEach = require("core-js/fn/array/for-each");
import {ShoutOutModule} from "../shoutout/shoutout.module";
import {CommonModule} from '@angular/common';

@Directive({
    selector: '[componentOutlet]',
})
export class ComponentOutlet {
    @Input('componentOutlet') template: string;
    @Input('componentOutletSelector') private selector: string;
    @Input('componentOutletContext') private context: Object;

    constructor(private vcRef: ViewContainerRef, private compiler: Compiler) { }

    ngOnChanges() {
        try {
            if (!this.template) {
                console.log('no template');
                return;
            }

            let tmpl = '<'+this.template+'></'+this.template+'>';

            @Component({
                selector: 'dynamic-comp',
                template: tmpl
            })
            class DynamicComponent  {
                @Input() public data: any;
            };

            @NgModule({
                imports: [
                    BrowserModule,
                    ShoutOutModule,
                    CommonModule
                ],
                declarations: [DynamicComponent]
            })
            class DynamicModule {}

            console.log('Loading template ' + tmpl);

            this.compiler.compileModuleAndAllComponentsAsync(DynamicModule)
                .then(moduleWithComponentFactories => {
                    const compFactory = moduleWithComponentFactories.componentFactories.find(x => x.componentType === DynamicComponent);
                    const injector = ReflectiveInjector.fromResolvedProviders([], this.vcRef.parentInjector);
                    const cmpRef = this.vcRef.createComponent(compFactory, 0, injector, []);
                    //cmpRef.instance.data = data;
                });
        } catch (ex) {
            console.error(ex);
        }

    }
}


@Component({
    selector: 'fsprocess-detail',
    templateUrl:'app/fsprocess/fsprocess-detail.component.html',
    styleUrls:['app/fsprocess/fsprocess-detail.component.css'],
    providers: []
})

export class FSProcessDetailComponent implements OnInit {
    fsProcess: FSProcess;
    html: string;
    constructor(
        private route: ActivatedRoute,
        private router: Router,
        private _fsprocessService: FSProcessService
        ) { }
    getFSProcess(id: string) {
        this._fsprocessService.getFSProcess(id).subscribe(fsProcess => {
            this.fsProcess = fsProcess;
            console.log('Loading component ' + this.fsProcess.componentName);

            this.html = this.fsProcess.componentName;
            //this.html = '<span>Process goes here...</span><div '+this.fsProcess.componentName+'=""></div>';
            // this.html = '<fsprocess-list></fsprocess-list>';
        });
    }

    ngOnInit() {
        this.route.params.forEach((params: Params) => {
            let id = params['id'];

            // lookup id from route
            if (id) {
                this.getFSProcess(id);
            }
        });
    }
}
