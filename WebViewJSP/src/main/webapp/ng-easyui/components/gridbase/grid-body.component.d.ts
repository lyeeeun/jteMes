import { ElementRef, EventEmitter } from '@angular/core';
import { GridColumnComponent } from './grid-column.component';
export declare const GRIDBASE_BODY_TEMPLATE = "\n\t<div #body class=\"datagrid-body f-full\" (scroll)=\"onScroll($event)\">\n\t\t<div #inner class=\"datagrid-body-inner\">\n\t\t</div>\n\t</div>\n";
export declare class GridBodyComponent {
    bodyRef: ElementRef;
    innerRef: ElementRef;
    columns: GridColumnComponent[];
    rows: any[];
    bodyScroll: EventEmitter<{}>;
    private _scrollTop;
    scrollTop: number;
    scrollLeft: number;
    onScroll(event: any): void;
    readonly scrollbarWidth: number;
}
