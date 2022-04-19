import { EventEmitter, ElementRef } from '@angular/core';
import { LinkButtonComponent } from '../linkbutton/linkbutton.component';
export declare const FILEBUTTON_TEMPLATE = "\n\t<a #btnRef href=\"javascript:;\"\n\t\t\t[ngClass]=\"btnCls\"\n\t\t\t[ngStyle]=\"btnStyle\"\n\t\t\t[class]=\"getInnerCls()\" \n\t\t\t(focus)=\"focus()\" \n\t\t\t(blur)=\"blur()\" \n\t\t\t(click)=\"onClick($event)\">\n\t\t<span [class]=\"btnLeftCls\">\n\t\t\t<span #textRef class=\"l-btn-text\" [class.l-btn-empty]=\"!text\"><ng-content></ng-content></span>\n\t\t\t<span [class]=\"btnIconCls\"></span>\n\t\t</span>\n\t\t<label class=\"filebox-label\" [attr.for]=\"fileId\">\n\t\t\t<input #file type=\"file\" style=\"position:absolute;left:-500000px\"\n\t\t\t\t\t[attr.id]=\"fileId\"\n\t\t\t\t\t[attr.disabled]=\"disabled?'disabled':null\"\n\t\t\t\t\t[attr.multiple]=\"multiple?'multiple':null\"\n\t\t\t\t\t[attr.accept]=\"accept\"\n\t\t\t\t\t[attr.capture]=\"capture\"\n\t\t\t\t\t(change)=\"onFileSelect($event)\">\n\t\t</label>\n\t</a>\n";
export declare class FileButtonComponent extends LinkButtonComponent {
    fileRef: ElementRef;
    href: string;
    fileId: string;
    name: string;
    accept: string;
    capture: string;
    multiple: boolean;
    url: string;
    method: string;
    autoUpload: boolean;
    withCredentials: boolean;
    select: EventEmitter<{}>;
    progress: EventEmitter<{}>;
    success: EventEmitter<{}>;
    error: EventEmitter<{}>;
    files: File[];
    onFileSelect(event: any): void;
    upload(): void;
    clear(): void;
    static fileId: number;
}
