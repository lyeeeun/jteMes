/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __extends=this&&this.__extends||function(){var extendStatics=function(d,b){return(extendStatics=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(d,b){d.__proto__=b}||function(d,b){for(var p in b)b.hasOwnProperty(p)&&(d[p]=b[p])})(d,b)};return function(d,b){function __(){this.constructor=d}extendStatics(d,b),d.prototype=null===b?Object.create(b):(__.prototype=b.prototype,new __)}}(),__decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r};import{Component}from"@angular/core";import{MenuButtonComponent}from"../menubutton/menubutton.component";export var SPLITBUTTON_TEMPLATE='\n\t<a #btnRef [attr.href]="href||\'#\'"\n\t\t\t[ngClass]="btnCls"\n\t\t\t[ngStyle]="btnStyle"\n\t\t\t[class]="getInnerCls()" \n\t\t\t(focus)="focus()" \n\t\t\t(blur)="blur()" \n\t\t\t(click)="onClick($event)">\n\t\t<span [class]="btnLeftCls">\n\t\t\t<span #textRef class="l-btn-text" [class.l-btn-empty]="!text"><ng-content></ng-content></span>\n\t\t\t<span [class]="btnIconCls"></span>\n\t\t\t<span class="m-btn-downarrow"></span>\n\t\t\t<span class="m-btn-line"\n\t\t\t\t\t(click)="showMenu()"\n\t\t\t\t\t(mouseenter)="onMouseEnter($event)"\n\t\t\t\t\t(mouseleave)="onMouseLeave($event)"></span>\n\t\t</span>\n\t</a>\n';var SplitButtonComponent=function(_super){function SplitButtonComponent(){return null!==_super&&_super.apply(this,arguments)||this}return __extends(SplitButtonComponent,_super),SplitButtonComponent.prototype.getInnerCls=function(){var cls=_super.prototype.getInnerCls.call(this);return cls+=" s-btn s-btn-"+this.size,this.menu&&!this.menu.closed&&(cls+=this.plain?" s-btn-plain-active":" s-btn-active"),cls},SplitButtonComponent=__decorate([Component({selector:"eui-splitbutton",template:SPLITBUTTON_TEMPLATE,host:{class:"f-inline-row"}})],SplitButtonComponent)}(MenuButtonComponent);export{SplitButtonComponent};