import { Injectable }     from '@angular/core';
import { Http, Response } from '@angular/http';
import { FSObject }           from './FSObject';
import { Observable }     from 'rxjs/Observable';

// Add the RxJS Observable operators we need in this app.
import '../rxjs-operators';

@Injectable()
export class FSObjectService {
    constructor (private http: Http) {}
    private FSObjectUrl = '/1.0/fs/process';  // URL to web API
    getFSObjects (): Observable<FSObject[]> {
        return this.http.get(this.FSObjectUrl)
            .map(this.extractData)
            .catch(this.handleError);
    }
    getFSObject (id: string): Observable<FSObject> {
        return this.http.get(this.FSObjectUrl+"/"+id)
            .map(this.extractData)
            .catch(this.handleError);
    }
    private extractData(res: Response) {
        let body = res.json();
        console.debug(res.toString());
        console.debug(JSON.stringify(body));
        return body || { };
    }
    private handleError (error: any) {
        // In a real world app, we might use a remote logging infrastructure
        // We'd also dig deeper into the error to get a better message
        let errMsg = (error.message) ? error.message :
            error.status ? `${error.status} - ${error.statusText}` : 'Server error';
        console.error(errMsg); // log to console instead
        return Observable.throw(errMsg);
    }
}
