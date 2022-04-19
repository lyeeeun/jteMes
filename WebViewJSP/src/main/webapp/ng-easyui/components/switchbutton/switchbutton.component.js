/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __extends=this&&this.__extends||function(){var extendStatics=function(d,b){return(extendStatics=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(d,b){d.__proto__=b}||function(d,b){for(var p in b)b.hasOwnProperty(p)&&(d[p]=b[p])})(d,b)};return function(d,b){function __(){this.constructor=d}extendStatics(d,b),d.prototype=null===b?Object.create(b):(__.prototype=b.prototype,new __)}}(),__decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,forwardRef,Input}from"@angular/core";import{NG_VALUE_ACCESSOR}from"@angular/forms";import{ValueAccessorBase}from"../base/value-accessor-base";export var SWITCHBUTTON_TEMPLATE='\n\t<span class="switchbutton f-inline-row f-full"\n\t\t\t[class.switchbutton-readonly]="readonly"\n\t\t\t[class.switchbutton-disabled]="disabled"\n\t\t\t[class.switchbutton-checked]="value" (click)="onClick($event)">\n\t\t<span class="switchbutton-inner">\n\t\t\t<span class="switchbutton-on">\n\t\t\t\t<span class="f-row f-content-center">{{onText}}</span>\n\t\t\t</span>\n\t\t\t<span class="switchbutton-handle">\n\t\t\t\t<span class="f-row f-content-center">{{handleText}}</span>\n\t\t\t</span>\n\t\t\t<span class="switchbutton-off">\n\t\t\t\t<span class="f-row f-content-center">{{offText}}</span>\n\t\t\t</span>\n\t\t\t<input class="switchbutton-value" type="checkbox" [attr.id]="inputId">\n\t\t</span>\n\t</span>\n';var SwitchButtonComponent=function(_super){function SwitchButtonComponent(){var _this=null!==_super&&_super.apply(this,arguments)||this;return _this.onText="ON",_this.offText="OFF",_this.handleText=null,_this.disabled=!1,_this.readonly=!1,_this.inputId=null,_this._value=!1,_this}__extends(SwitchButtonComponent,_super),SwitchButtonComponent_1=SwitchButtonComponent,SwitchButtonComponent.prototype.ngOnInit=function(){var _this=this;setTimeout(function(){_this._initialized=!0})},SwitchButtonComponent.prototype.onClick=function(event){event.stopPropagation(),this.disabled||this.readonly||(this.value=!this.value)};var SwitchButtonComponent_1;return __decorate([Input(),__metadata("design:type",String)],SwitchButtonComponent.prototype,"onText",void 0),__decorate([Input(),__metadata("design:type",String)],SwitchButtonComponent.prototype,"offText",void 0),__decorate([Input(),__metadata("design:type",String)],SwitchButtonComponent.prototype,"handleText",void 0),__decorate([Input(),__metadata("design:type",Boolean)],SwitchButtonComponent.prototype,"disabled",void 0),__decorate([Input(),__metadata("design:type",Boolean)],SwitchButtonComponent.prototype,"readonly",void 0),__decorate([Input(),__metadata("design:type",String)],SwitchButtonComponent.prototype,"inputId",void 0),SwitchButtonComponent=SwitchButtonComponent_1=__decorate([Component({selector:"eui-switchbutton",template:SWITCHBUTTON_TEMPLATE,providers:[{provide:NG_VALUE_ACCESSOR,useExisting:forwardRef(function(){return SwitchButtonComponent_1}),multi:!0}],host:{"[class.f-inline-row]":"true"}})],SwitchButtonComponent)}(ValueAccessorBase);export{SwitchButtonComponent};