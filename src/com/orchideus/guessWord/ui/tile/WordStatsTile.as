/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 12.06.13
 * Time: 1:05
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.social.Social;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Image;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.VAlign;

public class WordStatsTile extends AbstractView {

    private var _friend: Friend;

    private var _icon: Image;
    private var _photo: Image;

    private var _text: Array;

    private var _text1: TextField;
    private var _text2: TextField;
    private var _text3: TextField;
    private var _textFilters: Array;

    public function WordStatsTile(refs: CommonRefs) {
        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _icon = new Image(_refs.assets.getTexture("main_enemy_ico_off"));
        addChild(_icon);

        _photo = new Image(Texture.empty());

        _text = _refs.locale.getString("main.tile.challenge").split("\n");

        super.initialize();

        _text1.vAlign = VAlign.TOP;
        addChild(_text1);

        _text2.vAlign = VAlign.TOP;
        addChild(_text2);

        _text3.vAlign = VAlign.TOP;
        _text3.autoScale = true;
        addChild(_text3);

        addEventListener(TouchEvent.TOUCH, handleClick);
    }

    override protected function initializeIPad():void {
        _icon.x = 8;
        _icon.y = 10;

        _photo.x = 10;
        _photo.y = 12;
        _photo.width = _icon.width-4;
        _photo.height = _icon.height-4;

        _textFilters = [new GlowFilter(0x666666, 1, 2, 2, 3, 3)];

        _text1 = createTextField(125, 20, 16, _text[0]);
        _text1.autoScale = true;
        _text1.x = 70;
        _text1.y = 10;

        _text2 = createTextField(125, 20, 16, _text[1]);
        _text2.autoScale = true;
        _text2.x = 70;
        _text2.y = 10 + _text1.textBounds.height;

        _text3 = createTextField(125, 20, 16, _text[2]);
        _text3.x = 70;
        _text3.y = 10 + _text1.textBounds.height + _text2.textBounds.height;
    }

    override protected function initializeIPhone():void {
        _icon.x = 3;
        _icon.y = 4;

        _photo.x = 4;
        _photo.y = 5;
        _photo.width = _icon.width-2;
        _photo.height = _icon.height-2;

        _textFilters = [new GlowFilter(0x666666, 1, 2, 2, 3, 3)];

        _text1 = createTextField(60, 10, 16, _text[0]);
        _text1.autoScale = true;
        _text1.x = 32;
        _text1.y = 4;

        _text2 = createTextField(60, 10, 16, _text[1]);
        _text2.autoScale = true;
        _text2.x = 32;
        _text2.y = 4 + _text1.textBounds.height;

        _text3 = createTextField(60, 10, 16, _text[2]);
        _text3.x = 32;
        _text3.y = 4 + _text1.textBounds.height + _text2.textBounds.height;
    }

    override protected function applyFilters():void {
        _text1.nativeFilters = _textFilters;
        _text2.nativeFilters = _textFilters;
        _text3.nativeFilters = _textFilters;
    }

    public function update(friend: Friend):void {
        _friend = friend;
        if (_friend && !_friend.photo) {
            _friend.addEventListener(Friend.PHOTO, handleLoad);
            _friend.load();
        } else {
            handleLoad(null);
        }
    }

    private function handleLoad(event: Event):void {
        _icon.texture = _refs.assets.getTexture("main_ava_under");
        _photo.texture = _friend ? _friend.photo : _refs.assets.getTexture("main_invitefriends_ico_on");
        addChild(_photo);
    }

    private function handleClick(event: TouchEvent):void {
        if (event.getTouch(this, TouchPhase.ENDED)) {
            dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
            dispatchEventWith(Social.INVITE, true);
        }
    }
}
}
