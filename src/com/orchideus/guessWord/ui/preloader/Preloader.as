/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:55
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.preloader {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.ui.abstract.Screen;

import flash.filters.GlowFilter;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.Gauge;
import starling.text.TextField;
import starling.utils.AssetManager;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Preloader extends Screen {

    private var _controller: GameController;

    private var _logo: Image;
    private var _title: Image;

    private var _progress: Gauge;
    private var _progressTF: TextField;

    private var _langs: Sprite;


    public function Preloader(assets: AssetManager, deviceType: DeviceType, controller: GameController) {
        _controller = controller;
        _controller.addEventListener(GameController.PROGRESS, handleProgress);

        super(assets, deviceType, "preloader_under");
    }

    override protected function initialize():void {
        _logo = new Image(_assets.getTexture("preloader_duck"));
        addChild(_logo);

        _title = new Image(_assets.getTexture("preloader_logo_rus"));
        addChild(_title);

        _progress = new Gauge(_assets.getTexture("preloader_filler"));
        _progress.ratioH = 0;
        addChild(_progress);

        _progressTF = new TextField(100, 25, "-------", "Arial", 20, 0xFFFFFF, true);
        _progressTF.nativeFilters = [new GlowFilter(0x424242, 1, 3, 3, 3, 3)];
        _progressTF.hAlign = HAlign.CENTER;
        _progressTF.vAlign = VAlign.TOP;
        _progressTF.text = "";
        addChild(_progressTF);

        _langs = new Sprite();
        addChild(_langs);

        if (!_controller.player.lang) {
            showLanguage();
        }
    }

    override protected function align():void {
        super.align();

        switch (_deviceType) {
            case DeviceType.iPad:
                place(_logo, 30, 30);
                place(_title, 22, 100);
                place(_progress, 242, 418);
                place(_progressTF, 334, 432);
                _progressTF.fontSize = 20;
                place(_langs, 25, 780);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(this, 0, (stage.stageHeight-_background.height)/2);
                place(_logo, 125, (stage.stageHeight-_logo.height) - 10 - y);
                place(_title, 22, 100);
                place(_progress, 100, 218);
                place(_progressTF, 110, 221);
                _progressTF.fontSize = 12;
                place(_langs, 12, 395);
                break;
        }
    }

    private function showLanguage():void {
        for (var i:int = 0; i < Language.languages.length; i++) {
            var lang: Language = Language.languages[i];
            var tile: LanguageTile = new LanguageTile(i, lang, _assets, _deviceType);
            tile.addEventListener(TouchEvent.TOUCH, handleSelectLanguage);
            _langs.addChild(tile);
        }
    }

    private function handleSelectLanguage(event: TouchEvent):void {
        var tile: LanguageTile = event.currentTarget as LanguageTile;
        if (event.getTouch(tile, TouchPhase.ENDED)) {
            dispatchEventWith(Language.LANGUAGE, true, tile.lang);
        }
    }

    private function handleProgress(event: Event):void {
        var value: Number = event.data as Number;
        _progress.ratioH = value;
        _progressTF.text = String(int(value*100))+"%";
    }

    override public function destroy():void {
        removeChild(_logo, true);
        _logo = null;

        removeChild(_progress, true);
        _progress = null;

        removeChild(_progressTF, true);
        _progressTF = null;

        while (_langs.numChildren>0) {
            var tile: LanguageTile = _langs.getChildAt(0) as LanguageTile;
            tile.removeEventListener(TouchEvent.TOUCH, handleSelectLanguage);
            tile.destroy();
            _langs.removeChild(tile);
        }

        removeChild(_langs, true);
        _langs = null;
    }
}
}