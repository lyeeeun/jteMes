/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Directive,TemplateRef,ViewContainerRef,Input}from"@angular/core";var MessagerBodyTemplateDirective=function(){function MessagerBodyTemplateDirective(viewContainer){this.viewContainer=viewContainer}return MessagerBodyTemplateDirective.prototype.ngOnInit=function(){this.view=this.viewContainer.createEmbeddedView(this.template,{$implicit:this.messager})},MessagerBodyTemplateDirective.prototype.ngOnDestroy=function(){this.view.destroy()},__decorate([Input(),__metadata("design:type",Object)],MessagerBodyTemplateDirective.prototype,"messager",void 0),__decorate([Input("euiMessagerBodyTemplate"),__metadata("design:type",TemplateRef)],MessagerBodyTemplateDirective.prototype,"template",void 0),MessagerBodyTemplateDirective=__decorate([Directive({selector:"[euiMessagerBodyTemplate]"}),__metadata("design:paramtypes",[ViewContainerRef])],MessagerBodyTemplateDirective)}();export{MessagerBodyTemplateDirective};