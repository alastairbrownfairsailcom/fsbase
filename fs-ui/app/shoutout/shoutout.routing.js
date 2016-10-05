"use strict";
var router_1 = require('@angular/router');
var shoutout_process_component_1 = require('./shoutout-process.component');
var shoutout_list_component_1 = require('./shoutout-list.component');
var shoutout_detail_component_1 = require('./shoutout-detail.component');
var shoutout_create_component_1 = require('./shoutout-create.component');
var shoutOutRoutes = [
    {
        path: '',
        component: shoutout_process_component_1.ShoutOutProcessComponent,
        children: [
            {
                path: '',
                component: shoutout_list_component_1.ShoutOutListComponent
            },
            {
                path: 'list',
                component: shoutout_list_component_1.ShoutOutListComponent
            },
            {
                path: 'create',
                component: shoutout_create_component_1.ShoutOutCreateComponent
            },
            {
                path: ':shoutOutId',
                component: shoutout_detail_component_1.ShoutOutDetailComponent
            }
        ]
    },
];
exports.shoutOutRouting = router_1.RouterModule.forChild(shoutOutRoutes);
//# sourceMappingURL=shoutout.routing.js.map