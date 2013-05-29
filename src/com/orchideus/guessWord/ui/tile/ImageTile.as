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
import starling.textures.Texture;
import starling.utils.AssetManager;

public class ImageTile extends Sprite {

    public static const scaleAmount: Number = 0.492;
    public static const delay: Number = 0.2;

    private var _zoomed: Boolean;
    public function get zoomed():Boolean {
        return _zoomed;
    }

    private var _border: Image;
    private var _image: Image;

    public function ImageTile(assets: AssetManager) {
        _border = new Image(assets.getTexture("pic_under_big"));
        addChild(_border);

        _image = new Image(Texture.empty());
        _image.x = 8;
        _image.y = 8;

        scaleX = scaleY = scaleAmount;
    }

    public function init(url: String):void {
        var loader:Loader = new Loader();
        loader.load(new URLRequest(url));
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
    }

    public function scale(animated: Boolean = true):void {
        var newScale: Number = _zoomed ? scaleAmount : 1;
        Starling.juggler.tween(this, animated ? delay : 0, {scaleX: newScale, scaleY: newScale});
        _zoomed = !_zoomed;
    }

    private function onComplete(event: Event):void {
        var loadedBitmap: Bitmap = event.currentTarget.loader.content as Bitmap;
        var texture: Texture = Texture.fromBitmap(loadedBitmap);

        _image.texture = texture;
        _image.readjustSize();
        _image.width = 580;
        _image.height = 583;
        addChild(_image);
    }
}
}
