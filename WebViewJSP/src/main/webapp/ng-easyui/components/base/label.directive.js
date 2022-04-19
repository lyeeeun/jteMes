/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Directive,ElementRef,Input}from"@angular/core";import{domHelper}from"./domhelper";var LabelDirective=function(){function LabelDirective(hostRef){this.hostRef=hostRef,this.align="left"}LabelDirective_1=LabelDirective,LabelDirective.prototype.ngAfterViewInit=function(){var _this=this;setTimeout(function(){if(_this.target)if(_this.target.hasOwnProperty("inputId")){inputId=_this.initAttributes();_this.target.inputId=inputId}else if(_this.target instanceof Element){var inputId=_this.initAttributes(),att=document.createAttribute("id");att.value=inputId,_this.target.setAttributeNode(att)}})},LabelDirective.prototype.initAttributes=function(){domHelper.addClass(this.hostRef.nativeElement,"textbox-label"),domHelper.addClass(this.hostRef.nativeElement,"textbox-label-"+this.align);var inputId=LabelDirective_1.nextId(),att=document.createAttribute("for");return att.value=inputId,this.hostRef.nativeElement.setAttributeNode(att),inputId},LabelDirective.nextId=function(){return"_input_id_"+LabelDirective_1.index++};var LabelDirective_1;return LabelDirective.index=1,__decorate([Input("for"),__metadata("design:type",Object)],LabelDirective.prototype,"target",void 0),__decorate([Input(),__metadata("design:type",String)],LabelDirective.prototype,"align",void 0),LabelDirective=LabelDirective_1=__decorate([Directive({selector:"[for]"}),__metadata("design:paramtypes",[ElementRef])],LabelDirective)}();export{LabelDirective};