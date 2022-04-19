import { ElementRef } from '@angular/core';
import { ValueAccessorBase } from '../base/value-accessor-base';
export declare const SLIDER_TEMPLATE = "\n\t<div #slider class=\"slider f-full\"\n\t\t\t[class.slider-disabled]=\"disabled\"\n\t\t\t[ngClass]=\"{'f-row slider-v':mode=='v','f-column slider-h':mode=='h'}\">\n\t\t<div #sinner class=\"slider-inner\" (touchstart)=\"doDown($event,sinner)\" (mousedown)=\"doDown($event,sinner)\">\n\t\t\t<a href=\"javascript:;\" class=\"slider-handle\" \n\t\t\t\t\teuiDraggable cursor=\"pointer\"\n\t\t\t\t\t[disabled]=\"disabled\"\n\t\t\t\t\t[axis]=\"mode\"\n\t\t\t\t\t[ngStyle]=\"getPosStyle(value1)\"\n\t\t\t\t\t(drag)=\"onDragHandle($event)\"></a>\n\t\t\t<span *ngIf=\"showTip\" class=\"slider-tip\" [ngStyle]=\"getPosStyle(value1)\">{{value1}}</span>\n\t\t\t<ng-container *ngIf=\"range\">\n\t\t\t<a href=\"javascript:;\" class=\"slider-handle\" \n\t\t\t\t\teuiDraggable cursor=\"pointer\"\n\t\t\t\t\t[disabled]=\"disabled\"\n\t\t\t\t\t[axis]=\"mode\"\n\t\t\t\t\t[ngStyle]=\"getPosStyle(value2)\"\n\t\t\t\t\t(drag)=\"onDragHandle($event,true)\"></a>\n\t\t\t<span *ngIf=\"showTip\" class=\"slider-tip\" [ngStyle]=\"getPosStyle(value2)\">{{value2}}</span>\n\t\t\t</ng-container>\n\t\t</div>\n\t\t<ng-container *ngIf=\"rule.length\">\n\t\t\t<div class=\"slider-rule\">\n\t\t\t\t<span *ngFor=\"let v of displayingRule;let index=index\" [ngStyle]=\"getRuleValueStyle(index)\"></span>\n\t\t\t</div>\n\t\t\t<div class=\"slider-rulelabel\">\n\t\t\t\t<ng-container *ngFor=\"let v of displayingRule;let index=index\">\n\t\t\t\t<span *ngIf=\"v!='|'\" [ngStyle]=\"getRuleValueStyle(index)\">{{v}}</span>\n\t\t\t\t</ng-container>\n\t\t\t</div>\n\t\t</ng-container>\n\t</div>\n";
export declare class SliderComponent extends ValueAccessorBase<any> {
    sliderRef: ElementRef;
    mode: string;
    reversed: boolean;
    showTip: boolean;
    disabled: boolean;
    range: boolean;
    min: number;
    max: number;
    step: number;
    rule: any[];
    readonly value1: any;
    readonly value2: any;
    readonly displayingRule: any[];
    getPosStyle(value: number): {
        left: string;
        top?: undefined;
    } | {
        top: string;
        left?: undefined;
    };
    getRuleValueStyle(index: number): {
        left: string;
        top?: undefined;
    } | {
        top: string;
        left?: undefined;
    };
    onDragHandle(event: any, second?: boolean): void;
    doDown(event: any, sinner: Element): void;
    setPos(pos: number, second?: boolean): number;
    value2pos(value: number): number;
    pos2value(pos: number): number;
}
