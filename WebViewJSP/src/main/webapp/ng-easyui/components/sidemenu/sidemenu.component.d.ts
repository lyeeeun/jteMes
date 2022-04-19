import { EventEmitter, QueryList } from "@angular/core";
import { TooltipContentComponent } from "../tooltip/tooltip-content.component";
export declare class SideMenuComponent {
    tipContents: QueryList<TooltipContentComponent>;
    collapsed: boolean;
    border: boolean;
    animate: boolean;
    multiple: boolean;
    floatMenuWidth: number;
    floatMenuPosition: string;
    selection: any;
    itemClick: EventEmitter<{}>;
    selectionChange: EventEmitter<{}>;
    _data: any;
    data: any;
    onSelectionChange(node: any): void;
    onNodeClick(node: any): void;
}
