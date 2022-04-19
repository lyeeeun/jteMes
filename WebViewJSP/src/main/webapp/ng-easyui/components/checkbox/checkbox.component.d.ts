import { ElementRef, EventEmitter } from '@angular/core';
import { ValueAccessorBase } from '../base/value-accessor-base';
export declare const CHECKBOX_TEMPLATE = "\n\t<span class=\"checkbox f-full\"\n\t\t\t[class.checkbox-disabled]=\"disabled\"\n\t\t\t[class.checkbox-checked]=\"checked\"\n\t\t\t(click)=\"onClickButton($event)\">\n\t\t<svg class=\"checkbox-inner\" *ngIf=\"checked\" xml:space=\"preserve\" focusable=\"false\" version=\"1.1\" viewBox=\"0 0 24 24\"><path d=\"M4.1,12.7 9,17.6 20.3,6.3\" fill=\"none\" stroke=\"white\"></path></svg>\n\t</span>\n\t<div class=\"checkbox-value\">\n\t\t<input #input [attr.id]=\"inputId\" type=\"checkbox\" [attr.name]=\"name\" [disabled]=\"disabled\" (change)=\"onChange($event)\">\n\t</div>\n";
export declare class CheckboxComponent extends ValueAccessorBase<any> {
    inputRef: ElementRef;
    name: string;
    disabled: boolean;
    inputId: string;
    multiple: boolean;
    checked: boolean;
    checkedChange: EventEmitter<{}>;
    values: any[];
    writeValue(value: any): void;
    onClickButton(event: any): void;
    onChange(event: any): void;
    updateValues(): void;
}
