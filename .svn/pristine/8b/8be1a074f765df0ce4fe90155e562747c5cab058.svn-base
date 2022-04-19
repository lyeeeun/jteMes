import { EventEmitter } from '@angular/core';
import { GridBodyComponent } from '../gridbase/grid-body.component';
import { DataGridViewComponent } from './datagrid-view.component';
import { VirtualScrollComponent } from '../base/virtual-scroll.component';
export declare const DATAGRID_BODY_TEMPLATE = "\n\t<div #body class=\"datagrid-body f-full\" style=\"margin-top:0\"\n\t\t\t[ngClass]=\"{'datagrid-vbody f-column':isVirtualScroll}\"\n\t\t\t(scroll)=\"onScroll($event)\">\n\t\t<div #inner class=\"datagrid-body-inner\"\n\t\t\t\t[style.marginTop.px]=\"marginTop\"\n\t\t\t\t[ngClass]=\"{'f-column f-full panel-noscroll':isVirtualScroll}\">\n\t\t\t<ng-container *ngIf=\"!isVirtualScroll\">\n\t\t\t\t<table class=\"datagrid-btable\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"\n\t\t\t\t\t\teuiDataGridTable [columns]=\"columns\" [rows]=\"currRows\">\n\t\t\t\t</table>\n\t\t\t</ng-container>\n\t\t\t<ng-container *ngIf=\"isVirtualScroll\">\n\t\t\t\t<eui-virtual-scroll #vscroll \n\t\t\t\t\t\t[data]=\"rows\" \n\t\t\t\t\t\t[total]=\"view.grid.total\" \n\t\t\t\t\t\t[pageSize]=\"view.grid.pageSize\" \n\t\t\t\t\t\t[rowHeight]=\"view.grid.rowHeight\" \n\t\t\t\t\t\t[lazy]=\"view.grid.lazy\"\n\t\t\t\t\t\t[pageNumber]=\"view.grid.pageNumber\"\n\t\t\t\t\t\t(update)=\"onVirtualPageUpdate($event)\"\n\t\t\t\t\t\t(bodyScroll)=\"onVirtualScroll($event)\"\n\t\t\t\t\t\t(pageChange)=\"onVirtualPageChange($event)\">\n\t\t\t\t<table class=\"datagrid-btable\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"\n\t\t\t\t\t\teuiDataGridTable [columns]=\"columns\" [rows]=\"currRows\">\n\t\t\t\t</table>\n\t\t\t\t</eui-virtual-scroll>\n\t\t\t</ng-container>\n\t\t</div>\n\t</div>\n";
export declare class DataGridBodyComponent extends GridBodyComponent {
    view: DataGridViewComponent;
    vscroll: VirtualScrollComponent;
    virtualPageChange: EventEmitter<{}>;
    virtualPageUpdate: EventEmitter<{}>;
    marginTop: number;
    currRows: any[];
    _rows: any[];
    rows: any[];
    readonly isVirtualScroll: boolean;
    scrollTop: number;
    scrollLeft: number;
    onVirtualScroll(event: any): void;
    onVirtualPageChange(event: any): void;
    onVirtualPageUpdate(event: any): void;
    readonly scrollbarWidth: number;
    constructor(view: DataGridViewComponent);
}
