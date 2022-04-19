import { ElementRef } from '@angular/core';
import { TabsComponent } from './tabs.component';
import { HeaderTemplateDirective } from '../base/template-base';
import { PanelComponent } from '../panel/panel.component';
export declare class TabPanelComponent extends PanelComponent {
    tabs: TabsComponent;
    hostRef: ElementRef;
    headerTemplate: HeaderTemplateDirective;
    selected: boolean;
    showHeader: boolean;
    border: boolean;
    disabled: boolean;
    closable: boolean;
    isFirst: boolean;
    isLast: boolean;
    isUsed: boolean;
    constructor(tabs: TabsComponent, hostRef: ElementRef);
    select(): void;
    unselect(): void;
    close(): void;
}
