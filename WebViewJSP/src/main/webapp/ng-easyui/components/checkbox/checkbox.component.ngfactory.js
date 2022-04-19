/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
function View_CheckboxComponent_1(_l){return i0.ɵvid(0,[(_l()(),i0.ɵeld(0,0,null,null,1,":svg:svg",[[":xml:space","preserve"],["class","checkbox-inner"],["focusable","false"],["version","1.1"],["viewBox","0 0 24 24"]],null,null,null,null,null)),(_l()(),i0.ɵeld(1,0,null,null,0,":svg:path",[["d","M4.1,12.7 9,17.6 20.3,6.3"],["fill","none"],["stroke","white"]],null,null,null,null,null))],null,null)}import*as i0 from"@angular/core";import*as i1 from"@angular/common";import*as i2 from"@angular/forms";import*as i3 from"./checkbox.component";var styles_CheckboxComponent=[],RenderType_CheckboxComponent=i0.ɵcrt({encapsulation:2,styles:styles_CheckboxComponent,data:{}});export{RenderType_CheckboxComponent};export function View_CheckboxComponent_0(_l){return i0.ɵvid(0,[i0.ɵqud(402653184,1,{inputRef:0}),(_l()(),i0.ɵeld(1,0,null,null,2,"span",[["class","checkbox f-full"]],[[2,"checkbox-disabled",null],[2,"checkbox-checked",null]],[[null,"click"]],function(_v,en,$event){var ad=!0,_co=_v.component;return"click"===en&&(ad=!1!==_co.onClickButton($event)&&ad),ad},null,null)),(_l()(),i0.ɵand(16777216,null,null,1,null,View_CheckboxComponent_1)),i0.ɵdid(3,16384,null,0,i1.NgIf,[i0.ViewContainerRef,i0.TemplateRef],{ngIf:[0,"ngIf"]},null),(_l()(),i0.ɵeld(4,0,null,null,1,"div",[["class","checkbox-value"]],null,null,null,null,null)),(_l()(),i0.ɵeld(5,0,[[1,0],["input",1]],null,0,"input",[["type","checkbox"]],[[1,"id",0],[1,"name",0],[8,"disabled",0]],[[null,"change"]],function(_v,en,$event){var ad=!0,_co=_v.component;return"change"===en&&(ad=!1!==_co.onChange($event)&&ad),ad},null,null))],function(_ck,_v){_ck(_v,3,0,_v.component.checked)},function(_ck,_v){var _co=_v.component;_ck(_v,1,0,_co.disabled,_co.checked),_ck(_v,5,0,_co.inputId,_co.name,_co.disabled)})};export function View_CheckboxComponent_Host_0(_l){return i0.ɵvid(0,[(_l()(),i0.ɵeld(0,0,null,null,2,"eui-checkbox",[],[[2,"f-inline-row",null]],null,null,View_CheckboxComponent_0,RenderType_CheckboxComponent)),i0.ɵprd(5120,null,i2.NG_VALUE_ACCESSOR,function(p0_0){return[p0_0]},[i3.CheckboxComponent]),i0.ɵdid(2,49152,null,0,i3.CheckboxComponent,[],null,null)],null,function(_ck,_v){_ck(_v,0,0,!0)})};var CheckboxComponentNgFactory=i0.ɵccf("eui-checkbox",i3.CheckboxComponent,View_CheckboxComponent_Host_0,{value:"value",name:"name",disabled:"disabled",inputId:"inputId",multiple:"multiple",checked:"checked"},{valueChange:"valueChange",checkedChange:"checkedChange"},[]);export{CheckboxComponentNgFactory};