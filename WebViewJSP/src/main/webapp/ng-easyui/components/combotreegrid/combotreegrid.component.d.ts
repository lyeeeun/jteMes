import { ComboBaseComponent } from "../base/combo-base.component";
import { TreeGridComponent } from "../treegrid/treegrid.component";
export declare const COMBOTREEGRID_TEMPLATE: string;
export declare class ComboTreeGridComponent extends ComboBaseComponent<any> {
    treegrid: TreeGridComponent;
    valueField: string;
    textField: string;
    editable: boolean;
    timer: any;
    mappingTexts: {};
    displayingText: string;
    inputingText: string;
    treegridScrollTop: number;
    private updatingText;
    private _data;
    private _text;
    data: any[];
    text: string;
    private _multiple;
    multiple: boolean;
    ngAfterContentInit(): void;
    doFilter(value: string): void;
    openPanel(): void;
    closePanel(): void;
    updateText(): void;
    findRow(value: any): any;
}
