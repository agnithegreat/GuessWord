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
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class FriendBar extends AbstractView {

    public static var tiles: int = 6;
    public static var TILE: int;

    private var _controller: GameController;

    private var _tiles: Vector.<FriendTile>;
    private var _offset: int;
    private var _container: Sprite;

    private var _leftBtn: Button;
    private var _startBtn: Button;
    private var _rightBtn: Button;
    private var _endBtn: Button;

    private var _invite: FriendTile;

    public function FriendBar(assets:AssetManager, deviceType:DeviceType, controller: GameController) {
        _controller = controller;
        _controller.addEventListener(GameController.FRIENDS, handleUpdate);

        super(assets, deviceType);
    }

    override protected function initialize():void {
        _tiles = new <FriendTile>[];

        _container = new Sprite();
        addChild(_container);

        _leftBtn = new Button(_assets.getTexture("main_scroll_btn_up"), "", _assets.getTexture("main_scroll_btn_down"));
        _leftBtn.addEventListener(Event.TRIGGERED, handleClick);
        _leftBtn.scaleX = -1;
        addChild(_leftBtn);

        _rightBtn = new Button(_assets.getTexture("main_scroll_btn_up"), "", _assets.getTexture("main_scroll_btn_down"));
        _rightBtn.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_rightBtn);

        _startBtn = new Button(_assets.getTexture("main_page_scroll_btn_up"), "", _assets.getTexture("main_page_scroll_btn_down"));
        _startBtn.addEventListener(Event.TRIGGERED, handleClick);
        _startBtn.scaleX = -1;
        addChild(_startBtn);

        _endBtn = new Button(_assets.getTexture("main_page_scroll_btn_up"), "", _assets.getTexture("main_page_scroll_btn_down"));
        _endBtn.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_endBtn);

        _invite = new FriendTile(_assets, _deviceType);
        _invite.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_invite);

        super.initialize();

        addFriends();
    }

    override protected function initializeIPad():void {
        _container.x = 67;

        _leftBtn.x = 46;
        _leftBtn.y = 15;

        _startBtn.x = 46;
        _startBtn.y = 55;

        _rightBtn.x = 596;
        _rightBtn.y = 15;

        _endBtn.x = 596;
        _endBtn.y = 55;

        _invite.x = 660;

        TILE = 80;
    }

    override protected function initializeIPhone():void {
        _container.x = 30;

        _leftBtn.x = 25;
        _leftBtn.y = 6;

        _startBtn.x = 25;
        _startBtn.y = 24;

        _rightBtn.x = 255;
        _rightBtn.y = 6;

        _endBtn.x = 255;
        _endBtn.y = 24;

        _invite.x = 280;

        TILE = 38;
    }

    private function addFriends():void {
        clear();

        var amount: int = Math.max(tiles, Friend.FRIENDS_ARRAY.length);
        for (var i:int = 0; i < amount; i++) {
            var tile: FriendTile = new FriendTile(_assets, _deviceType, i < Friend.FRIENDS_ARRAY.length ? Friend.FRIENDS_ARRAY[i] : null);
            _tiles.push(tile);
        }

        updateList(0, true);
    }

    private function updateList(value: int, force: Boolean = false):void {
        var newOffset: int = Math.max(0, Math.min(value, _tiles.length-tiles));
        if (!force && newOffset == _offset) {
            return;
        }

        _offset = newOffset;

        _container.removeChildren();

        for (var i:int = 0; i < tiles; i++) {
            var tile: FriendTile = _tiles[i+_offset];
            _container.addChild(tile);
            tile.x = i * TILE;
        }
    }

    private function clear():void {
        while (_tiles.length>0) {
            var tile: FriendTile = _tiles.pop();
            tile.destroy();
            if (tile.parent) {
                _container.removeChild(tile, true);
            }
        }
    }

    private function handleClick(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);

        switch (event.currentTarget) {
            case _leftBtn:
                updateList(_offset-1);
                break;
            case _rightBtn:
                updateList(_offset+1);
                break;
            case _startBtn:
                updateList(0);
                break;
            case _endBtn:
                updateList(_tiles.length-tiles);
                break;
            case _invite:
                dispatchEventWith(Friend.INVITE, true);
                break;
        }
    }

    private function handleUpdate(event: Event):void {
        addFriends();
    }
}
}
