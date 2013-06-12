/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 14:46
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.abstract {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.DeviceType;

import starling.display.DisplayObject;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

public class AbstractView extends Sprite {

    public static function createTextField(width: int, height: int, size: int, text: String = "", color: int = 0xFFFFFF):TextField {
        return new TextField(width, height, text, "Arial", size, color, true);
    }

    protected var _refs: CommonRefs;

    public function AbstractView(refs: CommonRefs) {
        _refs = refs;

        addEventListener(Event.ADDED_TO_STAGE, handleAdded);
    }

    protected function initialize():void {
        if (_refs.device == DeviceType.iPad) {
            initializeIPad();
        } else {
            initializeIPhone();
        }
    }

    protected function align():void {

    }

    protected function resize(object: DisplayObject, width: int, height: int):void {
        object.width = width;
        object.height = height;
    }

    protected function place(object: DisplayObject, x: int, y: int):void {
        object.x = x;
        object.y = y;
    }

    protected function initializeIPad():void {

    }

    protected function initializeIPhone():void {

    }

    private function handleAdded(event: Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, handleAdded);

        initialize();
        align();
    }

    public function destroy():void {
        _refs = null;
    }
}
}
