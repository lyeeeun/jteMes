/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
var __extends=this&&this.__extends||function(){var extendStatics=function(d,b){return(extendStatics=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(d,b){d.__proto__=b}||function(d,b){for(var p in b)b.hasOwnProperty(p)&&(d[p]=b[p])})(d,b)};return function(d,b){function __(){this.constructor=d}extendStatics(d,b),d.prototype=null===b?Object.create(b):(__.prototype=b.prototype,new __)}}(),__decorate=this&&this.__decorate||function(decorators,target,key,desc){var d,c=arguments.length,r=c<3?target:null===desc?desc=Object.getOwnPropertyDescriptor(target,key):desc;if("object"==typeof Reflect&&"function"==typeof Reflect.decorate)r=Reflect.decorate(decorators,target,key,desc);else for(var i=decorators.length-1;i>=0;i--)(d=decorators[i])&&(r=(c<3?d(r):c>3?d(target,key,r):d(target,key))||r);return c>3&&r&&Object.defineProperty(target,key,r),r},__metadata=this&&this.__metadata||function(k,v){if("object"==typeof Reflect&&"function"==typeof Reflect.metadata)return Reflect.metadata(k,v)};import{Component,forwardRef,ContentChild,Input,HostListener}from"@angular/core";import{NG_VALUE_ACCESSOR}from"@angular/forms";import{ComboBaseComponent,COMBO_BASE_TEXTBOX_TEMPLATE}from"../base/combo-base.component";import{TreeComponent}from"../tree/tree.component";import{treeHelper}from"../base/treehelper";export var COMBOTREE_TEMPLATE=COMBO_BASE_TEXTBOX_TEMPLATE+'\n\t<div #panel *ngIf="!panelClosed" \n\t\t\tclass="panel-body panel-body-noheader combo-panel combo-p"\n\t\t\t[style.left.px]="panelLeft"\n\t\t\t[style.top.px]="panelTop"\n\t\t\t[ngStyle]="panelStyle">\n\t\t<ng-content select="eui-tree"></ng-content>\n\t</div>\n';var ComboTreeComponent=function(_super){function ComboTreeComponent(){var _this=null!==_super&&_super.apply(this,arguments)||this;return _this.valueField="id",_this.textField="text",_this.editable=!1,_this.mappingTexts={},_this.displayingText=null,_this.inputingText=null,_this.updatingText=!1,_this._data=[],_this._text=null,_this._multiple=null,_this}__extends(ComboTreeComponent,_super),ComboTreeComponent_1=ComboTreeComponent,Object.defineProperty(ComboTreeComponent.prototype,"data",{get:function(){return this._data},set:function(value){null==value&&(value=[]),this._data=value,this.tree&&(this.tree.data=this._data),this.updateText()},enumerable:!0,configurable:!0}),Object.defineProperty(ComboTreeComponent.prototype,"text",{get:function(){return this.focused||(null!=this.value&&null==this.displayingText&&this.updateText(),this._text=this.textFormatter(this.displayingText)),this._text},set:function(value){var _this=this;this._text=value,this.focused&&(this.inputingText=value,this.openPanel(),clearTimeout(this.timer),this.timer=setTimeout(function(){_this.doFilter(value)},this.delay))},enumerable:!0,configurable:!0}),Object.defineProperty(ComboTreeComponent.prototype,"multiple",{get:function(){return this.tree?this.tree.checkbox:this._multiple},set:function(value){this._multiple=value,this.tree&&null!=value&&(this.tree.checkbox=this._multiple)},enumerable:!0,configurable:!0}),ComboTreeComponent.prototype.ngAfterContentInit=function(){var _this=this;this.valueChange.subscribe(function(){_this.updatingText||_this.updateText()}),this.tree&&(null!=this._multiple&&(this.tree.checkbox=this._multiple),this.tree.data=this.data,this.tree.selectionChange.subscribe(function(node){_this.multiple||(_this.value=node[_this.valueField],_this.closePanel())}),this.tree.checkChange.subscribe(function(nodes){_this.multiple&&!_this.updatingText&&(_this.value=nodes.map(function(node){return node[_this.valueField]}))}))},ComboTreeComponent.prototype.onComboTreeBlur=function(){if(null!=this.inputingText){var text=this.inputingText.trim();if(text){if(this.multiple){for(var vv=[],tt=text.split(this.separator),_i=0,_a=this.value;_i<_a.length;_i++){var val=_a[_i],text_1=this.mappingTexts[val];-1!=tt.indexOf(text_1)&&vv.push(val)}this.value.length!=vv.length&&(this.value=vv)}else this.inputingText!=this.displayingText&&(this.value=null);this.inputingText=null}else this.value=null}},ComboTreeComponent.prototype.doFilter=function(value){if(this.tree)if(value)if(this.multiple){var tt=value.trim().split(this.separator),val=tt[tt.length-1];this.tree.doFilter(val)}else this.tree.doFilter(value);else this.tree.doFilter("")},ComboTreeComponent.prototype.openPanel=function(){this.panelClosed&&(_super.prototype.openPanel.call(this),this.editable&&this.doFilter(""))},ComboTreeComponent.prototype.updateText=function(){var _this=this;if(this.tree){if(this.updatingText=!0,null==this.value)this.mappingTexts={},this.displayingText=null,this.tree.selection=null,this.tree.checkbox&&this.tree.uncheckAllNodes();else{var mt_1={},tt_1=[];if(this.multiple){this.tree.uncheckAllNodes();for(var _i=0,_a=this.value;_i<_a.length;_i++){var val=_a[_i];(node=treeHelper.findNode(this.tree.data,this.valueField,val))&&this.tree.checkNode(node)}var vv_1=[];this.tree.checkedNodes.forEach(function(node){vv_1.push(node[_this.valueField]),mt_1[node[_this.valueField]]=node[_this.textField],tt_1.push(node[_this.textField])}),this.value.filter(function(val){return-1==vv_1.indexOf(val)}).forEach(function(val){vv_1.push(val),mt_1[val]=_this.mappingTexts[val]||val,tt_1.push(mt_1[val])}),this.value=vv_1}else{var node=treeHelper.findNode(this.tree.data,this.valueField,this.value);node?(mt_1[this.value]=node[this.textField],this.tree.selection=node):mt_1[this.value]=this.mappingTexts[this.value]||this.value,tt_1.push(mt_1[this.value])}this.mappingTexts=mt_1,this.displayingText=tt_1.join(this.separator)}this.updatingText=!1}};var ComboTreeComponent_1;return __decorate([ContentChild(TreeComponent),__metadata("design:type",TreeComponent)],ComboTreeComponent.prototype,"tree",void 0),__decorate([Input(),__metadata("design:type",String)],ComboTreeComponent.prototype,"valueField",void 0),__decorate([Input(),__metadata("design:type",String)],ComboTreeComponent.prototype,"textField",void 0),__decorate([Input(),__metadata("design:type",Boolean)],ComboTreeComponent.prototype,"editable",void 0),__decorate([Input(),__metadata("design:type",Array),__metadata("design:paramtypes",[Array])],ComboTreeComponent.prototype,"data",null),__decorate([Input(),__metadata("design:type",String),__metadata("design:paramtypes",[String])],ComboTreeComponent.prototype,"text",null),__decorate([Input(),__metadata("design:type",Boolean),__metadata("design:paramtypes",[Boolean])],ComboTreeComponent.prototype,"multiple",null),__decorate([HostListener("blur"),__metadata("design:type",Function),__metadata("design:paramtypes",[]),__metadata("design:returntype",void 0)],ComboTreeComponent.prototype,"onComboTreeBlur",null),ComboTreeComponent=ComboTreeComponent_1=__decorate([Component({selector:"eui-combotree",template:COMBOTREE_TEMPLATE,providers:[{provide:NG_VALUE_ACCESSOR,useExisting:forwardRef(function(){return ComboTreeComponent_1}),multi:!0}],host:{"[class.f-inline-row]":"true","[class.f-field]":"true"}})],ComboTreeComponent)}(ComboBaseComponent);export{ComboTreeComponent};