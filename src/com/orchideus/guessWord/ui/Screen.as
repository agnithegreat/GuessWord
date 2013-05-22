/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.tile.ImageTile;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class Screen extends Sprite {

    public static var tile: int = 395;
    public static var imageTile: int = 395;

    private var _background: Image;

    private var _game: Game;

    private var _picsContainer: Sprite;

    private var _pic1: ImageTile;
    private var _pic2: ImageTile;
    private var _pic3: ImageTile;
    private var _pic4: ImageTile;

    public function Screen(game: Game, assets: AssetManager) {
        _background = new Image(assets.getTexture("back"));
        addChild(_background);

        _background.x = (768-_background.width)/2;
        _background.y = (1024-_background.height)/2;

        _game = game;
        _game.addEventListener(Game.INIT, handleInit);

        _picsContainer = new Sprite();
        _picsContainer.scaleX = 1.6;
        _picsContainer.scaleY = 1.6;
        _picsContainer.x = (768-tile*_picsContainer.scaleX)/2;
        _picsContainer.y = 100;
        addChild(_picsContainer);
    }

    private function handleInit(event: Event):void {
        _pic1 = new ImageTile(_game.pic1);
        _pic1.pivotX = 0;
        _pic1.pivotY = 0;
        _pic1.x = 0;
        _pic1.y = 0;
        _picsContainer.addChild(_pic1);

        _pic2 = new ImageTile(_game.pic2);
        _pic2.pivotX = imageTile;
        _pic2.pivotY = 0;
        _pic2.x = tile;
        _pic2.y = 0;
        _picsContainer.addChild(_pic2);

        _pic3 = new ImageTile(_game.pic3);
        _pic3.pivotX = 0;
        _pic3.pivotY = imageTile;
        _pic3.x = 0;
        _pic3.y = tile;
        _picsContainer.addChild(_pic3);

        _pic4 = new ImageTile(_game.pic4);
        _pic4.pivotX = imageTile;
        _pic4.pivotY = imageTile;
        _pic4.x = tile;
        _pic4.y = tile;
        _picsContainer.addChild(_pic4);
    }
}
}
