/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 12.06.13
 * Time: 1:05
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.social.Social;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.VAlign;

public class InviteTile extends AbstractView {

    private var _back: Button;

    private var _icon: Image;

    private var _text: Array;

    private var _text1: TextField;
    private var _text2: TextField;
    private var _textFilters: Array;

    public function InviteTile(refs: CommonRefs) {
        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _back = new Button(_refs.assets.getTexture("main_askhelp_btn_off"), "", _refs.assets.getTexture("main_askhelp_btn_off"));
        addChild(_back);

        _icon = new Image(_refs.assets.getTexture("main_invitefriends_ico_off"));
        _icon.touchable = false;
        addChild(_icon);

        _text = _refs.locale.getString("main.tile.invite").split("\n");

        super.initialize();

        _text1.touchable = false;
        _text1.vAlign = VAlign.TOP;
        addChild(_text1);

        _text2.touchable = false;
        _text2.vAlign = VAlign.TOP;
        _text2.autoScale = true;
        addChild(_text2);

        _back.addEventListener(Event.TRIGGERED, handleClick);
    }

    override protected function initializeIPhone():void {
        _icon.x = 8;
        _icon.y = 8;

        _textFilters = [new GlowFilter(0x666666, 1, 2, 2, 3, 3)];

        _text1 = createTextField(_back.width-16, 16, 32, _text[0]);
        _text1.autoScale = true;
        _text1.x = 8;
        _text1.y = 64;

        _text2 = createTextField(_back.width-16, 16, 32, _text[1]);
        _text2.x = 8;
        _text2.y = 64 + _text1.textBounds.height;
    }

    override protected function applyFilters():void {
        _text1.nativeFilters = _textFilters;
        _text2.nativeFilters = _textFilters;
    }

    public function enable():void {
        _back.upState = _refs.assets.getTexture("main_askhelp_btn_up");
        _back.downState = _refs.assets.getTexture("main_askhelp_btn_down");

        _icon.texture = _refs.assets.getTexture("main_invitefriends_ico_on");
    }

    private function handleClick(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        dispatchEventWith(Social.INVITE, true);
    }
}
}
