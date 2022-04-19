/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,ViewChild,Input,ElementRef}from"@angular/core";var DraggableProxyComponent=function(){function DraggableProxyComponent(hostRef){this.hostRef=hostRef,this.left=null,this.top=null,this.width=null,this.height=null,this.proxyCls=null,this.proxyStyle=null,this.reverting=!1,this.closed=!0}return DraggableProxyComponent.prototype.ngOnInit=function(){document.body.appendChild(this.proxyRef.nativeElement)},DraggableProxyComponent.prototype.ngOnDestroy=function(){this.proxyRef&&this.hostRef.nativeElement.appendChild(this.proxyRef.nativeElement)},DraggableProxyComponent.prototype.onTransitionEnd=function(event){this.reverting=!1,this.closed=!0},__decorate([ViewChild("proxy"),__metadata("design:type",ElementRef)],DraggableProxyComponent.prototype,"proxyRef",void 0),__decorate([Input(),__metadata("design:type",Number)],DraggableProxyComponent.prototype,"left",void 0),__decorate([Input(),__metadata("design:type",Number)],DraggableProxyComponent.prototype,"top",void 0),__decorate([Input(),__metadata("design:type",Number)],DraggableProxyComponent.prototype,"width",void 0),__decorate([Input(),__metadata("design:type",Number)],DraggableProxyComponent.prototype,"height",void 0),__decorate([Input(),__metadata("design:type",String)],DraggableProxyComponent.prototype,"proxyCls",void 0),__decorate([Input(),__metadata("design:type",Object)],DraggableProxyComponent.prototype,"proxyStyle",void 0),__decorate([Input(),__metadata("design:type",Boolean)],DraggableProxyComponent.prototype,"reverting",void 0),__decorate([Input(),__metadata("design:type",Boolean)],DraggableProxyComponent.prototype,"closed",void 0),DraggableProxyComponent=__decorate([Component({selector:"eui-draggable-proxy",template:'\n\t\t<div #proxy style="position:absolute;"\n\t\t\t\t[class.draggable-reverting]="reverting"\n\t\t\t\t[style.left.px]="left" \n\t\t\t\t[style.top.px]="top"\n\t\t\t\t[style.width.px]="width"\n\t\t\t\t[style.height.px]="height"\n\t\t\t\t[style.display]="closed ? \'none\' : \'block\'"\n\t\t\t\t[ngClass]="proxyCls"\n\t\t\t\t[ngStyle]="proxyStyle"\n\t\t\t\t(transitionend)="onTransitionEnd($event)">\n\t\t\t<ng-content></ng-content>\n\t\t</div>\n\t'}),__metadata("design:paramtypes",[ElementRef])],DraggableProxyComponent)}();export{DraggableProxyComponent};