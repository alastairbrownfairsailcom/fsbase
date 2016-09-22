"use strict";
var router_1 = require('@angular/router');
var fsprocess_detail_component_1 = require('./fsprocess/fsprocess-detail.component');
var appRoutes = [
    {
        path: 'fsprocess/:id',
        component: fsprocess_detail_component_1.FSProcessDetailComponent
    }
];
exports.appRoutingProviders = [];
exports.routing = router_1.RouterModule.forRoot(appRoutes);
//# sourceMappingURL=app.routing.js.map