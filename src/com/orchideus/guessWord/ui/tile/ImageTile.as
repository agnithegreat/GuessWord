/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 13:56
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Pic;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Quad;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.AssetManager;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class ImageTile extends AbstractView {

    public static const scaleAmount: Number = 0.496;
    public static const delay: Number = 0.2;

    private var _pic: Pic;

    private var _zoomed: Boolean;
    public function get zoomed():Boolean {
        return _zoomed;
    }

    private var _border: Image;
    private var _image: Image;

    private var _hide: Quad;
    private var _description: TextField;

    public function ImageTile(assets: AssetManager, deviceType: DeviceType, pic: Pic) {
        _pic = pic;

        super(assets, deviceType);
    }

    override protected function initialize():void {
        _border = new Image(_assets.getTexture("main_big_pic_under"));
        addChild(_border);

        _image = new Image(Texture.empty());
        _image.x = _border.width*0.02;
        _image.y = _border.height*0.02;

        scaleX = scaleY = scaleAmount;

        _hide = new Quad(_border.width*0.96, _border.height*0.96, 0);
        _hide.x = _border.width*0.02;
        _hide.y = _border.height*0.02;
        _hide.alpha = 0.5;

        _description = new TextField(_border.width*0.92, _border.height*0.92, "", "Arial", 42, 0xFFFFFF, true);
        _description.x = _border.width*0.04;
        _description.y = _border.height*0.04;
        _description.hAlign = HAlign.LEFT;
        _description.vAlign = VAlign.CENTER;
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                _description.fontSize = 42;
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                _description.fontSize = 20;
                break;
        }
    }

    public function load():void {
        var loader:Loader = new Loader();
        loader.load(new URLRequest(_pic.url));
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);

        if (_image.parent) {
            removeChild(_image);
        }
        hideDescription();
    }

    public function scale(animated: Boolean = true):void {
        var newScale: Number = _zoomed ? scaleAmount : 1;
        Starling.juggler.tween(this, animated ? delay : 0, {scaleX: newScale, scaleY: newScale});
        _zoomed = !_zoomed;
    }

    public function showDescription():void {
        _description.text = _pic.description;

        addChild(_hide);
        addChild(_description);
    }

    public function hideDescription():void {
        if (_hide.parent) {
            removeChild(_hide);
            removeChild(_description);
        }
    }

    private function onComplete(event: Event):void {
        var loadedBitmap: Bitmap = event.currentTarget.loader.content as Bitmap;
        var texture: Texture = Texture.fromBitmap(loadedBitmap);

        _image.texture = texture;
        _image.readjustSize();
        _image.width = _border.width*0.96;
        _image.height = _border.height*0.96;
        addChild(_image);
    }
}
}
