/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 13:34
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.friends {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

public class FriendTile extends AbstractView {

    private var _friend: Friend;

    private var _invite: Image;

    private var _levelIcon: Image;
    private var _levelTF: TextField;

    private var _avatar: Image;
    private var _inviteBtn: Button;
    private var _inviteTF: TextField;

    public function FriendTile(assets:AssetManager, deviceType:DeviceType, friend: Friend = null) {
        _friend = friend;

        super(assets, deviceType);

        // TODO: localization
        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        if (_friend) {
            _invite = new Image(_assets.getTexture("main_friend_under"));
            addChild(_invite);

            _levelIcon = new Image(_assets.getTexture("main_lvl_sm_ico"));
            addChild(_levelIcon);

            _avatar = new Image(_assets.getTexture("main_ava_under"));
            // TODO: подгрузка фотки
            addChild(_avatar);

            _inviteBtn = new Button(_assets.getTexture("main_ask_btn_up"), "", _assets.getTexture("main_ask_btn_down"));
            _inviteBtn.addEventListener(Event.TRIGGERED, handleClick);
            addChild(_inviteBtn);

            super.initialize();

            addChild(_levelTF);

            _inviteTF.touchable = false;
            addChild(_inviteTF);
        } else {
            _invite = new Image(_assets.getTexture("main_invite_under"));
            addChild(_invite);

            _avatar = new Image(_assets.getTexture("main_invite_ava"));
            addChild(_avatar);

            _inviteBtn = new Button(_assets.getTexture("main_invite_btn_up"), "", _assets.getTexture("main_invite_btn_down"));
            _inviteBtn.addEventListener(Event.TRIGGERED, handleClick);
            addChild(_inviteBtn);

            super.initialize();

            _inviteTF.touchable = false;
            addChild(_inviteTF);
        }
    }

    override protected function initializeIPad():void {
        // TODO: проверить

        if (_friend) {
            _invite.y = -3;

            _levelIcon.x = 2;
            _levelIcon.y = -4;

            _levelTF = createTextField(44, 17, 12, String(_friend.level));
            _levelTF.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _levelTF.x = 12;
            _levelTF.y = -3;

            _avatar.x = 4;
            _avatar.y = 8;

            _inviteBtn.x = -3;
            _inviteBtn.y = 32;

            _inviteTF = createTextField(_inviteBtn.width, _inviteBtn.height, 12, "СПРОСИТЬ");
            _inviteTF.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _inviteTF.x = -3;
            _inviteTF.y = 32;
        } else {
            _avatar.x = 13;
            _avatar.y = 16;

            _inviteBtn.x = -6;
            _inviteBtn.y = 62;

            _inviteTF = createTextField(_inviteBtn.width, _inviteBtn.height, 12, "ПОЗВАТЬ\nДРУЗЕЙ");
            _inviteTF.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _inviteTF.x = -6;
            _inviteTF.y = 62;
        }
    }

    override protected function initializeIPhone():void {
        if (_friend) {
            _invite.y = -3;

            _levelIcon.x = 2;
            _levelIcon.y = -4;

            _levelTF = createTextField(_inviteBtn.width, _inviteBtn.height, 5, String(_friend.level));
            _levelTF.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _levelTF.x = 10;
            _levelTF.y = -3;

            _avatar.x = 4;
            _avatar.y = 8;

            _inviteBtn.x = -3;
            _inviteBtn.y = 32;

            _inviteTF = createTextField(_inviteBtn.width, _inviteBtn.height, 5, "СПРОСИТЬ");
            _inviteTF.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _inviteTF.x = -3;
            _inviteTF.y = 32;
        } else {
            _avatar.x = 6;
            _avatar.y = 7;

            _inviteBtn.x = -3;
            _inviteBtn.y = 28;

            _inviteTF = createTextField(37, 21, 5, "ПОЗВАТЬ\nДРУЗЕЙ");
            _inviteTF.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            _inviteTF.x = -3;
            _inviteTF.y = 28;
        }
    }

    private function handleClick(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        dispatchEventWith(Friend.INVITE, true);
    }
}
}
