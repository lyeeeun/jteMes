import { ElementRef, Renderer2, EventEmitter } from '@angular/core';
export declare class ResizableDirective {
    hostRef: ElementRef;
    renderer: Renderer2;
    disabled: boolean;
    handles: string;
    edge: number;
    minWidth: number;
    minHeight: number;
    maxWidth: number;
    maxHeight: number;
    resizeStart: EventEmitter<{}>;
    resizing: EventEmitter<{}>;
    resizeStop: EventEmitter<{}>;
    isResizing: boolean;
    state: any;
    mousemoveListener: Function;
    mouseupListener: Function;
    touchmoveListener: Function;
    touchendListener: Function;
    constructor(hostRef: ElementRef, renderer: Renderer2);
    parseEvent(event: any): any;
    onMouseDown(event: any): void;
    onMouseMove(event: any): void;
    onMouseLeave(event: any): void;
    doMove(event: any): boolean;
    doUp(event: any): boolean;
    bindDocumentEvents(): void;
    unbindDocumentEvents(): void;
    getDirection(e: any): string;
    doResize(e: any): void;
    applySize(): void;
}