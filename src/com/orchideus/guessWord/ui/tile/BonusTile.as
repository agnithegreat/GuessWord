/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:11
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.Bonus;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class BonusTile extends Sprite {

    public static const USE: String = "use_BonusTile";

    private var _bonus: Bonus;

    private var _assets: AssetManager;

    private var _back: Button;

    private var _buttonIcon: Image;

    private var _icon: Image;

    private var _text1: TextField;
    private var _text2: TextField;

    private var _moneyIcon: Image;
    private var _price: TextField;

    public function BonusTile(bonus: Bonus, assets: AssetManager) {
        _bonus = bonus;

        _assets = assets;

        _back = new Button(_assets.getTexture("cheat_btn_up"), "", _assets.getTexture("cheat_btn_down"));
        _back.addEventListener(Event.TRIGGERED, handleTriggered);
        addChild(_back);

        _buttonIcon = new Image(_assets.getTexture(_bonus.icon1));
        _buttonIcon.touchable = false;
        _buttonIcon.x = _back.width/2;
        _buttonIcon.y = 5;
        _buttonIcon.pivotX = _buttonIcon.width/2;
        _buttonIcon.pivotY = _buttonIcon.height/2;
        addChild(_buttonIcon);

        _icon = new Image(_assets.getTexture(_bonus.icon2));
        _icon.touchable = false;
        _icon.x = _back.width/2;
        _icon.y = 24;
        _icon.pivotX = _icon.width/2;
        addChild(_icon);

        _text1 = new TextField(_back.width-14, 30, _bonus.text[0], "Arial", 16, 0xFFFFFF, true);
        _text1.touchable = false;
        _text1.vAlign = VAlign.TOP;
        _text1.autoScale = true;
        _text1.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        _text1.x = 7;
        _text1.y = 67;
        addChild(_text1);

        _text2 = new TextField(_back.width-14, 30, _bonus.text[1], "Arial", 16, 0xFFFFFF, true);
        _text2.touchable = false;
        _text2.vAlign = VAlign.TOP;
        _text2.autoScale = true;
        _text2.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        _text2.x = 7;
        _text2.y = 67 + _text1.textBounds.height;
        addChild(_text2);

        _moneyIcon = new Image(_assets.getTexture("coin_ico_small"));
        _moneyIcon.touchable = false;
        _moneyIcon.x = 12;
        _moneyIcon.y = 102;
        addChild(_moneyIcon);

        _price = new TextField(30, 30, String(_bonus.price), "Arial", 20, 0xFFFFFF, true);
        _price.nativeFilters = [new GlowFilter(0x683a00, 1, 2, 2, 3, 3)];
        _price.touchable = false;
        _price.vAlign = VAlign.TOP;
        _price.hAlign = HAlign.LEFT;
        _price.x = 40;
        _price.y = 101;
        addChild(_price);
    }

    private function handleTriggered(event: Event):void {
        dispatchEventWith(BonusTile.USE, true, _bonus);
    }
}
}
