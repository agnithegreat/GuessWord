/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.tile.ImageTile;

import feathers.controls.Screen;

import flash.filters.GlowFilter;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.utils.AssetManager;

public class GameScreen extends Screen {

    public static var tile: int = 600;
    public static var imageTile: int = 600;

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
    public function set app(value: App):void {
        _app = value;
        _app.addEventListener(App.INIT, handleInit);
    }

    private var _game: Game;

    private var _background: Image;

    private var _levelTF: TextField;
    private var _moneyTF: TextField;

    private var _picsContainer: Sprite;
    private var _zoomedImage: ImageTile;

    private var _pic1: ImageTile;
    private var _pic2: ImageTile;
    private var _pic3: ImageTile;
    private var _pic4: ImageTile;

    private var _wordView: WordView;
    private var _lettersView: LettersView;

    override protected function initialize():void {
        _background = new Image(assets.getTexture("main_under"));
        addChild(_background);

        _levelTF = new TextField(70, 40, "", "Arial", 36, 0xFFFFFF, true);
        _levelTF.nativeFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _levelTF.x = 64;
        _levelTF.y = 31;
        addChild(_levelTF);

        _moneyTF = new TextField(88, 25, "", "Arial", 20, 0xFFFFFF, true);
        _moneyTF.nativeFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _moneyTF.x = Guess.size.width-146;
        _moneyTF.y = 41;
        addChild(_moneyTF);

        _picsContainer = new Sprite();
        _picsContainer.x = (Guess.size.width-tile)/2;
        _picsContainer.y = 95;
        addChild(_picsContainer);

        _pic1 = new ImageTile(_assets);
        _pic1.pivotX = 0;
        _pic1.pivotY = 0;
        _pic1.x = 0;
        _pic1.y = 0;
        _pic1.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic1);

        _pic2 = new ImageTile(_assets);
        _pic2.pivotX = imageTile;
        _pic2.pivotY = 0;
        _pic2.x = tile;
        _pic2.y = 0;
        _pic2.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic2);

        _pic3 = new ImageTile(_assets);
        _pic3.pivotX = 0;
        _pic3.pivotY = imageTile;
        _pic3.x = 0;
        _pic3.y = tile;
        _pic3.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic3);

        _pic4 = new ImageTile(_assets);
        _pic4.pivotX = imageTile;
        _pic4.pivotY = imageTile;
        _pic4.x = tile;
        _pic4.y = tile;
        _pic4.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic4);
    }

    private function handleInit(event: Event):void {
        _game = _app.game;
        _game.addEventListener(Game.INIT, handleInitGame);
        _game.addEventListener(Game.UPDATE, handleUpdate);
        _game.addEventListener(Game.WIN, handleWin);

        _wordView = new WordView(_game.word, assets);
        _wordView.x = Guess.size.width/2;
        _wordView.y = 712;
        addChild(_wordView);

        _lettersView = new LettersView(_game.stack, assets);
        _lettersView.x = Guess.size.width/2;
        _lettersView.y = 785;
        addChild(_lettersView);
    }

    private function handleInitGame(event: Event):void {
        _pic1.init(_game.pic1);
        _pic2.init(_game.pic2);
        _pic3.init(_game.pic3);
        _pic4.init(_game.pic4);
    }

    private function handleTouch(event: TouchEvent):void {
        var image: ImageTile = event.currentTarget as ImageTile;
        var touch: Touch = event.getTouch(image, TouchPhase.ENDED);
        if (touch) {
            if (image.zoomed) {
                image.scale();
                _zoomedImage = null;

                _assets.playSound("Small_pic");
            } else if (!_zoomedImage) {
                _picsContainer.addChild(image);
                _zoomedImage = image;
                image.scale();

                _assets.playSound("Big_pic");
            }
        }
    }

    private function handleUpdate(event: Event):void {
        _levelTF.text = String(Player.level);
        _moneyTF.text = String(Player.money);
    }

    private function handleWin(event:Event):void {
        _assets.playSound("Win");
    }
}
}
