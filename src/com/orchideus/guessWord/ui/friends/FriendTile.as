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
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
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
    }

    override protected function initialize():void {
        if (_friend) {
            _invite = new Image(_assets.getTexture("main_friend_under"));
            addChild(_invite);

            _levelIcon = new Image(_assets.getTexture("main_lvl_sm_ico"));
            addChild(_levelIcon);

            _levelTF = new TextField(_invite.width*0.6, _invite.height*0.3, "", "Arial", 24, 0xFFFFFF, true);
            _levelTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
            addChild(_levelTF);

            _avatar = new Image(_assets.getTexture("main_ava_under"));
            addChild(_avatar);

            _inviteBtn = new Button(_assets.getTexture("main_ask_btn_up"), "", _assets.getTexture("main_ask_btn_down"));
            addChild(_inviteBtn);

            _inviteTF = new TextField(_inviteBtn.width, _inviteBtn.height, "СПРОСИТЬ", "Arial", 24, 0xFFFFFF, true);
            _inviteTF.touchable = false;
            _inviteTF.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            addChild(_inviteTF);
        } else {
            _invite = new Image(_assets.getTexture("main_invite_under"));
            addChild(_invite);

            _avatar = new Image(_assets.getTexture("main_invite_ava"));
            addChild(_avatar);

            _inviteBtn = new Button(_assets.getTexture("main_invite_btn_up"), "", _assets.getTexture("main_invite_btn_down"));
            addChild(_inviteBtn);

            _inviteTF = new TextField(_inviteBtn.width, _inviteBtn.height, "ПОЗВАТЬ\nДРУЗЕЙ", "Arial", 24, 0xFFFFFF, true);
            _inviteTF.touchable = false;
            _inviteTF.nativeFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
            addChild(_inviteTF);
        }
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                if (_friend) {

                } else {

                }
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                if (_friend) {
                    place(_invite, 0, -5);
                    place(_levelIcon, 1, -6);
                    place(_levelTF, 12, -4);
                    _levelTF.fontSize = 8;
                    place(_avatar, 2, 7);
                    place(_inviteBtn, -4, 50);
                    place(_inviteTF, -4, 50);
                    _inviteTF.fontSize = 10;
                } else {
                    place(_avatar, 6, 7);
                    place(_inviteBtn, -3, 28);
                    place(_inviteTF, -3, 28);
                    _inviteTF.fontSize = 5;
                }
                break;
        }
    }
}
}
