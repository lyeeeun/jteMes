/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,Input,ContentChildren,QueryList,ViewChild,ElementRef}from"@angular/core";import{PanelHeaderComponent}from"./panel-header.component";import{PanelFooterComponent}from"./panel-footer.component";export var PANEL_INNER_TEMPLATE='\n\t<div #pheader *ngIf="hasHeader"\n\t\t\tclass="panel-header f-noshrink"\n\t\t\t[class.panel-header-noborder]="!border"\n\t\t\t[ngClass]="headerCls"\n\t\t\t[ngStyle]="headerStyle">\n\t\t<ng-content select="eui-panel-header,eui-dialog-header"></ng-content>\n\t\t<div *ngIf="!headers.length" class="panel-title" [class.panel-with-icon]="iconCls">{{title}}</div>\n\t\t<div *ngIf="iconCls" class="panel-icon {{iconCls}}"></div>\n\t\t<div class="panel-tool" *ngIf="collapsible || closable">\n\t\t\t<a *ngIf="collapsible" href="javascript:;" [ngClass]="collapsed?expandIconCls:collapseIconCls" (click)="onClickCollapsibleTool($event)"></a>\n\t\t\t<a *ngIf="closable" href="javascript:;" [ngClass]="closeIconCls" (click)="onClickCloseTool($event)"></a>\n\t\t</div>\n\t</div>\n\t<div #pbody euiSlideUpDown [collapsed]="collapsed" [animate]="animate" [disabled]="!collapseToShrinkBody"\n\t\t\tclass="panel-body f-full" \n\t\t\t[class.panel-body-noheader]="!hasHeader" \n\t\t\t[class.panel-body-nobottom]="footers.length" \n\t\t\t[class.panel-body-noborder]="!border" \n\t\t\t[ngClass]="bodyCls"\n\t\t\t[ngStyle]="bodyStyle">\n\t\t<ng-content></ng-content>\n\t</div>\n\t<div #pfooter *ngIf="hasFooter" \n\t\t\tclass="panel-footer" \n\t\t\t[class.panel-footer-noborder]="!border"\n\t\t\t[ngClass]="footerCls"\n\t\t\t[ngStyle]="footerStyle">\n\t\t<ng-content select="eui-panel-footer,eui-dialog-footer"></ng-content>\n\t</div>\n';export var PANEL_TEMPLATE='\n\t<div #panel *ngIf="!closed" class="panel f-column f-full" [ngClass]="panelCls" [ngStyle]="panelStyle">\n'+PANEL_INNER_TEMPLATE+"\n\t</div>\n";var PanelComponent=function(){function PanelComponent(hostRef){this.hostRef=hostRef,this.title=null,this.iconCls=null,this.border=!0,this.animate=!1,this.closed=!1,this.collapsed=!1,this.collapsible=!1,this.closable=!1,this.showHeader=!0,this.showFooter=!0,this.expandIconCls="panel-tool-expand",this.collapseIconCls="panel-tool-collapse",this.closeIconCls="panel-tool-close",this.panelCls=null,this.panelStyle=null,this.headerCls=null,this.headerStyle=null,this.bodyCls=null,this.bodyStyle=null,this.footerCls=null,this.footerStyle=null,this.collapseToShrinkBody=!0}return Object.defineProperty(PanelComponent.prototype,"hasHeader",{get:function(){return!!this.showHeader&&!!(this.headers&&this.headers.length||null!=this.title)},enumerable:!0,configurable:!0}),Object.defineProperty(PanelComponent.prototype,"hasFooter",{get:function(){return!!this.showFooter&&!(!this.footers||!this.footers.length)},enumerable:!0,configurable:!0}),PanelComponent.prototype.onClickCollapsibleTool=function(event){this.collapsed=!this.collapsed,event.preventDefault()},PanelComponent.prototype.onClickCloseTool=function(event){this.closed=!0,event.preventDefault()},__decorate([ViewChild("panel"),__metadata("design:type",ElementRef)],PanelComponent.prototype,"panelRef",void 0),__decorate([ViewChild("pheader"),__metadata("design:type",ElementRef)],PanelComponent.prototype,"headerRef",void 0),__decorate([ViewChild("pbody"),__metadata("design:type",ElementRef)],PanelComponent.prototype,"bodyRef",void 0),__decorate([ViewChild("pfooter"),__metadata("design:type",ElementRef)],PanelComponent.prototype,"footerRef",void 0),__decorate([ContentChildren(PanelHeaderComponent),__metadata("design:type",QueryList)],PanelComponent.prototype,"headers",void 0),__decorate([ContentChildren(PanelFooterComponent),__metadata("design:type",QueryList)],PanelComponent.prototype,"footers",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"title",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"iconCls",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PanelComponent.prototype,"border",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PanelComponent.prototype,"animate",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PanelComponent.prototype,"closed",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PanelComponent.prototype,"collapsed",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PanelComponent.prototype,"collapsible",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PanelComponent.prototype,"closable",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PanelComponent.prototype,"showHeader",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PanelComponent.prototype,"showFooter",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"expandIconCls",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"collapseIconCls",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"closeIconCls",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"panelCls",void 0),__decorate([Input(),__metadata("design:type",Object)],PanelComponent.prototype,"panelStyle",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"headerCls",void 0),__decorate([Input(),__metadata("design:type",Object)],PanelComponent.prototype,"headerStyle",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"bodyCls",void 0),__decorate([Input(),__metadata("design:type",Object)],PanelComponent.prototype,"bodyStyle",void 0),__decorate([Input(),__metadata("design:type",String)],PanelComponent.prototype,"footerCls",void 0),__decorate([Input(),__metadata("design:type",Object)],PanelComponent.prototype,"footerStyle",void 0),PanelComponent=__decorate([Component({selector:"eui-panel",template:PANEL_TEMPLATE,host:{class:"f-column"}}),__metadata("design:paramtypes",[ElementRef])],PanelComponent)}();export{PanelComponent};