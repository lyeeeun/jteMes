import { Subject } from 'rxjs';
export declare class MessagerService {
    alertSubject: Subject<{}>;
    confirmSubject: Subject<{}>;
    promptSubject: Subject<{}>;
    alert(options: any): void;
    confirm(options: any): void;
    prompt(options: any): void;
}
