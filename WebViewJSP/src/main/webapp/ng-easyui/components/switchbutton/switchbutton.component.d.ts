import { ValueAccessorBase } from '../base/value-accessor-base';
export declare const SWITCHBUTTON_TEMPLATE = "\n\t<span class=\"switchbutton f-inline-row f-full\"\n\t\t\t[class.switchbutton-readonly]=\"readonly\"\n\t\t\t[class.switchbutton-disabled]=\"disabled\"\n\t\t\t[class.switchbutton-checked]=\"value\" (click)=\"onClick($event)\">\n\t\t<span class=\"switchbutton-inner\">\n\t\t\t<span class=\"switchbutton-on\">\n\t\t\t\t<span class=\"f-row f-content-center\">{{onText}}</span>\n\t\t\t</span>\n\t\t\t<span class=\"switchbutton-handle\">\n\t\t\t\t<span class=\"f-row f-content-center\">{{handleText}}</span>\n\t\t\t</span>\n\t\t\t<span class=\"switchbutton-off\">\n\t\t\t\t<span class=\"f-row f-content-center\">{{offText}}</span>\n\t\t\t</span>\n\t\t\t<input class=\"switchbutton-value\" type=\"checkbox\" [attr.id]=\"inputId\">\n\t\t</span>\n\t</span>\n";
export declare class SwitchButtonComponent extends ValueAccessorBase<boolean> {
    onText: string;
    offText: string;
    handleText: string;
    disabled: boolean;
    readonly: boolean;
    inputId: string;
    protected _value: boolean;
    ngOnInit(): void;
    onClick(event: any): void;
}
