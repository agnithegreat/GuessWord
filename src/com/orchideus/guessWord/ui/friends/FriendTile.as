/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 13:34
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.friends {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.social.Social;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

public class FriendTile extends AbstractView {

    private var _friend: Friend;

    private var _invite: Image;

    private var _levelIcon: Image;
    private var _levelTF: TextField;
    private var _levelFilters: Array;

    private var _avatar: Image;
    private var _photo: Image;
    private var _inviteBtn: Button;
    private var _inviteTF: TextField;
    private var _inviteFilters: Array;

    public function FriendTile(refs: CommonRefs, friend: Friend = null) {
        _friend = friend;

        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        if (_friend) {
            _invite = new Image(_refs.assets.getTexture("main_friend_under"));
            _invite.touchable = false;
            addChild(_invite);

            _levelIcon = new Image(_refs.assets.getTexture("main_lvl_sm_ico"));
            _levelIcon.touchable = false;
            addChild(_levelIcon);

            _avatar = new Image(_refs.assets.getTexture("main_ava_under"));
            _avatar.touchable = false;
            addChild(_avatar);

            if (!_friend.photo) {
                _friend.addEventListener(Friend.PHOTO, handleLoad);
                _friend.load();
            }

            _photo = new Image(_friend.photo ? _friend.photo : Texture.empty());
            _photo.touchable = false;

            _inviteBtn = new Button(_refs.assets.getTexture("main_ask_btn_up"), "", _refs.assets.getTexture("main_ask_btn_down"));
            _inviteBtn.addEventListener(Event.TRIGGERED, handleClick);
            addChild(_inviteBtn);

            super.initialize();

            _levelTF.touchable = false;
            addChild(_levelTF);

            _inviteTF.touchable = false;
            addChild(_inviteTF);
        } else {
            _invite = new Image(_refs.assets.getTexture("main_invite_under"));
            _invite.touchable = false;
            addChild(_invite);

            _avatar = new Image(_refs.assets.getTexture("main_invite_ava"));
            _avatar.touchable = false;
            addChild(_avatar);

            _inviteBtn = new Button(_refs.assets.getTexture("main_invite_btn_up"), "", _refs.assets.getTexture("main_invite_btn_down"));
            _inviteBtn.addEventListener(Event.TRIGGERED, handleClick);
            addChild(_inviteBtn);

            super.initialize();

            _inviteTF.touchable = false;
            addChild(_inviteTF);
        }
    }

    override protected function initializeIPhone():void {
        if (_friend) {
            _invite.y = -6;

            _levelIcon.x = 4;
            _levelIcon.y = -8;

            _levelTF = createTextField(40, 20, 12, String(_friend.level));
            _levelFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _levelTF.x = 22;
            _levelTF.y = -2;

            _avatar.x = 8;
            _avatar.y = 16;

            _photo.x = 10;
            _photo.y = 18;
            _photo.width = _avatar.width-4;
            _photo.height = _avatar.height-4;

            _inviteBtn.x = -6;
            _inviteBtn.y = 64;

            _inviteTF = createTextField(_inviteBtn.width, _inviteBtn.height, 10, _refs.locale.getString("main.friends.ask"));
            _inviteFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _inviteTF.x = -6;
            _inviteTF.y = 64;
        } else {
            _avatar.x = 12;
            _avatar.y = 14;

            _inviteBtn.x = -6;
            _inviteBtn.y = 56;

            _inviteTF = createTextField(74, 42, 10, _refs.locale.getString("main.friends.invite"));
            _inviteFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _inviteTF.x = -6;
            _inviteTF.y = 56;
        }
    }

    override protected function applyFilters():void {
        if (_levelTF) {
            _levelTF.nativeFilters = _levelFilters;
        }
        _inviteTF.nativeFilters = _inviteFilters;
    }

    private function handleLoad(event: Event):void {
        _photo.texture = _friend.photo;
        addChild(_photo);
    }

    private function handleClick(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        if (_friend) {
            dispatchEventWith(Social.ASK, true, _friend.uid);
        } else {
            dispatchEventWith(Social.INVITE, true);
        }
    }
}
}
