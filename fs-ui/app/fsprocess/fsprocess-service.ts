import { Injectable }     from '@angular/core';
import { Http, Response } from '@angular/http';
import { FSProcess }           from './fsprocess';
import { Observable }     from 'rxjs/Observable';

// Add the RxJS Observable operators we need in this app.
import '../rxjs-operators';

@Injectable()
export class FSProcessService {
    constructor (private http: Http) {}
    private fsProcessUrl = '/1.0/fs/process';  // URL to web API
    getFSProcesses (): Observable<FSProcess[]> {
        return this.http.get(this.fsProcessUrl)
            .map(this.extractData)
            .catch(this.handleError);
    }
    getFSProcess (id: string): Observable<FSProcess> {
        return this.http.get(this.fsProcessUrl+"/"+id)
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
