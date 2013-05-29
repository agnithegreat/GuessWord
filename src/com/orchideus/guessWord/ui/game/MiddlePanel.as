/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:09
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.tile.ImageTile;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;

public class MiddlePanel extends Sprite {

    public static var tile: int = 595;
    public static var imageTile: int = 595;

    private var _assets: AssetManager;

    private var _picsContainer: Sprite;
    private var _zoomedImage: ImageTile;

    private var _pic1: ImageTile;
    private var _pic2: ImageTile;
    private var _pic3: ImageTile;
    private var _pic4: ImageTile;

    public function MiddlePanel(assets: AssetManager) {
        _assets = assets;
    }

    public function init():void {
        _picsContainer = new Sprite();
        _picsContainer.x = (stage.stageWidth-tile)/2;
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

    public function update(game: Game):void {
        _pic1.init(game.pic1);
        _pic2.init(game.pic2);
        _pic3.init(game.pic3);
        _pic4.init(game.pic4);
    }

    private function handleTouch(event: TouchEvent):void {
        var image: ImageTile = event.currentTarget as ImageTile;
        var touch: Touch = event.getTouch(image, TouchPhase.ENDED);
        if (touch) {
            if (image.zoomed) {
                image.scale();
                _zoomedImage = null;

                Sound.play(Sound.SMALL_PIC);
            } else if (!_zoomedImage) {
                _picsContainer.addChild(image);
                _zoomedImage = image;
                image.scale();

                Sound.play(Sound.BIG_PIC);
            }
        }
    }
}
}
