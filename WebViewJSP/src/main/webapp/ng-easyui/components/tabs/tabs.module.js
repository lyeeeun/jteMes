/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r};import{NgModule}from"@angular/core";import{CommonModule}from"@angular/common";import{BaseModule}from"../base/base.module";import{TabsComponent}from"./tabs.component";import{TabPanelComponent}from"./tab-panel.component";import{TabHeaderTemplateDirective}from"./tab-headertemplate.directive";var TabsModule=function(){function TabsModule(){}return TabsModule=__decorate([NgModule({declarations:[TabsComponent,TabPanelComponent,TabHeaderTemplateDirective],imports:[CommonModule,BaseModule],exports:[TabsComponent,TabPanelComponent,TabHeaderTemplateDirective]})],TabsModule)}();export{TabsModule};