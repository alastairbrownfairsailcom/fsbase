"use strict";
var router_1 = require('@angular/router');
var home_component_1 = require('./home.component');
/*
const shoutOutRoutes: Routes = [
    {
        path:'shoutout',
        loadChildren: 'app/shoutout/shoutout.module#ShoutOutModule'
    }
];
*/
var appRoutes = [
    { path: '', component: home_component_1.HomeComponent },
    { path: 'shoutout', loadChildren: 'app/shoutout/shoutout.module#ShoutOutModule' },
];
exports.appRoutingProviders = [];
exports.routing = router_1.RouterModule.forRoot(appRoutes);
//# sourceMappingURL=app.routing.js.map