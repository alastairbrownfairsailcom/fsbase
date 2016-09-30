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
var http_1 = require('@angular/http');
var Observable_1 = require('rxjs/Observable');
// Add the RxJS Observable operators we need in this app.
require('../rxjs-operators');
var FSObjectService = (function () {
    function FSObjectService(http) {
        this.http = http;
        this.FSObjectUrl = '/1.0/fs/object'; // URL to web API
    }
    FSObjectService.prototype.getFSObjects = function (objectType, params) {
        var url = this.FSObjectUrl + "/" + objectType + "/";
        var first = true;
        for (var key in params) {
            console.log('Type: ' + typeof key);
            console.log(key + ' => ' + params[key]);
            if (first) {
                first = false;
                url += '?';
            }
            else {
                url += '&';
            }
            url += key + '=' + params[key];
        }
        return this.http.get(url)
            .map(this.extractData)
            .catch(this.handleError);
    };
    FSObjectService.prototype.getFSObject = function (objectType, id, params) {
        var url = this.FSObjectUrl + "/" + objectType + "/" + id;
        var first = true;
        for (var key in params) {
            console.log('Type: ' + typeof key);
            console.log(key + ' => ' + params[key]);
            if (first) {
                first = false;
                url += '?';
            }
            else {
                url += '&';
            }
            url += key + '=' + params[key];
        }
        return this.http.get(url)
            .map(this.extractData)
            .catch(this.handleError);
    };
    FSObjectService.prototype.extractData = function (res) {
        var body = res.json();
        console.debug(res.toString());
        console.debug(JSON.stringify(body));
        return body || {};
    };
    FSObjectService.prototype.handleError = function (error) {
        // In a real world app, we might use a remote logging infrastructure
        // We'd also dig deeper into the error to get a better message
        var errMsg = (error.message) ? error.message :
            error.status ? error.status + " - " + error.statusText : 'Server error';
        console.error(errMsg); // log to console instead
        return Observable_1.Observable.throw(errMsg);
    };
    FSObjectService = __decorate([
        core_1.Injectable(), 
        __metadata('design:paramtypes', [http_1.Http])
    ], FSObjectService);
    return FSObjectService;
})();
exports.FSObjectService = FSObjectService;
//# sourceMappingURL=fsobject-service.js.map