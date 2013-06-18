/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 17.06.13
 * Time: 18:00
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.friends {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.social.Social;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.events.Event;
import starling.text.TextField;

public class FriendBarPlaceholder extends AbstractView {

    private var _text1: TextField;
    private var _text1Filters: Array;
    private var _text2: TextField;
    private var _text2Filters: Array;

    private var _connectBtn: Button;

    public function FriendBarPlaceholder(refs:CommonRefs) {
        super(refs);
    }

    override protected function initialize():void {
        _connectBtn = new Button(_refs.assets.getTexture("main_fb_btn_up"), "", _refs.assets.getTexture("main_fb_btn_down"));
        _connectBtn.addEventListener(Event.TRIGGERED, handleConnect);
        _connectBtn.pivotX = _connectBtn.width/2;
        addChild(_connectBtn);

        super.initialize();

        _text1.touchable = false;
        addChild(_text1);

        _text2.touchable = false;
        addChild(_text2);
    }

    override protected function initializeIPad():void {
        _text1 = createTextField(stage.stageWidth, 32, 26, _refs.locale.getString("main.friends.text1"), 0xFFCC00);
        _text1Filters = [new GlowFilter(0, 1, 3, 3, 3, 3)];

        _text2 = createTextField(stage.stageWidth, 30, 20, _refs.locale.getString("main.friends.text2"), 0x3333CC);
        _text2Filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 1, 3)];
        _text2.y = 30;

        _connectBtn.x = stage.stageWidth/2;
        _connectBtn.y = 28;
    }

    override protected function initializeIPhone():void {
        _text1 = createTextField(stage.stageWidth, 20, 11, _refs.locale.getString("main.friends.text1"), 0xFFCC00);
        _text1Filters = [new GlowFilter(0, 1, 3, 3, 3, 3)];

        _text2 = createTextField(stage.stageWidth, 15, 8, _refs.locale.getString("main.friends.text2"), 0x3333CC);
        _text2Filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 1, 3)];
        _text2.y = 14;

        _connectBtn.x = stage.stageWidth/2;
    }

    override protected function applyFilters():void {
        _text1.nativeFilters = _text1Filters;
        _text2.nativeFilters = _text2Filters;
    }

    private function handleConnect(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        dispatchEventWith(Social.LOGIN, true);
    }
}
}
