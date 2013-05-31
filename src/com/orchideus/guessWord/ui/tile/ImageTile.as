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
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.AssetManager;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class ImageTile extends Sprite {

    public static const scaleAmount: Number = 0.492;
    public static const delay: Number = 0.2;

    private var _zoomed: Boolean;
    public function get zoomed():Boolean {
        return _zoomed;
    }

    private var _border: Image;
    private var _image: Image;

    private var _hide: Quad;
    private var _description: TextField;

    public function ImageTile(assets: AssetManager) {
        _border = new Image(assets.getTexture("pic_under_big"));
        addChild(_border);

        _image = new Image(Texture.empty());
        _image.x = 8;
        _image.y = 8;

        scaleX = scaleY = scaleAmount;

        _hide = new Quad(580, 583, 0);
        _hide.x = 8;
        _hide.y = 8;
        _hide.alpha = 0.5;

        _description = new TextField(564, 567, "", "Arial", 42, 0xFFFFFF, true);
        _description.x = 16;
        _description.y = 16;
        _description.hAlign = HAlign.LEFT;
        _description.vAlign = VAlign.CENTER;
    }

    public function init(url: String):void {
        var loader:Loader = new Loader();
        loader.load(new URLRequest(url));
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);

        if (_hide.parent) {
            removeChild(_hide);
            removeChild(_description);
        }
    }

    public function showDescription(title: String):void {
        _description.text = title;

        addChild(_hide);
        addChild(_description);
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
