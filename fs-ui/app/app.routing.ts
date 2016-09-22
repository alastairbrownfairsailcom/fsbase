import { ModuleWithProviders }  from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { FSProcessDetailComponent }      from './fsprocess/fsprocess-detail.component';

const appRoutes: Routes = [
    {
        path: 'fsprocess/:id',
        component: FSProcessDetailComponent
    }

];

export const appRoutingProviders: any[] = [];

export const routing: ModuleWithProviders = RouterModule.forRoot(appRoutes);

