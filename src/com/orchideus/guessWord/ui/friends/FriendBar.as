/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 13:33
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.friends {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import starling.display.Button;
import starling.display.Sprite;
import starling.utils.AssetManager;

public class FriendBar extends AbstractView {

    private var _controller: GameController;

    private var _container: Sprite;

    private var _leftBtn: Button;
    private var _startBtn: Button;
    private var _rightBtn: Button;
    private var _endBtn: Button;

    private var _invite: FriendTile;

    public function FriendBar(assets:AssetManager, deviceType:DeviceType, controller: GameController) {
        _controller = controller;

        super(assets, deviceType);
    }

    override protected function initialize():void {
        _container = new Sprite();
        addChild(_container);

        for (var i:int = 0; i < 6; i++) {
            var tile: FriendTile = new FriendTile(_assets, _deviceType);
            _container.addChild(tile);
            tile.x = i*tile.width;
        }

        _leftBtn = new Button(_assets.getTexture("main_scroll_btn_up"), "", _assets.getTexture("main_scroll_btn_down"));
        _leftBtn.scaleX = -1;
        addChild(_leftBtn);

        _rightBtn = new Button(_assets.getTexture("main_scroll_btn_up"), "", _assets.getTexture("main_scroll_btn_down"));
        addChild(_rightBtn);

        _startBtn = new Button(_assets.getTexture("main_page_scroll_btn_up"), "", _assets.getTexture("main_page_scroll_btn_down"));
        _startBtn.scaleX = -1;
        addChild(_startBtn);

        _endBtn = new Button(_assets.getTexture("main_page_scroll_btn_up"), "", _assets.getTexture("main_page_scroll_btn_down"));
        addChild(_endBtn);

        _invite = new FriendTile(_assets, _deviceType);
        addChild(_invite);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_container, 30, 0);
                place(_leftBtn, 25, 6);
                place(_startBtn, 25, 24);
                place(_rightBtn, 255, 6);
                place(_endBtn, 255, 24);
                place(_invite, 280, 0);
                break;
        }
    }
}
}
