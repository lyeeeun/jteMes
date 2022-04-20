/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,ViewChild,Input,ElementRef,ChangeDetectorRef}from"@angular/core";import{domHelper}from"../base/domhelper";import{TooltipDirective}from"./tooltip.directive";export var TOOLTIP_CONTENT_TEMPLATE='\n\t<div *ngIf="!closed" #tooltip tabindex="-1" class="tooltip tooltip-{{position}}"\n\t\t\t[ngClass]="tooltipCls"\n\t\t\t[ngStyle]="tooltipStyle"\n\t\t\t[style.left.px]="left"\n\t\t\t[style.top.px]="top"\n\t\t\t[style.zIndex]="zIndex"\n\t\t\t(mouseenter)="onMouseEnter($event)"\n\t\t\t(mouseleave)="onMouseLeave($event)">\n\t\t<div class="tooltip-content">\n\t\t\t<ng-content></ng-content>\n\t\t\t{{content}}\n\t\t</div>\n\t\t<div #arrowOuter class="tooltip-arrow-outer"></div>\n\t\t<div #arrowInner class="tooltip-arrow"></div>\n\t</div>\n';var TooltipContentComponent=function(){function TooltipContentComponent(hostRef,cdRef){this.hostRef=hostRef,this.cdRef=cdRef,this.tooltipCls=null,this.tooltipStyle=null,this.content=null,this.position="bottom",this.target=null,this.parent=null,this.trackMouse=!1,this.trackMouseX=null,this.trackMouseY=null,this.deltaX=0,this.deltaY=0,this.valign="middle",this.left=null,this.top=null,this.zIndex=TooltipContentComponent_1.zIndex++,this.closed=!0,this.targetWidth=null,this.targetHeight=null,this.tipWidth=null,this.tipHeight=null}TooltipContentComponent_1=TooltipContentComponent,TooltipContentComponent.prototype.ngOnDestroy=function(){this.tooltipRef&&this.hostRef.nativeElement.appendChild(this.tooltipRef.nativeElement)},TooltipContentComponent.prototype.onMouseEnter=function(event){this.parent.clearTimeouts(),this.show()},TooltipContentComponent.prototype.onMouseLeave=function(event){this.parent.clean()},TooltipContentComponent.prototype.getPosition=function(pos){void 0===pos&&(pos="bottom"),this.position=pos||"bottom";var left=0,top=0,offset=domHelper.offset(this.target),targetWidth=this.targetWidth,targetHeight=this.targetHeight,tipWidth=this.tipWidth,tipHeight=this.tipHeight;switch(this.trackMouse?(left=this.trackMouseX+this.deltaX,top=this.trackMouseY+this.deltaY,targetWidth=targetHeight=0):(left=offset.left+this.deltaX,top=offset.top+this.deltaY),this.position){case"right":left+=targetWidth+12+(this.trackMouse?12:0),"middle"==this.valign&&(top-=(tipHeight-targetHeight)/2);break;case"left":left-=tipWidth+12+(this.trackMouse?12:0),"middle"==this.valign&&(top-=(tipHeight-targetHeight)/2);break;case"top":left-=(tipWidth-targetWidth)/2,top-=tipHeight+12+(this.trackMouse?12:0);break;case"bottom":left-=(tipWidth-targetWidth)/2,top+=targetHeight+12+(this.trackMouse?12:0)}return{left:left,top:top}},TooltipContentComponent.prototype.reposition=function(){var view=domHelper.getViewport(),pos=this.getPosition(this.position);if("top"==this.position&&pos.top<domHelper.getScrollTop()?pos=this.getPosition("bottom"):"bottom"==this.position&&pos.top+this.tipHeight>view.height+domHelper.getScrollTop()&&(pos=this.getPosition("top")),pos.left<domHelper.getScrollLeft())if("left"==this.position)pos=this.getPosition("right");else{arrowLeft=this.tipWidth/2+pos.left-domHelper.getScrollLeft();this.arrowOuterRef.nativeElement.style.left=arrowLeft+"px",this.arrowInnerRef.nativeElement.style.left=arrowLeft+"px",pos.left=domHelper.getScrollLeft()}else if(pos.left+this.tipWidth>view.width+domHelper.getScrollLeft())if("right"==this.position)pos=this.getPosition("left");else{var arrowLeft=pos.left;pos.left=view.width+domHelper.getScrollLeft()-this.tipWidth,arrowLeft=this.tipWidth/2-(pos.left-arrowLeft),this.arrowOuterRef.nativeElement.style.left=arrowLeft+"px",this.arrowInnerRef.nativeElement.style.left=arrowLeft+"px"}this.left=pos.left,this.top=pos.top;var bc="border-"+this.position+"-color",borderColor=this.tooltipRef.nativeElement.style.borderColor,backColor=this.tooltipRef.nativeElement.style.backgroundColor;this.arrowOuterRef.nativeElement.style[bc]=borderColor,this.arrowInnerRef.nativeElement.style[bc]=backColor},TooltipContentComponent.prototype.show=function(){this.closed&&(this.closed=!1,this.left=-1e3,this.top=-1e3,this.cdRef.detectChanges(),document.body.appendChild(this.tooltipRef.nativeElement),this.tooltipRef.nativeElement.style.display="block",this.targetWidth=domHelper.outerWidth(this.target),this.targetHeight=domHelper.outerHeight(this.target),this.tipWidth=domHelper.outerWidth(this.tooltipRef.nativeElement),this.tipHeight=domHelper.outerHeight(this.tooltipRef.nativeElement),this.reposition(),this.parent.tooltipShow.emit())},TooltipContentComponent.prototype.hide=function(){this.closed||(this.closed=!0,this.parent.tooltipHide.emit())};var TooltipContentComponent_1;return TooltipContentComponent.zIndex=11e6,__decorate([ViewChild("tooltip"),__metadata("design:type",ElementRef)],TooltipContentComponent.prototype,"tooltipRef",void 0),__decorate([ViewChild("arrowOuter"),__metadata("design:type",ElementRef)],TooltipContentComponent.prototype,"arrowOuterRef",void 0),__decorate([ViewChild("arrowInner"),__metadata("design:type",ElementRef)],TooltipContentComponent.prototype,"arrowInnerRef",void 0),__decorate([Input(),__metadata("design:type",String)],TooltipContentComponent.prototype,"tooltipCls",void 0),__decorate([Input(),__metadata("design:type",Object)],TooltipContentComponent.prototype,"tooltipStyle",void 0),__decorate([Input(),__metadata("design:type",String)],TooltipContentComponent.prototype,"content",void 0),__decorate([Input(),__metadata("design:type",String)],TooltipContentComponent.prototype,"position",void 0),__decorate([Input(),__metadata("design:type",HTMLElement)],TooltipContentComponent.prototype,"target",void 0),__decorate([Input(),__metadata("design:type",TooltipDirective)],TooltipContentComponent.prototype,"parent",void 0),__decorate([Input(),__metadata("design:type",Boolean)],TooltipContentComponent.prototype,"trackMouse",void 0),__decorate([Input(),__metadata("design:type",Number)],TooltipContentComponent.prototype,"trackMouseX",void 0),__decorate([Input(),__metadata("design:type",Number)],TooltipContentComponent.prototype,"trackMouseY",void 0),__decorate([Input(),__metadata("design:type",Number)],TooltipContentComponent.prototype,"deltaX",void 0),__decorate([Input(),__metadata("design:type",Number)],TooltipContentComponent.prototype,"deltaY",void 0),__decorate([Input(),__metadata("design:type",String)],TooltipContentComponent.prototype,"valign",void 0),__decorate([Input(),__metadata("design:type",Number)],TooltipContentComponent.prototype,"left",void 0),__decorate([Input(),__metadata("design:type",Number)],TooltipContentComponent.prototype,"top",void 0),__decorate([Input(),__metadata("design:type",Number)],TooltipContentComponent.prototype,"zIndex",void 0),__decorate([Input(),__metadata("design:type",Boolean)],TooltipContentComponent.prototype,"closed",void 0),TooltipContentComponent=TooltipContentComponent_1=__decorate([Component({selector:"eui-tooltip-content",template:TOOLTIP_CONTENT_TEMPLATE}),__metadata("design:paramtypes",[ElementRef,ChangeDetectorRef])],TooltipContentComponent)}();export{TooltipContentComponent};