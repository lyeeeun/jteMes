import { ElementRef } from '@angular/core';
import { ListBaseComponent } from '../base/list-base.component';
import { VirtualScrollComponent } from '../base/virtual-scroll.component';
import { ItemTemplateDirective } from '../base/template-base';
export declare const DATALIST_TEMPLATE = "\n\t<div class=\"panel-body panel-body-noheader datagrid f-full f-column\" \n\t\t\t[class.panel-body-noborder]=\"!border\">\n\t\t<eui-pagination *ngIf=\"pagination && (pagePosition=='both' || pagePosition=='top')\" class=\"datagrid-pager datagrid-pager-top f-noshrink\" \n\t\t\t\t[total]=\"total\" \n\t\t\t\t[pageSize]=\"pageSize\" \n\t\t\t\t[pageNumber]=\"pageNumber\" \n\t\t\t\t[loading]=\"loading\"\n\t\t\t\t[pageOptions]=\"pageOptions\"\n\t\t\t\t(pageChange)=\"onPageChange($event)\"></eui-pagination>\n\t\t<div #inner class=\"f-full\" [class.f-column]=\"virtualScroll\" [style.overflow]=\"virtualScroll ? 'hidden' : 'auto'\">\n\t\t\t<ng-container *ngIf=\"!virtualScroll\">\n\t\t\t\t<div *ngFor=\"let row of rows;let rowIndex=index\"\n\t\t\t\t\t\t[ngStyle]=\"itemStyle\"\n\t\t\t\t\t\t[ngClass]=\"getItemClass(row)\"\n\t\t\t\t\t\t(mouseenter)=\"highlightRow=row\"\n\t\t\t\t\t\t(mouseleave)=\"highlightRow=null\"\n\t\t\t\t\t\t(click)=\"onRowClick(row,$event)\">\n\t\t\t\t\t<ng-template [euiDataListItemTemplate]=\"itemTemplate.template\" [row]=\"row\" [rowIndex]=\"getRowIndex(rowIndex)\"></ng-template>\n\t\t\t\t</div>\n\t\t\t</ng-container>\n\t\t\t<ng-container *ngIf=\"virtualScroll\">\n\t\t\t\t<eui-virtual-scroll #vscroll class=\"f-full\"\n\t\t\t\t\t\t[data]=\"rows\" \n\t\t\t\t\t\t[total]=\"total\" \n\t\t\t\t\t\t[pageNumber]=\"pageNumber\"\n\t\t\t\t\t\t[pageSize]=\"pageSize\" \n\t\t\t\t\t\t[rowHeight]=\"rowHeight\" \n\t\t\t\t\t\t[lazy]=\"lazy\"\n\t\t\t\t\t\t(update)=\"rows1 = $event\"\n\t\t\t\t\t\t(pageChange)=\"onVirtualPageChange($event)\">\n\t\t\t\t\t<div *ngFor=\"let row of rows1;let rowIndex=index\"\n\t\t\t\t\t\t\t[style.height.px]=\"rowHeight\"\n\t\t\t\t\t\t\t[ngStyle]=\"itemStyle\"\n\t\t\t\t\t\t\t[ngClass]=\"getItemClass(row)\"\n\t\t\t\t\t\t\t(mouseenter)=\"highlightRow=row\"\n\t\t\t\t\t\t\t(mouseleave)=\"highlightRow=null\"\n\t\t\t\t\t\t\t(click)=\"onRowClick(row,$event)\">\n\t\t\t\t\t\t<ng-template [euiDataListItemTemplate]=\"itemTemplate.template\" [row]=\"row\" [rowIndex]=\"getRowIndex(rowIndex)\"></ng-template>\n\t\t\t\t\t</div>\n\t\t\t\t</eui-virtual-scroll>\n\t\t\t</ng-container>\n\t\t</div>\n\t\t<eui-pagination *ngIf=\"pagination && (pagePosition=='both' || pagePosition=='bottom')\" class=\"datagrid-pager f-noshrink\" \n\t\t\t\t[total]=\"total\" \n\t\t\t\t[pageSize]=\"pageSize\" \n\t\t\t\t[pageNumber]=\"pageNumber\" \n\t\t\t\t[loading]=\"loading\"\n\t\t\t\t[pageOptions]=\"pageOptions\"\n\t\t\t\t(pageChange)=\"onPageChange($event)\"></eui-pagination>\n\t</div>\n\t<div *ngIf=\"loading\" class=\"datagrid-loading f-row\">\n\t\t<div class=\"datagrid-mask\"></div>\n\t\t<div class=\"datagrid-mask-msg\">{{loadMsg}}</div>\n\t</div>\n";
export declare class DataListComponent extends ListBaseComponent {
    vscroll: VirtualScrollComponent;
    innerRef: ElementRef;
    itemTemplate: ItemTemplateDirective;
    itemStyle: Object;
    itemCls: string;
    hoverCls: string;
    selectedCls: string;
    rows1: any[];
    getItemClass(row: any): string;
    getRowIndex(index: number): number;
    scrollTop: number;
    navRow(step: number): void;
    highlightFirstRow(): void;
    scrollToSelectedRow(): void;
}
