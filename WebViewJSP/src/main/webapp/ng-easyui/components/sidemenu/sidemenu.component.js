/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,Input,Output,EventEmitter,QueryList,ViewChildren}from"@angular/core";import{treeHelper}from"../base/treehelper";import{TooltipContentComponent}from"../tooltip/tooltip-content.component";var SideMenuComponent=function(){function SideMenuComponent(){this.collapsed=!1,this.border=!0,this.animate=!0,this.multiple=!0,this.floatMenuWidth=200,this.floatMenuPosition="right",this.selection=null,this.itemClick=new EventEmitter,this.selectionChange=new EventEmitter,this._data=null}return Object.defineProperty(SideMenuComponent.prototype,"data",{get:function(){return this._data},set:function(value){this._data=value,treeHelper.forNodes(this._data,function(node){node.iconCls||(node.iconCls="sidemenu-default-icon"),node.children&&(node.nodeCls="tree-node-nonleaf",node.state||(node.state="closed"),"open"==node.state?node.nodeCls="tree-node-nonleaf":node.nodeCls="tree-node-nonleaf tree-node-nonleaf-collapsed")})},enumerable:!0,configurable:!0}),SideMenuComponent.prototype.onSelectionChange=function(node){this.selection=node,this.selectionChange.emit(this.selection)},SideMenuComponent.prototype.onNodeClick=function(node){node.children?(node.state="closed"==node.state?"open":"closed","open"==node.state?node.nodeCls="tree-node-nonleaf":node.nodeCls="tree-node-nonleaf tree-node-nonleaf-collapsed"):(this.itemClick.emit(node),this.tipContents.forEach(function(tc){return tc.hide()}))},__decorate([ViewChildren(TooltipContentComponent),__metadata("design:type",QueryList)],SideMenuComponent.prototype,"tipContents",void 0),__decorate([Input(),__metadata("design:type",Boolean)],SideMenuComponent.prototype,"collapsed",void 0),__decorate([Input(),__metadata("design:type",Boolean)],SideMenuComponent.prototype,"border",void 0),__decorate([Input(),__metadata("design:type",Boolean)],SideMenuComponent.prototype,"animate",void 0),__decorate([Input(),__metadata("design:type",Boolean)],SideMenuComponent.prototype,"multiple",void 0),__decorate([Input(),__metadata("design:type",Number)],SideMenuComponent.prototype,"floatMenuWidth",void 0),__decorate([Input(),__metadata("design:type",String)],SideMenuComponent.prototype,"floatMenuPosition",void 0),__decorate([Input(),__metadata("design:type",Object)],SideMenuComponent.prototype,"selection",void 0),__decorate([Output(),__metadata("design:type",Object)],SideMenuComponent.prototype,"itemClick",void 0),__decorate([Output(),__metadata("design:type",Object)],SideMenuComponent.prototype,"selectionChange",void 0),__decorate([Input(),__metadata("design:type",Object),__metadata("design:paramtypes",[Object])],SideMenuComponent.prototype,"data",null),SideMenuComponent=__decorate([Component({selector:"eui-sidemenu",template:'\n        <div *ngIf="collapsed" class="sidemenu sidemenu-collapsed f-full">\n            <div class="accordion" [class.accordion-noborder]="!border">\n                <ng-container *ngFor="let menu of data">\n                <div class="panel-header accordion-header" \n                        [euiTooltip]="tc" \n                        tooltipCls="sidemenu-tooltip"\n                        [position]="floatMenuPosition" \n                        valign="top">\n                    <div class="panel-title panel-with-icon"></div>\n                    <div class="panel-icon {{menu.iconCls}}"></div>\n                </div>\n                <eui-tooltip-content #tc>\n                    <eui-sidemenu-items [data]="menu" [tip]="true" [style.width.px]="floatMenuWidth">\n                    </eui-sidemenu-items>\n                </eui-tooltip-content>\n                </ng-container>\n            </div>\n        </div>\n        <eui-sidemenu-items *ngIf="!collapsed" [data]="data">\n        </eui-sidemenu-items>\n    ',host:{class:"f-column"}})],SideMenuComponent)}();export{SideMenuComponent};