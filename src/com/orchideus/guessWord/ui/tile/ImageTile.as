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
import starling.display.Shape;

import starling.textures.Texture;

public class ImageTile extends Shape {

    public static const scaleAmount: Number = 0.493;
    public static const delay: Number = 0.2;

    private var _zoomed: Boolean;
    public function get zoomed():Boolean {
        return _zoomed;
    }

    private var _image: Image;

    public function ImageTile() {
        _image = new Image(Texture.empty());
    }

    public function init(url: String):void {
        var loader:Loader = new Loader();
        loader.load(new URLRequest(url));
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
    }

    public function scale(animated: Boolean = true):void {
        var newScale: Number = _zoomed ? scaleAmount : 1;
        Starling.juggler.tween(this, animated ? delay : 0, {scaleX: newScale, scaleY: newScale, onUpdate: updateGraphics});
        _zoomed = !_zoomed;
    }

    private function updateGraphics():void {
        graphics.clear();

        addChild(_image);

        graphics.lineStyle(1/scaleX, 0xFFFFFF);
        graphics.drawRoundRect(0,0,_image.width,_image.height,1/scaleX);
        graphics.endFill();
    }

    private function onComplete(event: Event):void {
        var loadedBitmap: Bitmap = event.currentTarget.loader.content as Bitmap;
        var texture: Texture = Texture.fromBitmap(loadedBitmap);

        _image.texture = texture;
        _image.readjustSize();

        scaleX = scaleY = scaleAmount;
        updateGraphics();
    }
}
}
