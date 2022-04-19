import { QueryList, ElementRef } from '@angular/core';
import { LayoutPanelComponent } from './layout-panel.component';
export declare const LAYOUT_TEMPLATE = "\n\t<div #layout class=\"layout\" \n\t\t\t[style.padding]=\"paddings\"\n\t\t\t[ngClass]=\"layoutCls\"\n\t\t\t[ngStyle]=\"layoutStyle\">\n\t\t<ng-content></ng-content>\n\t</div>\n";
export declare class LayoutComponent {
    layoutRef: ElementRef;
    panels: QueryList<LayoutPanelComponent>;
    layoutCls: string;
    layoutStyle: Object;
    paddings: any;
    paddingLeft: number;
    paddingRight: number;
    paddingTop: number;
    paddingBottom: number;
    ngAfterContentInit(): void;
    getPanel(region: string): LayoutPanelComponent;
    getPaddingValue(region: any): number;
    updatePaddings(): void;
    resize(): void;
}
