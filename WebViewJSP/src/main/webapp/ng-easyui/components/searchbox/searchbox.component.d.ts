import { EventEmitter } from '@angular/core';
import { InputBaseComponent } from '../base/input-base.component';
import { MenuComponent } from '../menu/menu.component';
export declare const SEARCHBOX_TEMPLATE = "\n\t<span class=\"textbox f-inline-row f-full\" \n\t\t\t[ngClass]=\"cls\"\n\t\t\t[class.textbox-disabled]=\"disabled\"\n\t\t\t[class.textbox-readonly]=\"readonly\"\n\t\t\t[class.textbox-focused]=\"focused\"\n\t\t\t[class.textbox-invalid]=\"invalid\">\n\t\t<input #input *ngIf=\"!multiline\" autocomplete=\"off\" class=\"textbox-text f-full f-order3\"\n\t\t\t\t[class.validatebox-invalid]=\"invalid\"\n\t\t\t\t[attr.id]=\"inputId\"\n\t\t\t\t[attr.disabled]=\"disabled?'disabled':null\"\n\t\t\t\t[attr.readonly]=\"(readonly||!editable)?'readonly':null\"\n\t\t\t\t[attr.tabindex]=\"tabindex\"\n\t\t\t\t[ngClass]=\"inputCls\"\n\t\t\t\t[ngStyle]=\"inputStyle\"\n\t\t\t\t[(ngModel)]=\"text\"\n\t\t\t\t[placeholder]=\"placeholder\"\n\t\t\t\t(focus)=\"focus()\"\n\t\t\t\t(blur)=\"blur()\">\n\t\t<textarea #input *ngIf=\"multiline\" autocomplete=\"off\" class=\"textbox-text f-full f-order3\"\n\t\t\t\t[class.validatebox-invalid]=\"invalid\"\n\t\t\t\t[attr.id]=\"inputId\"\n\t\t\t\t[attr.disabled]=\"disabled?'disabled':null\"\n\t\t\t\t[attr.readonly]=\"(readonly||!editable)?'readonly':null\"\n\t\t\t\t[attr.tabindex]=\"tabindex\"\n\t\t\t\t[ngClass]=\"inputCls\"\n\t\t\t\t[ngStyle]=\"inputStyle\"\n\t\t\t\t[(ngModel)]=\"text\"\n\t\t\t\t[placeholder]=\"placeholder\"\n\t\t\t\t(focus)=\"focus()\"\n\t\t\t\t(blur)=\"blur()\"></textarea>\n\t\t<input class=\"textbox-value\" type=\"hidden\" [value]=\"value\" [attr.disabled]=\"disabled?'disabled':null\">\n\t\t<ng-content select=\"eui-addon\"></ng-content>\n\t\t<span *ngIf=\"iconCls\" \n\t\t\t\tclass=\"textbox-addon textbox-addon-icon f-inline-row f-noshrink\" \n\t\t\t\t[class.f-order1]=\"iconAlign=='left'\"\n\t\t\t\t[class.f-order5]=\"iconAlign=='right'\">\n\t\t\t<span class=\"textbox-icon textbox-icon-disabled {{iconCls}}\"></span>\n\t\t</span>\n\t\t<eui-menubutton *ngIf=\"menu\"  class=\"f-noshrink\"\n\t\t\t\t[class.f-order0]=\"menuAlign=='left'\"\n\t\t\t\t[class.f-order7]=\"menuAlign=='right'\"\n\t\t\t\t[text]=\"menuBtnText\"\n\t\t\t\t[iconCls]=\"menuBtnIcon\"\n\t\t\t\t[menu]=\"menu\" \n\t\t\t\t[disabled]=\"disabled\"\n\t\t\t\t[btnCls]=\"menuBtnCls\"></eui-menubutton>\n\t\t<span class=\"textbox-addon f-column f-noshrink\"\n\t\t\t\t[class.f-order0]=\"buttonAlign=='left'\"\n\t\t\t\t[class.f-order6]=\"buttonAlign=='right'\"\n\t\t\t\t(click)=\"doSearch()\">\n\t\t\t<span class=\"textbox-icon f-full\" [ngClass]=\"buttonIconCls\"></span>\n\t\t</span>\n\t</span>\n";
export declare class SearchBoxComponent extends InputBaseComponent<string> {
    menu: MenuComponent;
    menuAlign: string;
    category: any;
    buttonAlign: string;
    buttonIconCls: string;
    search: EventEmitter<{}>;
    text: string;
    readonly menuBtnCls: string;
    cls: string;
    menuBtnText: string;
    menuBtnIcon: string;
    ngAfterContentInit(): void;
    onKeyDown(event: any): void;
    doSearch(): void;
    initMenu(): void;
    setCategory(value: any): void;
}
