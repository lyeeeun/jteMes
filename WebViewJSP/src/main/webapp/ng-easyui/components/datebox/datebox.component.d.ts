import { EventEmitter } from '@angular/core';
import { CalendarComponent } from '../calendar/calendar.component';
import { ComboBaseComponent } from '../base/combo-base.component';
import { CellTemplateDirective } from '../base/template-base';
export declare const DATEBOX_TEMPLATE = "\n\t<span class=\"textbox f-inline-row f-full\" \n\t\t\t[ngClass]=\"cls\"\n\t\t\t[class.textbox-disabled]=\"disabled\"\n\t\t\t[class.textbox-readonly]=\"readonly\"\n\t\t\t[class.textbox-focused]=\"focused\"\n\t\t\t[class.textbox-invalid]=\"invalid\">\n\t\t<input #input *ngIf=\"!multiline\" autocomplete=\"off\" class=\"textbox-text f-full f-order3\"\n\t\t\t\t[class.validatebox-invalid]=\"invalid\"\n\t\t\t\t[attr.id]=\"inputId\"\n\t\t\t\t[attr.disabled]=\"disabled?'disabled':null\"\n\t\t\t\t[attr.readonly]=\"(readonly||!editable)?'readonly':null\"\n\t\t\t\t[attr.tabindex]=\"tabindex\"\n\t\t\t\t[ngClass]=\"inputCls\"\n\t\t\t\t[ngStyle]=\"inputStyle\"\n\t\t\t\t[(ngModel)]=\"text\"\n\t\t\t\t[placeholder]=\"placeholder\"\n\t\t\t\t(focus)=\"focus()\"\n\t\t\t\t(blur)=\"blur()\">\n\t\t<textarea #input *ngIf=\"multiline\" autocomplete=\"off\" class=\"textbox-text f-full f-order3\"\n\t\t\t\t[class.validatebox-invalid]=\"invalid\"\n\t\t\t\t[attr.id]=\"inputId\"\n\t\t\t\t[attr.disabled]=\"disabled?'disabled':null\"\n\t\t\t\t[attr.readonly]=\"(readonly||!editable)?'readonly':null\"\n\t\t\t\t[attr.tabindex]=\"tabindex\"\n\t\t\t\t[ngClass]=\"inputCls\"\n\t\t\t\t[ngStyle]=\"inputStyle\"\n\t\t\t\t[(ngModel)]=\"text\"\n\t\t\t\t[placeholder]=\"placeholder\"\n\t\t\t\t(focus)=\"focus()\"\n\t\t\t\t(blur)=\"blur()\"></textarea>\n\t\t<ng-content select=\"eui-addon\"></ng-content>\n\t\t<span #addon *ngIf=\"iconCls\" \n\t\t\t\tclass=\"textbox-addon textbox-addon-icon f-inline-row f-noshrink\" \n\t\t\t\t[class.f-order1]=\"iconAlign=='left'\"\n\t\t\t\t[class.f-order5]=\"iconAlign=='right'\">\n\t\t\t<span class=\"textbox-icon textbox-icon-disabled {{iconCls}}\"></span>\n\t\t</span>\n\t\t<span #arrow *ngIf=\"hasDownArrow\" (click)=\"togglePanel()\"\n\t\t\t\tclass=\"textbox-addon f-column f-noshrink\"\n\t\t\t\t[class.f-order0]=\"arrowAlign=='left'\"\n\t\t\t\t[class.f-order6]=\"arrowAlign=='right'\">\n\t\t\t<span class=\"textbox-icon combo-arrow f-full\"></span>\n\t\t</span>\n\t</span>\n\n\t<div #panel *ngIf=\"!panelClosed\" \n\t\t\tclass=\"panel-body panel-body-noheader combo-panel combo-p f-column\"\n\t\t\t[style.left.px]=\"panelLeft\"\n\t\t\t[style.top.px]=\"panelTop\"\n\t\t\t[ngStyle]=\"panelStyle\">\n\t\t<eui-calendar #calendar class=\"f-full\" [border]=\"false\"\n\t\t\t\t[(selection)]=\"selection\"\n\t\t\t\t(selectionChange)=\"onSelectionChange($event)\">\n\t\t\t<ng-template euiCellTemplate let-date>\n\t\t\t\t<ng-container *ngIf=\"!cellTemplate\">{{date.getDate()}}</ng-container>\n\t\t\t\t<ng-template *ngIf=\"cellTemplate\" [euiDateBoxCellTemplate]=\"cellTemplate.template\" [date]=\"date\"></ng-template>\n\t\t\t</ng-template>\n\t\t</eui-calendar>\n\t\t<div class=\"datebox-button f-row\">\n\t\t\t<a href=\"javascript:;\" class=\"datebox-button-a f-full\" (click)=\"selectToday()\">Today</a>\n\t\t\t<a href=\"javascript:;\" class=\"datebox-button-a f-full\" (click)=\"closePanel()\">Close</a>\n\t\t</div>\n\t</div>\n";
export declare class DateBoxComponent extends ComboBaseComponent<Date> {
    calendar: CalendarComponent;
    cellTemplate: CellTemplateDirective;
    selection: Date;
    format: string;
    formatter: Function;
    parser: Function;
    selectionChange: EventEmitter<{}>;
    cls: string;
    timer: any;
    inputingText: string;
    _text: string;
    text: string;
    ngAfterContentInit(): void;
    onKeyDown(event: any): void;
    onDateBoxBlur(): void;
    onSelectionChange(event: any): void;
    doFilter(value: string): void;
    defaultFormatter(date: Date): string;
    defaultParser(value: string): Date;
    openPanel(): void;
    selectToday(): void;
}
