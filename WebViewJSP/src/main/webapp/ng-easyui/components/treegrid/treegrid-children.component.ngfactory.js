/**
 * EasyUI for Angular 1.2.5
 * 
 * Copyright (c) 2009-2019 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the freeware license: https://www.jeasyui.com/license_freeware2.php
 * To use it on other terms please contact us: info@jeasyui.com
 *
 */
function View_TreeGridChildrenComponent_1(_l){return i0.ɵvid(0,[(_l()(),i0.ɵeld(0,0,null,null,0,"col",[],[[4,"width",null]],null,null,null,null))],null,function(_ck,_v){_ck(_v,0,0,_v.context.$implicit.width)})}function View_TreeGridChildrenComponent_3(_l){return i0.ɵvid(0,[(_l()(),i0.ɵeld(0,0,null,null,3,"tr",[["class","treegrid-tr-tree"]],null,null,null,null,null)),(_l()(),i0.ɵeld(1,0,null,null,2,"td",[["style","border:0"]],[[1,"colspan",0]],null,null,null,null)),(_l()(),i0.ɵeld(2,0,null,null,1,"div",[["euiTreeGridChildren",""]],null,null,null,View_TreeGridChildrenComponent_0,RenderType_TreeGridChildrenComponent)),i0.ɵdid(3,49152,null,0,i1.TreeGridChildrenComponent,[i2.TreeGridBodyComponent],{rows:[0,"rows"],prow:[1,"prow"],columns:[2,"columns"],depth:[3,"depth"]},null)],function(_ck,_v){var _co=_v.component;_ck(_v,3,0,_v.parent.context.$implicit.children,_v.parent.context.$implicit,_co.columns,_co.depth+1)},function(_ck,_v){_ck(_v,1,0,_v.component.columns.length)})}function View_TreeGridChildrenComponent_2(_l){return i0.ɵvid(0,[(_l()(),i0.ɵeld(0,0,null,null,4,null,null,null,null,null,null,null)),(_l()(),i0.ɵeld(1,0,null,null,1,"tr",[["class","datagrid-row"],["euiTreeGridRow",""]],[[2,"datagrid-row-over",null],[2,"datagrid-row-selected",null]],[[null,"mouseenter"],[null,"mouseleave"],[null,"click"],[null,"dblclick"],[null,"contextmenu"]],function(_v,en,$event){var ad=!0,_co=_v.component;return"mouseenter"===en&&(ad=!1!==(_co.grid.highlightRow=_v.context.$implicit)&&ad),"mouseleave"===en&&(ad=!1!==(_co.grid.highlightRow=null)&&ad),"click"===en&&(ad=!1!==_co.onRowClick(_v.context.$implicit,$event)&&ad),"dblclick"===en&&(ad=!1!==_co.onRowDblClick(_v.context.$implicit,$event)&&ad),"contextmenu"===en&&(ad=!1!==_co.onRowContextMenu(_v.context.$implicit,$event)&&ad),ad},i3.View_TreeGridRowComponent_0,i3.RenderType_TreeGridRowComponent)),i0.ɵdid(2,114688,[["rowRef",4]],0,i4.TreeGridRowComponent,[i2.TreeGridBodyComponent],{row:[0,"row"],prow:[1,"prow"],columns:[2,"columns"],depth:[3,"depth"]},null),(_l()(),i0.ɵand(16777216,null,null,1,null,View_TreeGridChildrenComponent_3)),i0.ɵdid(4,16384,null,0,i5.NgIf,[i0.ViewContainerRef,i0.TemplateRef],{ngIf:[0,"ngIf"]},null),(_l()(),i0.ɵand(0,null,null,0))],function(_ck,_v){var _co=_v.component;_ck(_v,2,0,_v.context.$implicit,_co.prow,_co.columns,_co.depth),_ck(_v,4,0,i0.ɵnov(_v,2).isExpanded()&&_v.context.$implicit.children&&_v.context.$implicit.children.length)},function(_ck,_v){var _co=_v.component;_ck(_v,1,0,_co.grid.isHighlighted(_v.context.$implicit),_co.grid.isSelected(_v.context.$implicit))})}import*as i0 from"@angular/core";import*as i1 from"./treegrid-children.component";import*as i2 from"./treegrid-body.component";import*as i3 from"./treegrid-row.component.ngfactory";import*as i4 from"./treegrid-row.component";import*as i5 from"@angular/common";var styles_TreeGridChildrenComponent=[],RenderType_TreeGridChildrenComponent=i0.ɵcrt({encapsulation:2,styles:styles_TreeGridChildrenComponent,data:{}});export{RenderType_TreeGridChildrenComponent};export function View_TreeGridChildrenComponent_0(_l){return i0.ɵvid(0,[(_l()(),i0.ɵeld(0,0,null,null,6,"table",[["border","0"],["cellpadding","0"],["cellspacing","0"],["class","datagrid-btable"]],null,null,null,null,null)),(_l()(),i0.ɵeld(1,0,null,null,2,"colgroup",[],null,null,null,null,null)),(_l()(),i0.ɵand(16777216,null,null,1,null,View_TreeGridChildrenComponent_1)),i0.ɵdid(3,278528,null,0,i5.NgForOf,[i0.ViewContainerRef,i0.TemplateRef,i0.IterableDiffers],{ngForOf:[0,"ngForOf"]},null),(_l()(),i0.ɵeld(4,0,null,null,2,"tbody",[],null,null,null,null,null)),(_l()(),i0.ɵand(16777216,null,null,1,null,View_TreeGridChildrenComponent_2)),i0.ɵdid(6,278528,null,0,i5.NgForOf,[i0.ViewContainerRef,i0.TemplateRef,i0.IterableDiffers],{ngForOf:[0,"ngForOf"]},null)],function(_ck,_v){var _co=_v.component;_ck(_v,3,0,_co.columns),_ck(_v,6,0,_co.rows)},null)};export function View_TreeGridChildrenComponent_Host_0(_l){return i0.ɵvid(0,[(_l()(),i0.ɵeld(0,0,null,null,1,"div",[["euiTreeGridChildren",""]],null,null,null,View_TreeGridChildrenComponent_0,RenderType_TreeGridChildrenComponent)),i0.ɵdid(1,49152,null,0,i1.TreeGridChildrenComponent,[i2.TreeGridBodyComponent],null,null)],null,null)};var TreeGridChildrenComponentNgFactory=i0.ɵccf("[euiTreeGridChildren]",i1.TreeGridChildrenComponent,View_TreeGridChildrenComponent_Host_0,{rows:"rows",prow:"prow",columns:"columns",depth:"depth"},{},[]);export{TreeGridChildrenComponentNgFactory};