import { ElementRef } from '@angular/core';
import { ValueAccessorBase } from '../base/value-accessor-base';
export declare const RADIOBUTTON_TEMPLATE = "\n\t<span class=\"radiobutton f-full\"\n\t\t\t[class.radiobutton-disabled]=\"disabled\"\n\t\t\t[class.radiobutton-checked]=\"checked\"\n\t\t\t(click)=\"onClickButton($event)\">\n\t\t<span *ngIf=\"checked\" class=\"radiobutton-inner\"></span>\n\t</span>\n\t<div class=\"radiobutton-value\">\n\t\t<input #input [attr.id]=\"inputId\" type=\"radio\" [attr.name]=\"name\" [disabled]=\"disabled\" (change)=\"onChange($event)\">\n\t</div>\n";
export declare class RadioButtonComponent extends ValueAccessorBase<any> {
    inputRef: ElementRef;
    name: string;
    disabled: boolean;
    inputId: string;
    readonly checked: any;
    writeValue(value: any): void;
    onClickButton(event: any): void;
    onChange(event: any): void;
    select(): void;
}
