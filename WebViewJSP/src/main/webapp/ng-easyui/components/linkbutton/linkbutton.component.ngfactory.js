/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
import*as i0 from"@angular/core";import*as i1 from"@angular/common";import*as i2 from"./linkbutton.component";var styles_LinkButtonComponent=[],RenderType_LinkButtonComponent=i0.ɵcrt({encapsulation:2,styles:styles_LinkButtonComponent,data:{}});export{RenderType_LinkButtonComponent};export function View_LinkButtonComponent_0(_l){return i0.ɵvid(0,[i0.ɵqud(402653184,1,{btnRef:0}),i0.ɵqud(402653184,2,{textRef:0}),(_l()(),i0.ɵeld(2,0,[[1,0],["btnRef",1]],null,6,"a",[],[[1,"href",4]],[[null,"focus"],[null,"blur"],[null,"click"]],function(_v,en,$event){var ad=!0,_co=_v.component;return"focus"===en&&(ad=!1!==_co.focus()&&ad),"blur"===en&&(ad=!1!==_co.blur()&&ad),"click"===en&&(ad=!1!==_co.onClick($event)&&ad),ad},null,null)),i0.ɵdid(3,278528,null,0,i1.NgClass,[i0.IterableDiffers,i0.KeyValueDiffers,i0.ElementRef,i0.Renderer2],{klass:[0,"klass"],ngClass:[1,"ngClass"]},null),i0.ɵdid(4,278528,null,0,i1.NgStyle,[i0.KeyValueDiffers,i0.ElementRef,i0.Renderer2],{ngStyle:[0,"ngStyle"]},null),(_l()(),i0.ɵeld(5,0,null,null,3,"span",[],[[8,"className",0]],null,null,null,null)),(_l()(),i0.ɵeld(6,0,[[2,0],["textRef",1]],null,1,"span",[["class","l-btn-text"]],[[2,"l-btn-empty",null]],null,null,null,null)),i0.ɵncd(null,0),(_l()(),i0.ɵeld(8,0,null,null,0,"span",[],[[8,"className",0]],null,null,null,null))],function(_ck,_v){var _co=_v.component;_ck(_v,3,0,_co.getInnerCls(),_co.btnCls),_ck(_v,4,0,_co.btnStyle)},function(_ck,_v){var _co=_v.component;_ck(_v,2,0,_co.href||"#"),_ck(_v,5,0,_co.btnLeftCls),_ck(_v,6,0,!_co.text),_ck(_v,8,0,_co.btnIconCls)})};export function View_LinkButtonComponent_Host_0(_l){return i0.ɵvid(0,[(_l()(),i0.ɵeld(0,0,null,null,1,"eui-linkbutton",[["class","f-inline-row"]],null,null,null,View_LinkButtonComponent_0,RenderType_LinkButtonComponent)),i0.ɵdid(1,4243456,null,0,i2.LinkButtonComponent,[],null,null)],null,null)};var LinkButtonComponentNgFactory=i0.ɵccf("eui-linkbutton",i2.LinkButtonComponent,View_LinkButtonComponent_Host_0,{disabled:"disabled",toggle:"toggle",selected:"selected",outline:"outline",plain:"plain",iconCls:"iconCls",iconAlign:"iconAlign",size:"size",href:"href",btnCls:"btnCls",btnStyle:"btnStyle",text:"text"},{click:"click"},["*"]);export{LinkButtonComponentNgFactory};