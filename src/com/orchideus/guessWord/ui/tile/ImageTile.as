/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 13:56
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.core.Starling;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starling.textures.Texture;

public class ImageTile extends Sprite {

    private var _preview: Boolean;

    public function ImageTile(url: String) {
        var loader:Loader = new Loader();
        loader.load(new URLRequest(url));
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);

        scale(false);
        addEventListener(TouchEvent.TOUCH, handleTouch);
    }

    public function scale(animated: Boolean = true):void {
        var newScale: Number = _preview ? 1 : 0.48;
        Starling.juggler.tween(this, animated ? 0.2 : 0, {scaleX: newScale, scaleY: newScale});
        _preview = !_preview;
    }

    private function handleTouch(event:TouchEvent):void {
        var touch: Touch = event.getTouch(this, TouchPhase.ENDED);
        if (touch) {
            parent.addChild(this);
            scale();
        }
    }

    private function onComplete(event: Event):void {
        var loadedBitmap: Bitmap = event.currentTarget.loader.content as Bitmap;
        var texture: Texture = Texture.fromBitmap(loadedBitmap);

        var image: Image = new Image(texture);
        addChild(image);
    }
}
}
