import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent }   from './app.component';
import { FSProcessModule }   from './fsprocess/fsprocess.module';

import { routing } from './app.routing';
import { appRoutingProviders } from './app.routing';

@NgModule({
    imports:      [
        BrowserModule,
        FSProcessModule,
        routing,
        appRoutingProviders
    ],
    declarations: [ AppComponent],
    providers: [appRoutingProviders],
    bootstrap:    [ AppComponent ]
})
export class AppModule { }
