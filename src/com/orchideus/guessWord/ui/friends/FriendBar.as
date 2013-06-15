/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 13:33
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.friends {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.social.Social;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;

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

    public function FriendBar(refs: CommonRefs, controller: GameController) {
        _controller = controller;
        _controller.addEventListener(GameController.FRIENDS, handleUpdate);

        super(refs);
    }

    override protected function initialize():void {
        _tiles = new <FriendTile>[];

        _container = new Sprite();
        addChild(_container);

        _leftBtn = new Button(_refs.assets.getTexture("main_scroll_btn_up"), "", _refs.assets.getTexture("main_scroll_btn_down"));
        _leftBtn.addEventListener(Event.TRIGGERED, handleClick);
        _leftBtn.scaleX = -1;
        addChild(_leftBtn);

        _rightBtn = new Button(_refs.assets.getTexture("main_scroll_btn_up"), "", _refs.assets.getTexture("main_scroll_btn_down"));
        _rightBtn.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_rightBtn);

        _startBtn = new Button(_refs.assets.getTexture("main_page_scroll_btn_up"), "", _refs.assets.getTexture("main_page_scroll_btn_down"));
        _startBtn.addEventListener(Event.TRIGGERED, handleClick);
        _startBtn.scaleX = -1;
        addChild(_startBtn);

        _endBtn = new Button(_refs.assets.getTexture("main_page_scroll_btn_up"), "", _refs.assets.getTexture("main_page_scroll_btn_down"));
        _endBtn.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_endBtn);

        _invite = new FriendTile(_refs);
        _invite.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_invite);

        super.initialize();

        addFriends();
    }

    override protected function initializeIPhone():void {
        _container.x = 60;

        _leftBtn.x = 50;
        _leftBtn.y = 12;

        _startBtn.x = 50;
        _startBtn.y = 48;

        _rightBtn.x = 510;
        _rightBtn.y = 12;

        _endBtn.x = 510;
        _endBtn.y = 48;

        _invite.x = 560;

        TILE = 76;
    }

    private function addFriends():void {
        clear();

        var amount: int = Math.max(tiles, Friend.APP_FRIENDS.length);
        for (var i:int = 0; i < amount; i++) {
            var tile: FriendTile = new FriendTile(_refs, i < Friend.APP_FRIENDS.length ? Friend.APP_FRIENDS[i] : null);
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
                dispatchEventWith(Social.INVITE, true);
                break;
        }
    }

    private function handleUpdate(event: Event):void {
        addFriends();
    }
}
}
