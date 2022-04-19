import { EventEmitter } from '@angular/core';
import { GridBaseComponent } from '../gridbase/grid-base.component';
export declare const TREEGRID_TEMPLATE = "\n\t<div class=\"panel-body panel-body-noheader datagrid datagrid-wrap f-full f-column\" \n\t\t\t[class.panel-body-noborder]=\"!border\">\n\t\t<eui-pagination *ngIf=\"pagination && (pagePosition=='both' || pagePosition=='top')\" class=\"datagrid-pager datagrid-pager-top f-noshrink\" \n\t\t\t\t[total]=\"total\" \n\t\t\t\t[pageSize]=\"pageSize\" \n\t\t\t\t[pageNumber]=\"pageNumber\" \n\t\t\t\t[loading]=\"loading\"\n\t\t\t\t(pageChange)=\"onPageChange($event)\"></eui-pagination>\n\t\t<div #view class=\"datagrid-view f-row f-full\">\n\t\t\t<eui-treegrid-view #view1 *ngIf=\"leftGroup || leftColumns\" \n\t\t\t\t\t[viewIndex]=\"1\" \n\t\t\t\t\t[columnGroup]=\"leftGroup\" \n\t\t\t\t\t[columns]=\"leftColumns\" \n\t\t\t\t\t[rows]=\"rows\" \n\t\t\t\t\t[footerRows]=\"footerRows\"\n\t\t\t\t\t[style.width]=\"leftFrozenWidth\"></eui-treegrid-view>\n\t\t\t<eui-treegrid-view #view2 \n\t\t\t\t\t[viewIndex]=\"2\" \n\t\t\t\t\t[columnGroup]=\"centerGroup\" \n\t\t\t\t\t[columns]=\"centerColumns\" \n\t\t\t\t\t[rows]=\"rows\"\n\t\t\t\t\t[footerRows]=\"footerRows\"\n\t\t\t\t\t(bodyScroll)=\"onBodyScroll($event)\"></eui-treegrid-view>\n\t\t\t<eui-treegrid-view #view3 *ngIf=\"rightGroup || rightColumns\" \n\t\t\t\t\t[viewIndex]=\"3\" \n\t\t\t\t\t[columnGroup]=\"rightGroup\" \n\t\t\t\t\t[columns]=\"rightColumns\" \n\t\t\t\t\t[rows]=\"rows\" \n\t\t\t\t\t[footerRows]=\"footerRows\"\n\t\t\t\t\t[style.width]=\"rightFrozenWidth\"></eui-treegrid-view>\n\t\t</div>\n\t\t<eui-pagination *ngIf=\"pagination && (pagePosition=='both' || pagePosition=='bottom')\" class=\"datagrid-pager f-noshrink\" \n\t\t\t\t[total]=\"total\" \n\t\t\t\t[pageSize]=\"pageSize\" \n\t\t\t\t[pageNumber]=\"pageNumber\" \n\t\t\t\t[loading]=\"loading\"\n\t\t\t\t(pageChange)=\"onPageChange($event)\"></eui-pagination>\n\t</div>\n\t<div *ngIf=\"loading\" class=\"datagrid-loading f-row\">\n\t\t<div class=\"datagrid-mask\"></div>\n\t\t<div class=\"datagrid-mask-msg\">{{loadMsg}}</div>\n\t</div>\n";
export declare class TreeGridComponent extends GridBaseComponent {
    idField: string;
    treeField: string;
    selectionMode: string;
    checkbox: boolean;
    cascadeCheck: boolean;
    rowExpand: EventEmitter<{}>;
    rowCollapse: EventEmitter<{}>;
    rowCheck: EventEmitter<{}>;
    rowUncheck: EventEmitter<{}>;
    scrollTop: number;
    readonly checkedRows: any[];
    getCheckedRows(state?: string): any[];
    selectRow(row: any): void;
    checkRow(row: any): void;
    uncheckRow(row: any): void;
    uncheckAllRows(): void;
    adjustCheck(row: any): void;
    sortData(): void;
}
