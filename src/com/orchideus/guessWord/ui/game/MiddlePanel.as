/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:09
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Pic;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.abstract.AbstractView;
import com.orchideus.guessWord.ui.tile.ImageTile;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class MiddlePanel extends AbstractView {

    public static var TILE: int;

    private var _game: Game;

    private var _picsContainer: Sprite;

    private var _clickedImage: ImageTile;
    private var _zoomedImage: ImageTile;

    private var _pic1: ImageTile;
    private var _pic2: ImageTile;
    private var _pic3: ImageTile;
    private var _pic4: ImageTile;

    public function MiddlePanel(refs: CommonRefs, game: Game) {
        _game = game;
        _game.addEventListener(Game.ZOOM, handleZoom);
        _game.addEventListener(Game.PIC_CHANGED, handlePicChanged);

        super(refs);
    }

    override protected function initialize():void {
        _picsContainer = new Sprite();
        addChild(_picsContainer);

        super.initialize();

        _picsContainer.x = (stage.stageWidth-TILE)/2;

        _pic1 = new ImageTile(_refs, _game.pic1);
        _pic1.pivotX = 0;
        _pic1.pivotY = 0;
        _pic1.x = 0;
        _pic1.y = 0;
        _pic1.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic1);

        _pic2 = new ImageTile(_refs, _game.pic2);
        _pic2.pivotX = TILE;
        _pic2.pivotY = 0;
        _pic2.x = TILE;
        _pic2.y = 0;
        _pic2.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic2);

        _pic3 = new ImageTile(_refs, _game.pic3);
        _pic3.pivotX = 0;
        _pic3.pivotY = TILE;
        _pic3.x = 0;
        _pic3.y = TILE;
        _pic3.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic3);

        _pic4 = new ImageTile(_refs, _game.pic4);
        _pic4.pivotX = TILE;
        _pic4.pivotY = TILE;
        _pic4.x = TILE;
        _pic4.y = TILE;
        _pic4.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic4);
    }

    override protected function initializeIPhone():void {
        _picsContainer.y = 160;

        TILE = 484;
    }

    public function update():void {
        _pic1.load();
        _pic2.load();
        _pic3.load();
        _pic4.load();
    }

    public function updateDescription():void {
        _pic1.showDescription();
        _pic2.showDescription();
        _pic3.showDescription();
        _pic4.showDescription();
    }

    public function showSelectImage():void {
        _pic1.showSelectImage();
        _pic2.showSelectImage();
        _pic3.showSelectImage();
        _pic4.showSelectImage();
    }

    public function hideSelectImage():void {
        _pic1.hideSelectImage();
        _pic2.hideSelectImage();
        _pic3.hideSelectImage();
        _pic4.hideSelectImage();
    }

    private function handleTouch(event: TouchEvent):void {
        _clickedImage = event.currentTarget as ImageTile;
        var touch: Touch = event.getTouch(_clickedImage, TouchPhase.ENDED);
        if (touch) {
            dispatchEventWith(Pic.SELECT, true, _clickedImage.pic);
        }
    }

    private function handleZoom(event: Event):void {
        if (_clickedImage) {
            if (_clickedImage.zoomed) {
                _clickedImage.scale();
                _zoomedImage = null;

                dispatchEventWith(Sound.SOUND, true, Sound.SMALL_PIC);
            } else if (!_zoomedImage) {
                _picsContainer.addChild(_clickedImage);
                _zoomedImage = _clickedImage;
                _clickedImage.scale();

                dispatchEventWith(Sound.SOUND, true, Sound.BIG_PIC);
            }

            _clickedImage = null;
        }
    }

    private function handlePicChanged(event: Event):void {
        this["_pic"+event.data].load();
    }
}
}
