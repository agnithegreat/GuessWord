/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.tile.ImageTile;

import starling.display.DisplayObject;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;

public class GameScreen extends Sprite {

    public static var tile: int = 395;
    public static var imageTile: int = 395;

    private var _background: Image;

    private var _game: Game;

    private var _picsContainer: Sprite;
    private var _zoomedImage: ImageTile;

    private var _pic1: ImageTile;
    private var _pic2: ImageTile;
    private var _pic3: ImageTile;
    private var _pic4: ImageTile;

    private var _wordView: WordView;
    private var _lettersView: LettersView;

    public function GameScreen(game: Game, assets: AssetManager) {
        _background = new Image(assets.getTexture("back"));
        addChild(_background);

        _background.x = (768-_background.width)/2;
        _background.y = (1024-_background.height)/2;

        _game = game;
        _game.addEventListener(Game.INIT, handleInit);

        _picsContainer = new Sprite();
        _picsContainer.scaleX = 1.53;
        _picsContainer.scaleY = 1.53;
        _picsContainer.x = (768-tile*_picsContainer.scaleX)/2;
        _picsContainer.y = 95;
        addChild(_picsContainer);

        _pic1 = new ImageTile();
        _pic1.pivotX = 0;
        _pic1.pivotY = 0;
        _pic1.x = 0;
        _pic1.y = 0;
        _pic1.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic1);

        _pic2 = new ImageTile();
        _pic2.pivotX = imageTile;
        _pic2.pivotY = 0;
        _pic2.x = tile;
        _pic2.y = 0;
        _pic2.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic2);

        _pic3 = new ImageTile();
        _pic3.pivotX = 0;
        _pic3.pivotY = imageTile;
        _pic3.x = 0;
        _pic3.y = tile;
        _pic3.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic3);

        _pic4 = new ImageTile();
        _pic4.pivotX = imageTile;
        _pic4.pivotY = imageTile;
        _pic4.x = tile;
        _pic4.y = tile;
        _pic4.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic4);

        _wordView = new WordView(_game.word, assets);
        _wordView.x = 768/2;
        _wordView.y = 720;
        addChild(_wordView);

        _lettersView = new LettersView(_game.stack, assets);
        _lettersView.x = 768/2;
        _lettersView.y = 820;
        addChild(_lettersView);
    }

    private function handleInit(event: Event):void {
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
            } else if (!_zoomedImage) {
                _picsContainer.addChild(image);
                _zoomedImage = image;
                image.scale();
            }
        }
    }
}
}
