/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,Input}from"@angular/core";var AddonComponent=function(){function AddonComponent(){this.align="right"}return __decorate([Input(),__metadata("design:type",String)],AddonComponent.prototype,"align",void 0),AddonComponent=__decorate([Component({selector:"eui-addon",template:"<ng-content></ng-content>",host:{class:"textbox-addon f-inline-row f-noshrink","[class.f-order2]":"align=='left'","[class.f-order4]":"align=='right'"}})],AddonComponent)}();export{AddonComponent};