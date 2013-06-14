/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 13:56
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Pic;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.ImageDecodingPolicy;
import flash.system.LoaderContext;

import starling.core.Starling;
import starling.display.Image;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class ImageTile extends AbstractView {

    public static var scaleAmount: Number = 0.496;
    public static const delay: Number = 0.2;

    private static var context: LoaderContext;

    private var _pic: Pic;
    public function get pic():Pic {
        return _pic;
    }

    private var _zoomed: Boolean;
    public function get zoomed():Boolean {
        return _zoomed;
    }

    private var _border: Image;
    private var _image: Image;

    private var _description: TextField;
    private var _changeTF: TextField;

    public function ImageTile(refs: CommonRefs, pic: Pic) {
        if (!context) {
            context = new LoaderContext();
            context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
        }
        _pic = pic;

        super(refs);
    }

    override protected function initialize():void {
        _border = new Image(_refs.assets.getTexture("main_big_pic_under"));
        addChild(_border);

        _image = new Image(Texture.empty());

        super.initialize();

        _description.touchable = false;
        _description.hAlign = HAlign.LEFT;
        _description.vAlign = VAlign.CENTER;

        _changeTF.touchable = false;
        _changeTF.text = _refs.locale.getString("main.image.change");

        scaleX = scaleY = scaleAmount;
    }

    override protected function initializeIPad():void {
        _image.x = 9;
        _image.y = 8;

        _description = createTextField(_border.width*0.9, _border.height*0.9, 42);
        _description.x = 18;
        _description.y = 16;

        _changeTF = createTextField(_border.width*0.9, _border.height*0.9, 60);
        _changeTF.x = 18;
        _changeTF.y = 16;

        scaleAmount = 0.493;
    }

    override protected function initializeIPhone():void {
        _image.x = 5;
        _image.y = 5;

        _description = createTextField(_border.width*0.9, _border.height*0.9, 20);
        _description.x = 10;
        _description.y = 10;

        _changeTF = createTextField(_border.width*0.9, _border.height*0.9, 28);
        _changeTF.x = 10;
        _changeTF.y = 10;

        scaleAmount = 0.496;
    }

    public function load():void {
        var loader:Loader = new Loader();
        loader.load(new URLRequest(_pic.url), context);
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

        _image.color = 0x666666;

        addChild(_description);
    }
    public function hideDescription():void {
        _image.color = 0xFFFFFF;
        removeChild(_description);
    }

    public function showSelectImage():void {
        _image.color = 0x666666;

        addChild(_changeTF);
    }
    public function hideSelectImage():void {
        _image.color = 0xFFFFFF;
        if (_changeTF.parent) {
            removeChild(_changeTF);
        }
    }

    private function onComplete(event: Event):void {
        var loadedBitmap: Bitmap = event.currentTarget.loader.content as Bitmap;
        var texture: Texture = Texture.fromBitmap(loadedBitmap);

        _image.texture = texture;
        _image.readjustSize();
        _image.width = _border.width-_image.x*2;
        _image.height = _border.height-_image.y*2;
        addChild(_image);
    }
}
}
