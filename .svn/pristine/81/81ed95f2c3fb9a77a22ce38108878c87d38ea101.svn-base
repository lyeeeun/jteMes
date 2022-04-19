import { ElementRef } from '@angular/core';
import { GridColumnComponent } from './grid-column.component';
export declare const GRID_FOOTER_TEMPLATE = "\n\t<div class=\"datagrid-footer f-row\">\n\t\t<div #footer class=\"datagrid-footer-inner f-full\" id=\"f1\">\n\t\t\t<table class=\"datagrid-ftable\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n\t\t\t\t<colgroup>\n\t\t\t\t\t<col *ngFor=\"let col of columns\" [style.width]=\"col.width\">\n\t\t\t\t</colgroup>\n\t\t\t\t<tbody>\n\t\t\t\t\t<ng-container *ngFor=\"let row of rows;let rowIndex=index\">\n\t\t\t\t\t<tr class=\"datagrid-row\">\n\t\t\t\t\t\t<td *ngFor=\"let col of columns\">\n\t\t\t\t\t\t\t<div class=\"datagrid-cell\" [style.textAlign]=\"col.align || null\">\n\t\t\t\t\t\t\t\t<ng-container *ngIf=\"!col.footerTemplate\">{{row[col.field]}}</ng-container>\n\t\t\t\t\t\t\t\t<ng-template *ngIf=\"col.footerTemplate\" [euiGridCellTemplate]=\"col.footerTemplate.template\" [row]=\"row\" [rowIndex]=\"rowIndex\" [column]=\"col\"></ng-template>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t</td>\n\t\t\t\t\t</tr>\n\t\t\t\t\t</ng-container>\n\t\t\t\t</tbody>\n\t\t\t</table>\n\t\t</div>\n\t\t<div *ngIf=\"paddingWidth\" class=\"datagrid-header f-noshrink\" [style.width.px]=\"paddingWidth\"></div>\n\t</div>\n";
export declare class GridFooterComponent {
    footerRef: ElementRef;
    columns: GridColumnComponent[];
    rows: any[];
    paddingWidth: number;
    private _scrollLeft;
    scrollLeft: number;
}
