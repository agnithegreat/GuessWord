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
        _controller.addEventListener(GameController.SHOW_LANGUAGES, handleShowLanguages);

        super(assets, deviceType, "preloader_under");

        // TODO: localization
        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _logo = new Image(_assets.getTexture("preloader_duck"));
        addChild(_logo);

        _title = new Image(_assets.getTexture("preloader_logo_rus"));
        _title.pivotX = _title.width/2;
        addChild(_title);

        _progress = new Gauge(_assets.getTexture("preloader_filler"));
        addChild(_progress);

        _langs = new Sprite();
        addChild(_langs);

        super.initialize();

        addChild(_progressTF);

        _progress.ratioH = 0;
    }

    override protected function initializeIPad():void {
        _logo.x = 30;
        _logo.y = 30;

        _title.x = stage.stageWidth/2;
        _title.y = 180;

        _progress.x = 242;
        _progress.y = 418;

        _progressTF = createTextField(_progress.width, _progress.height, 20);
        _progressTF.nativeFilters = [new GlowFilter(0x424242, 1, 3, 3, 3, 3)];
        _progressTF.x = 242;
        _progressTF.y = 418;

        _langs.x = 25;
        _langs.y = 780;
    }

    override protected function initializeIPhone():void {
        y = (stage.stageHeight-_background.height)/2;

        _logo.x = 125;
        _logo.y = (stage.stageHeight-_logo.height) - 10 - y;

        _title.x = stage.stageWidth/2;
        _title.y = 100;

        _progress.x = 100;
        _progress.y = 218;

        _progressTF = createTextField(_progress.width, _progress.height, 12);
        _progressTF.nativeFilters = [new GlowFilter(0x424242, 1, 3, 3, 3, 3)];
        _progressTF.x = 100;
        _progressTF.y = 218;

        _langs.x = 12;
        _langs.y = 395;
    }

    private function handleProgress(event: Event):void {
        var value: Number = event.data as Number;
        _progress.ratioH = value;
        _progressTF.text = String(int(value*100))+"%";
    }

    private function handleShowLanguages(event: Event):void {
        _progressTF.text = "ВЫБЕРИТЕ ЯЗЫК";

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