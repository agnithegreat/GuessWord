/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:55
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.preloader {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.ui.abstract.Screen;

import flash.filters.GlowFilter;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.Gauge;
import starling.text.TextField;
import starling.utils.AssetManager;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Preloader extends Screen {

    public static const SELECT_LANGUAGE: String = "select_language_Preloader";

    private var _progress: Gauge;
    private var _progressTF: TextField;

    private var _logo: Image;
    private var _langs: Sprite;

    public function Preloader(assets: AssetManager, deviceType: DeviceType) {
        super(assets, deviceType, "preloader_under");
    }

    public function init(language: String):void {
        _progress = new Gauge(_assets.getTexture("preloader_filler"));
        _progress.x = stage.stageWidth/2;
        _progress.y = 418;
        _progress.pivotX = 142;
        _progress.ratioH = 0;
        addChild(_progress);

        _progressTF = new TextField(100, 25, "-------", "Arial", 20, 0xFFFFFF, true);
        _progressTF.nativeFilters = [new GlowFilter(0x424242, 1, 3, 3, 3, 3)];
        _progressTF.x = stage.stageWidth/2;
        _progressTF.y = 432;
        _progressTF.pivotX = _progressTF.width/2;
        _progressTF.hAlign = HAlign.CENTER;
        _progressTF.vAlign = VAlign.TOP;
        _progressTF.text = "";
        addChild(_progressTF);

        if (!language) {
            showLanguage();
        }
    }

    private function showLanguage():void {
        _logo = new Image(_assets.getTexture("DUCK_ico"));
        _logo.x = 30;
        _logo.y = 30;
        addChild(_logo);

        _langs = new Sprite();
        _langs.x = 25;
        _langs.y = 780;
        addChild(_langs);

        for (var i:int = 0; i < Language.languages.length; i++) {
            var lang: Language = Language.languages[i];
            var tile: LanguageTile = new LanguageTile(lang, _assets);
            tile.addEventListener(TouchEvent.TOUCH, handleSelectLanguage);
            tile.x = i<6 ? (i%3) * 255 : 255;
            tile.y = int(i/3) * 85;
            _langs.addChild(tile);
        }
    }

    public function setProgress(value: Number):void {
        _progress.ratioH = value;
        _progressTF.text = String(int(value*100))+"%";
    }

    private function handleSelectLanguage(event: TouchEvent):void {
        var tile: LanguageTile = event.currentTarget as LanguageTile;
        if (event.getTouch(tile, TouchPhase.ENDED)) {
            dispatchEventWith(SELECT_LANGUAGE, false, tile.lang);
        }
    }

    override public function destroy():void {
        removeChild(_progress, true);
        _progress = null;

        removeChild(_progressTF, true);
        _progressTF = null;

        if (_langs) {
            removeChild(_logo, true);
            _logo = null;

            while (_langs.numChildren>0) {
                var tile: LanguageTile = _langs.getChildAt(0) as LanguageTile;
                tile.removeEventListener(TouchEvent.TOUCH, handleSelectLanguage);
                tile.destroy();
            }

            removeChild(_langs, true);
            _langs = null;
        }
    }
}
}