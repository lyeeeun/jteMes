import { LinkButtonComponent } from '../linkbutton/linkbutton.component';
import { MenuComponent } from '../menu/menu.component';
export declare const MENUBUTTON_TEMPLATE = "\n\t<a #btnRef [attr.href]=\"href||'#'\"\n\t\t\t[ngClass]=\"btnCls\"\n\t\t\t[ngStyle]=\"btnStyle\"\n\t\t\t[class]=\"getInnerCls()\" \n\t\t\t(focus)=\"focus()\" \n\t\t\t(blur)=\"blur()\" \n\t\t\t(click)=\"onClick($event)\"\n\t\t\t(click)=\"showMenu()\"\n\t\t\t(mouseenter)=\"onMouseEnter($event)\"\n\t\t\t(mouseleave)=\"onMouseLeave($event)\">\n\t\t<span [class]=\"btnLeftCls\">\n\t\t\t<span #textRef class=\"l-btn-text\" [class.l-btn-empty]=\"!text\"><ng-content></ng-content></span>\n\t\t\t<span [class]=\"btnIconCls\"></span>\n\t\t\t<span class=\"m-btn-downarrow\"></span>\n\t\t\t<span class=\"m-btn-line\"></span>\n\t\t</span>\n\t</a>\n";
export declare class MenuButtonComponent extends LinkButtonComponent {
    menu: MenuComponent;
    menuAlign: string;
    duration: number;
    timer: any;
    getInnerCls(): string;
    onMouseEnter(event: any): void;
    onMouseLeave(event: any): void;
    showMenu(): void;
}
