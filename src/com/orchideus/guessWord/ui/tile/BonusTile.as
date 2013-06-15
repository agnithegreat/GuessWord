/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:11
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class BonusTile extends AbstractView {

    private var _bonus: Bonus;

    private var _back: Button;

    private var _icon: Image;

    private var _text1: TextField;
    private var _text2: TextField;

    private var _moneyIcon: Image;
    private var _price: TextField;

    public function BonusTile(refs: CommonRefs, bonus: Bonus) {
        _bonus = bonus;

         super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _back = new Button(_refs.assets.getTexture("main_cheat_btn_up"), "", _refs.assets.getTexture("main_cheat_btn_down"));
        _back.addEventListener(Event.TRIGGERED, handleTriggered);
        addChild(_back);

        _icon = new Image(_refs.assets.getTexture(_bonus.icon));
        _icon.pivotX = _icon.width/2;
        _icon.touchable = false;
        addChild(_icon);

        _moneyIcon = new Image(_refs.assets.getTexture("main_coin_ico"));
        _moneyIcon.touchable = false;
        addChild(_moneyIcon);

        super.initialize();

        _text1.touchable = false;
        _text1.vAlign = VAlign.TOP;
        addChild(_text1);

        _text2.touchable = false;
        _text2.vAlign = VAlign.TOP;
        _text2.autoScale = true;
        addChild(_text2);

        _price.touchable = false;
        _price.vAlign = VAlign.TOP;
        _price.hAlign = HAlign.LEFT;
        addChild(_price);
    }

    override protected function initializeIPhone():void {
        _icon.x = _back.width/2+2;
        _icon.y = -14;

        _moneyIcon.x = 10;
        _moneyIcon.y = 96;

        _text1 = createTextField(_back.width-16, 24, 32, _bonus.text[0]);
        _text1.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        _text1.autoScale = true;
        _text1.x = 8;
        _text1.y = 64;

        _text2 = createTextField(_back.width-16, 24, 32, _bonus.text[1]);
        _text2.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        _text2.x = 8;
        _text2.y = 64 + _text1.textBounds.height;

        _price = createTextField(36, 30, 20, String(_bonus.price));
        _price.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        _price.x = 32;
        _price.y = 94;
    }

    private function handleTriggered(event: Event):void {
        dispatchEventWith(Bonus.USE, true, _bonus);
    }
}
}
