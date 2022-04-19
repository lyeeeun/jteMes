/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,ViewChild,ElementRef,Input,Output,EventEmitter}from"@angular/core";import{GridColumnGroupComponent}from"./grid-column-group.component";import{domHelper}from"../base/domhelper";export var GRID_HEADER_TEMPLATE='\n\t<div class="datagrid-header f-row">\n\t\t<div #header class="datagrid-header-inner f-full" [style.height.px]="_height">\n\t\t\t<table #content class="datagrid-htable" border="0" cellspacing="0" cellpadding="0">\n\t\t\t\t<colgroup>\n\t\t\t\t\t<col *ngFor="let col of columns" [style.width]="col.width">\n\t\t\t\t</colgroup>\n\t\t\t\t<tbody *ngIf="columnGroup">\n\t\t\t\t\t<tr *ngIf="filterOnTop" class="datagrid-header-row datagrid-filter-row" euiGridFilterRow [columns]="columns" [grid]="grid"></tr>\n\t\t\t\t\t<tr *ngFor="let row of columnGroup.rows" class="datagrid-header-row">\n\t\t\t\t\t\t<td *ngFor="let col of row.columns"\n\t\t\t\t\t\t\t\t[attr.rowspan]="col.rowspan"\n\t\t\t\t\t\t\t\t[attr.colspan]="col.colspan"\n\t\t\t\t\t\t\t\t[class.datagrid-field-td]="col.field"\n\t\t\t\t\t\t\t\t[class.datagrid-header-over]="hoverColumn==col && col.sortable"\n\t\t\t\t\t\t\t\t(mouseenter)="hoverColumn=col"\n\t\t\t\t\t\t\t\t(mouseleave)="hoverColumn=null"\n\t\t\t\t\t\t\t\t(click)="onCellClick($event,col)">\n\t\t\t\t\t\t\t<div class="datagrid-cell" \n\t\t\t\t\t\t\t\t\teuiResizable handles="e" [disabled]="!grid.columnResizing" (resizing)="onColumnResizing($event,col)" (resizeStop)="onColumnResizeStop($event,col)"\n\t\t\t\t\t\t\t\t\t[class.datagrid-cell-group]="!col.field"\n\t\t\t\t\t\t\t\t\t[class.datagrid-sort]="col.field && col.sortable"\n\t\t\t\t\t\t\t\t\t[class.datagrid-sort-asc]="col.currOrder==\'asc\'"\n\t\t\t\t\t\t\t\t\t[class.datagrid-sort-desc]="col.currOrder==\'desc\'"\n\t\t\t\t\t\t\t\t\t[style.textAlign]="col.halign || col.align || null">\n\t\t\t\t\t\t\t\t<span *ngIf="!col.headerTemplate">{{col.title}}</span>\n\t\t\t\t\t\t\t\t<ng-template *ngIf="col.headerTemplate" [euiGridHeaderTemplate]="col.headerTemplate.template" [column]="col"></ng-template>\n\t\t\t\t\t\t\t\t<span class="datagrid-sort-icon"></span>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr *ngIf="filterOnBottom" class="datagrid-header-row datagrid-filter-row" euiGridFilterRow [columns]="columns" [grid]="grid"></tr>\n\t\t\t\t</tbody>\n\t\t\t\t<tbody *ngIf="!columnGroup">\n\t\t\t\t\t<tr *ngIf="filterOnTop" class="datagrid-header-row datagrid-filter-row" euiGridFilterRow [columns]="columns" [grid]="grid"></tr>\n\t\t\t\t\t<tr class="datagrid-header-row">\n\t\t\t\t\t\t<td *ngFor="let col of columns" \n\t\t\t\t\t\t\t\tclass="datagrid-field-td"\n\t\t\t\t\t\t\t\t[class.datagrid-header-over]="hoverColumn==col && col.sortable"\n\t\t\t\t\t\t\t\t(mouseenter)="hoverColumn=col"\n\t\t\t\t\t\t\t\t(mouseleave)="hoverColumn=null"\n\t\t\t\t\t\t\t\t(click)="onCellClick($event,col)">\n\t\t\t\t\t\t\t<div class="datagrid-cell" \n\t\t\t\t\t\t\t\t\teuiResizable handles="e" [disabled]="!grid.columnResizing" (resizing)="onColumnResizing($event,col)" (resizeStop)="onColumnResizeStop($event,col)"\n\t\t\t\t\t\t\t\t\t[class.datagrid-sort]="col.field && col.sortable"\n\t\t\t\t\t\t\t\t\t[class.datagrid-sort-asc]="col.currOrder==\'asc\'"\n\t\t\t\t\t\t\t\t\t[class.datagrid-sort-desc]="col.currOrder==\'desc\'"\n\t\t\t\t\t\t\t\t\t[style.textAlign]="col.halign || col.align || null">\n\t\t\t\t\t\t\t\t<span *ngIf="!col.headerTemplate">{{col.title}}</span>\n\t\t\t\t\t\t\t\t<ng-template *ngIf="col.headerTemplate" [euiGridHeaderTemplate]="col.headerTemplate.template" [column]="col"></ng-template>\n\t\t\t\t\t\t\t\t<span class="datagrid-sort-icon"></span>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t<tr *ngIf="filterOnBottom" class="datagrid-header-row datagrid-filter-row" euiGridFilterRow [columns]="columns" [grid]="grid"></tr>\n\t\t\t\t</tbody>\n\t\t\t</table>\n\t\t</div>\n\t\t<div *ngIf="paddingWidth" class="datagrid-header f-noshrink" [style.width.px]="paddingWidth"></div>\n\t</div>\n';var GridHeaderComponent=function(){function GridHeaderComponent(){this.paddingWidth=0,this.filterable=!1,this.grid=null,this.cellClick=new EventEmitter}return Object.defineProperty(GridHeaderComponent.prototype,"filterOnTop",{get:function(){return!(!this.grid.filterable||"both"!=this.grid.filterPosition&&"top"!=this.grid.filterPosition)},enumerable:!0,configurable:!0}),Object.defineProperty(GridHeaderComponent.prototype,"filterOnBottom",{get:function(){return!(!this.grid.filterable||"both"!=this.grid.filterPosition&&"bottom"!=this.grid.filterPosition)},enumerable:!0,configurable:!0}),Object.defineProperty(GridHeaderComponent.prototype,"height",{get:function(){return domHelper.outerHeight(this.contentRef.nativeElement)},set:function(value){this._height=value?value-1:value},enumerable:!0,configurable:!0}),Object.defineProperty(GridHeaderComponent.prototype,"scrollLeft",{get:function(){return this.headerRef.nativeElement.scrollLeft},set:function(value){this.headerRef.nativeElement.scrollLeft=value},enumerable:!0,configurable:!0}),GridHeaderComponent.prototype.onCellClick=function(event,col){this.cellClick.emit({column:col,originalEvent:event})},GridHeaderComponent.prototype.onColumnResizing=function(event,col){event.target.hostRef.nativeElement.style.width=null,event.target.hostRef.nativeElement.style.left=null,event.target.hostRef.nativeElement.style.top=null,col.width=domHelper.toStyleValue(event.width)},GridHeaderComponent.prototype.onColumnResizeStop=function(event,col){event.target.hostRef.nativeElement.style.width=null,event.target.hostRef.nativeElement.style.left=null,event.target.hostRef.nativeElement.style.top=null,col.width=domHelper.toStyleValue(event.width)},__decorate([ViewChild("header"),__metadata("design:type",ElementRef)],GridHeaderComponent.prototype,"headerRef",void 0),__decorate([ViewChild("content"),__metadata("design:type",ElementRef)],GridHeaderComponent.prototype,"contentRef",void 0),__decorate([Input(),__metadata("design:type",Array)],GridHeaderComponent.prototype,"columns",void 0),__decorate([Input(),__metadata("design:type",GridColumnGroupComponent)],GridHeaderComponent.prototype,"columnGroup",void 0),__decorate([Input(),__metadata("design:type",Number)],GridHeaderComponent.prototype,"paddingWidth",void 0),__decorate([Input(),__metadata("design:type",Boolean)],GridHeaderComponent.prototype,"filterable",void 0),__decorate([Input(),__metadata("design:type",Object)],GridHeaderComponent.prototype,"grid",void 0),__decorate([Output(),__metadata("design:type",Object)],GridHeaderComponent.prototype,"cellClick",void 0),GridHeaderComponent=__decorate([Component({selector:"eui-grid-header",template:GRID_HEADER_TEMPLATE,host:{class:"f-column f-noshrink"}})],GridHeaderComponent)}();export{GridHeaderComponent};