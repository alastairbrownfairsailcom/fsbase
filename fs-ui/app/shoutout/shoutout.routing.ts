import { ModuleWithProviders }   from '@angular/core';
import { Routes, RouterModule }  from '@angular/router';
import { ShoutOutProcessComponent }    from './shoutout-process.component';
import { ShoutOutListComponent }    from './shoutout-list.component';
import { ShoutOutDetailComponent }    from './shoutout-detail.component';
import { ShoutOutCreateComponent }    from './shoutout-create.component';

const shoutOutRoutes: Routes = [
    {
        path: '',
        component: ShoutOutProcessComponent,
        children: [
            {
                path: '',
                component: ShoutOutListComponent
            },
            {
                path: 'list',
                component: ShoutOutListComponent
            },
            {
                path: 'create',
                component: ShoutOutCreateComponent
            },
            {
                path: ':shoutOutId',
                component: ShoutOutDetailComponent
            }
        ]
    },
];
export const shoutOutRouting: ModuleWithProviders = RouterModule.forChild(shoutOutRoutes);
