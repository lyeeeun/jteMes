import { ElementRef, EventEmitter } from '@angular/core';
export declare const LINKBUTTON_TEMPLATE = "\n\t<a #btnRef [attr.href]=\"href||'#'\"\n\t\t\t[ngClass]=\"btnCls\"\n\t\t\t[ngStyle]=\"btnStyle\"\n\t\t\t[class]=\"getInnerCls()\" \n\t\t\t(focus)=\"focus()\" \n\t\t\t(blur)=\"blur()\" \n\t\t\t(click)=\"onClick($event)\">\n\t\t<span [class]=\"btnLeftCls\">\n\t\t\t<span #textRef class=\"l-btn-text\" [class.l-btn-empty]=\"!text\"><ng-content></ng-content></span>\n\t\t\t<span [class]=\"btnIconCls\"></span>\n\t\t</span>\n\t</a>\n";
export declare class LinkButtonComponent {
    btnRef: ElementRef;
    textRef: ElementRef;
    disabled: boolean;
    toggle: boolean;
    selected: boolean;
    outline: boolean;
    plain: boolean;
    iconCls: string;
    iconAlign: string;
    size: string;
    href: string;
    btnCls: string;
    btnStyle: Object;
    click: EventEmitter<{}>;
    private _text;
    text: string;
    getInnerCls(): string;
    readonly btnLeftCls: string;
    readonly btnIconCls: string;
    ngAfterViewInit(): void;
    onClick(event: any): boolean;
    private _focused;
    readonly focused: boolean;
    focus(): void;
    blur(): void;
}
