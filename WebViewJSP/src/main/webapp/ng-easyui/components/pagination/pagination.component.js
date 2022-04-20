/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,ViewChildren,ContentChild,QueryList,Input,Output,EventEmitter,forwardRef}from"@angular/core";import{PaginationButtonComponent}from"./pagination-button.component";import{PageTemplateDirective}from"../base/template-base";var PaginationComponent=function(){function PaginationComponent(){this.pageList=[10,20,30,40,50],this.loading=!1,this.showPageList=!0,this.showPageInfo=!0,this.showPageRefresh=!0,this.links=10,this.beforePageText="Page",this.afterPageText="of {pages}",this.displayMsg="Displaying {from} to {to} of {total} items",this.layout=["first","prev","links","next","last","refresh"],this.pageChange=new EventEmitter,this.state=null,this._initialized=!1,this._total=0,this._pageSize=10,this._pageNumber=1,this._pageOptions={}}return Object.defineProperty(PaginationComponent.prototype,"total",{get:function(){return this._total},set:function(value){this._total=value,this.adjustPage()},enumerable:!0,configurable:!0}),Object.defineProperty(PaginationComponent.prototype,"pageSize",{get:function(){return this._pageSize},set:function(value){this._pageSize=+value,this.adjustPage()},enumerable:!0,configurable:!0}),Object.defineProperty(PaginationComponent.prototype,"pageNumber",{get:function(){return this._pageNumber},set:function(value){this._pageNumber=+value,this.adjustPage()},enumerable:!0,configurable:!0}),Object.defineProperty(PaginationComponent.prototype,"pageOptions",{get:function(){return this._pageOptions},set:function(value){this._pageOptions=value,Object.assign(this,value),this.adjustPage()},enumerable:!0,configurable:!0}),PaginationComponent.prototype.ngAfterContentInit=function(){this._initialized=!0,this.state={pageNumber:this.pageNumber,pageSize:this.pageSize}},Object.defineProperty(PaginationComponent.prototype,"pageInfo",{get:function(){var info=this.displayMsg;return info=info.replace(/{from}/,String(0==this.total?0:this.pageSize*(this.pageNumber-1)+1)),info=info.replace(/{to}/,String(Math.min(this.pageSize*this.pageNumber,this.total))),info=info.replace(/{total}/,String(this.total))},enumerable:!0,configurable:!0}),Object.defineProperty(PaginationComponent.prototype,"pageCount",{get:function(){return this.total?Math.ceil(this.total/this.pageSize)||1:0},enumerable:!0,configurable:!0}),PaginationComponent.prototype.isButton=function(name){return["first","prev","next","last","refresh"].indexOf(name)>=0},PaginationComponent.prototype.adjustPage=function(){if(this._initialized){this._pageNumber<1&&(this._pageNumber=1),this._pageNumber>this.pageCount&&(this._pageNumber=this.pageCount),0==this._total&&(this._pageNumber=0);var state={pageNumber:this.pageNumber||1,pageSize:this.pageSize};null!=this.state&&(this.state.pageNumber==state.pageNumber&&this.state.pageSize==state.pageSize||(this.state=state,this.pageChange.emit(this.state)))}},PaginationComponent.prototype.selectPage=function(page){this.pageNumber=page},PaginationComponent.prototype.refreshPage=function(){var state=Object.assign({refresh:!0},this.state);state.pageNumber<=0&&(state.pageNumber=1),this.pageChange.emit(state)},__decorate([ViewChildren(forwardRef(function(){return PaginationButtonComponent})),__metadata("design:type",QueryList)],PaginationComponent.prototype,"buttons",void 0),__decorate([ContentChild(PageTemplateDirective),__metadata("design:type",PageTemplateDirective)],PaginationComponent.prototype,"pageTemplate",void 0),__decorate([Input(),__metadata("design:type",Array)],PaginationComponent.prototype,"pageList",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PaginationComponent.prototype,"loading",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PaginationComponent.prototype,"showPageList",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PaginationComponent.prototype,"showPageInfo",void 0),__decorate([Input(),__metadata("design:type",Boolean)],PaginationComponent.prototype,"showPageRefresh",void 0),__decorate([Input(),__metadata("design:type",Number)],PaginationComponent.prototype,"links",void 0),__decorate([Input(),__metadata("design:type",String)],PaginationComponent.prototype,"beforePageText",void 0),__decorate([Input(),__metadata("design:type",String)],PaginationComponent.prototype,"afterPageText",void 0),__decorate([Input(),__metadata("design:type",String)],PaginationComponent.prototype,"displayMsg",void 0),__decorate([Input(),__metadata("design:type",Array)],PaginationComponent.prototype,"layout",void 0),__decorate([Output(),__metadata("design:type",Object)],PaginationComponent.prototype,"pageChange",void 0),__decorate([Input(),__metadata("design:type",Number),__metadata("design:paramtypes",[Number])],PaginationComponent.prototype,"total",null),__decorate([Input(),__metadata("design:type",Number),__metadata("design:paramtypes",[Number])],PaginationComponent.prototype,"pageSize",null),__decorate([Input(),__metadata("design:type",Number),__metadata("design:paramtypes",[Number])],PaginationComponent.prototype,"pageNumber",null),__decorate([Input(),__metadata("design:type",Object),__metadata("design:paramtypes",[Object])],PaginationComponent.prototype,"pageOptions",null),PaginationComponent=__decorate([Component({selector:"eui-pagination",template:'\n\t\t<ng-container *ngFor="let name of layout">\n\t\t\t<eui-pagination-list *ngIf="name==\'list\'"></eui-pagination-list>\n\t\t\t<eui-pagination-link *ngIf="name==\'links\'"></eui-pagination-link>\n\t\t\t<div class="pagination-btn-separator" *ngIf="name==\'sep\'"></div>\n\t\t\t<eui-pagination-button [name]="name" *ngIf="isButton(name)"></eui-pagination-button>\n\t\t\t<ng-template *ngIf="pageTemplate && name==\'tpl\'" [euiPaginationTemplate]="pageTemplate.template" [pagination]="this"></ng-template>\n\t\t\t<div class="f-full" *ngIf="name==\'info\'">\n\t\t\t\t<div class="pagination-info">{{pageInfo}}</div>\n\t\t\t</div>\n\t\t</ng-container>\n\t',host:{class:"f-row f-content-center"}})],PaginationComponent)}();export{PaginationComponent};