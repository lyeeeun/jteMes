import { MenuButtonComponent } from '../menubutton/menubutton.component';
export declare const SPLITBUTTON_TEMPLATE = "\n\t<a #btnRef [attr.href]=\"href||'#'\"\n\t\t\t[ngClass]=\"btnCls\"\n\t\t\t[ngStyle]=\"btnStyle\"\n\t\t\t[class]=\"getInnerCls()\" \n\t\t\t(focus)=\"focus()\" \n\t\t\t(blur)=\"blur()\" \n\t\t\t(click)=\"onClick($event)\">\n\t\t<span [class]=\"btnLeftCls\">\n\t\t\t<span #textRef class=\"l-btn-text\" [class.l-btn-empty]=\"!text\"><ng-content></ng-content></span>\n\t\t\t<span [class]=\"btnIconCls\"></span>\n\t\t\t<span class=\"m-btn-downarrow\"></span>\n\t\t\t<span class=\"m-btn-line\"\n\t\t\t\t\t(click)=\"showMenu()\"\n\t\t\t\t\t(mouseenter)=\"onMouseEnter($event)\"\n\t\t\t\t\t(mouseleave)=\"onMouseLeave($event)\"></span>\n\t\t</span>\n\t</a>\n";
export declare class SplitButtonComponent extends MenuButtonComponent {
    getInnerCls(): string;
}
