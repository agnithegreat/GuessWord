/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:55
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.preloader {
import feathers.controls.Screen;

import flash.filters.GlowFilter;

import starling.display.DisplayObject;

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

    private var _assets: AssetManager;
    public function get assets():AssetManager {
        return _assets;
    }
    public function set assets(value: AssetManager):void {
        _assets = value;
    }

    private var _app: App;
    public function get app():App {
        return _app;
    }
    public function set app(value:App):void {
        _app = value;
        _app.addEventListener(App.PROGRESS, handleProgress);
    }

    private var _background: Image;

    private var _progress: Gauge;
    private var _progressTF: TextField;

    private var _logo: Image;
    private var _langs: Sprite;

    override protected function initialize():void {
        _background = new Image(_assets.getTexture("preloader_under"));
        addChild(_background);

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
    }

    private var _localeCallback: Function;
    public function showLanguages(callback: Function):void {
        _localeCallback = callback;

        _logo = new Image(_assets.getTexture("DUCK_ico"));
        _logo.x = 30;
        _logo.y = 30;
        addChild(_logo);

        _langs = new Sprite();
        _langs.x = 25;
        _langs.y = 780;
        addChild(_langs);

        var langs: Array = [
                            {lang: "Русский", icon: "rus_ico"},
                            {lang: "Deutsch", icon: "deutch_ico"},
                            {lang: "English", icon: "eng_ico"},
                            {lang: "Français", icon: "franc_ico"},
                            {lang: "Español", icon: "esp_ico"},
                            {lang: "Italiano", icon: "ital_ico"},
                            {lang: "Português", icon: "port_ico"}
                           ];

        for (var i:int = 0; i < langs.length; i++) {
            var lang: Object = langs[i];
            var tile: LanguageTile = new LanguageTile(lang.lang, lang.icon, _assets);
            tile.addEventListener(TouchEvent.TOUCH, handleSelectLanguage);
            tile.x = i<6 ? (i%3) * 255 : 255;
            tile.y = int(i/3) * 85;
            _langs.addChild(tile);
        }
    }

    private function handleSelectLanguage(event: TouchEvent):void {
        if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.ENDED)) {
            _localeCallback((event.currentTarget as LanguageTile).locale);
        }
    }

    private function handleProgress(event: Event):void {
        var value: Number = Number(event.data);
        _progress.ratioH = value;
        _progressTF.text = String(int(value*100))+"%";
    }
}
}
