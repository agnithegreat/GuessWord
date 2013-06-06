/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:09
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.abstract.AbstractView;
import com.orchideus.guessWord.ui.tile.ImageTile;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.utils.AssetManager;

public class MiddlePanel extends AbstractView {

//    public static var tile: int = 595; // HD
//    public static var tile: int = 242; // SD
    public static var tile: int;

    private var _game: Game;

    private var _picsContainer: Sprite;
    private var _zoomedImage: ImageTile;

    private var _pic1: ImageTile;
    private var _pic2: ImageTile;
    private var _pic3: ImageTile;
    private var _pic4: ImageTile;

    public function MiddlePanel(assets: AssetManager, deviceType: DeviceType, game: Game) {
        _game = game;
        super(assets, deviceType)
    }

    override protected function initialize():void {
        var texture: Texture = _assets.getTexture("main_big_pic_under");
        tile = texture.width;

        _picsContainer = new Sprite();
        addChild(_picsContainer);

        _pic1 = new ImageTile(_assets, _deviceType, _game.pic1);
        _pic1.pivotX = 0;
        _pic1.pivotY = 0;
        _pic1.x = 0;
        _pic1.y = 0;
        _pic1.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic1);

        _pic2 = new ImageTile(_assets, _deviceType, _game.pic2);
        _pic2.pivotX = tile;
        _pic2.pivotY = 0;
        _pic2.x = tile;
        _pic2.y = 0;
        _pic2.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic2);

        _pic3 = new ImageTile(_assets, _deviceType, _game.pic3);
        _pic3.pivotX = 0;
        _pic3.pivotY = tile;
        _pic3.x = 0;
        _pic3.y = tile;
        _pic3.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic3);

        _pic4 = new ImageTile(_assets, _deviceType, _game.pic4);
        _pic4.pivotX = tile;
        _pic4.pivotY = tile;
        _pic4.x = tile;
        _pic4.y = tile;
        _pic4.addEventListener(TouchEvent.TOUCH, handleTouch);
        _picsContainer.addChild(_pic4);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(_picsContainer, (stage.stageWidth-tile)/2, 95);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_picsContainer, (stage.stageWidth-tile)/2, 80);
                break;
        }
    }

    public function update():void {
        _pic1.load();
        _pic2.load();
        _pic3.load();
        _pic4.load();
    }

    public function updateDescription(game: Game):void {
        _pic1.showDescription();
        _pic2.showDescription();
        _pic3.showDescription();
        _pic4.showDescription();
    }

    private function handleTouch(event: TouchEvent):void {
        var image: ImageTile = event.currentTarget as ImageTile;
        var touch: Touch = event.getTouch(image, TouchPhase.ENDED);
        if (touch) {
//            dispatchEventWith(IMAGE_SELECTED, true, );

            if (image.zoomed) {
                image.scale();
                _zoomedImage = null;

                dispatchEventWith(Sound.SOUND, true, Sound.SMALL_PIC);
            } else if (!_zoomedImage) {
                _picsContainer.addChild(image);
                _zoomedImage = image;
                image.scale();

                dispatchEventWith(Sound.SOUND, true, Sound.BIG_PIC);
            }
        }
    }
}
}
