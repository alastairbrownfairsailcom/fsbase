import { ModuleWithProviders }  from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AppComponent } from './app.component';
import { HomeComponent } from './home.component';

/*
const shoutOutRoutes: Routes = [
    {
        path:'shoutout',
        loadChildren: 'app/shoutout/shoutout.module#ShoutOutModule'
    }
];
*/

const appRoutes: Routes = [
    { path: '', component: HomeComponent },
    { path: 'shoutout', loadChildren: 'app/shoutout/shoutout.module#ShoutOutModule' },
/*
    ...shoutOutRoutes
*/
];

export const appRoutingProviders: any[] = [];

export const routing: ModuleWithProviders = RouterModule.forRoot(appRoutes);

