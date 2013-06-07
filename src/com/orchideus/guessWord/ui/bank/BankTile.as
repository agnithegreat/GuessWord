/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 10:46
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.bank {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;
import starling.utils.HAlign;

public class BankTile extends AbstractView {

    private var _bank: Bank;

    private var _back: Image;

    private var _coin: Image;
    private var _value: TextField;

    private var _bestValue: TextField;

    private var _price: TextField;

    private var _buyBtn: Button;
    private var _buyTF: TextField;

    public function BankTile(assets:AssetManager, deviceType:DeviceType, bank: Bank) {
        _bank = bank;

        super(assets, deviceType);
    }

    override protected function initialize():void {
        _back = new Image(_assets.getTexture(_bank.best_value ? "bank_bestitem_under" : "bank_item_under"));
        addChild(_back);

        _coin = new Image(_assets.getTexture("bank_coin_ico"));
        addChild(_coin);

        _value = new TextField(_back.width*0.25, _back.height, String(_bank.value), "Arial", 24, 0xFFFFFF, true);
        _value.hAlign = HAlign.LEFT;
        _value.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        addChild(_value);

        if (_bank.best_value) {
            _bestValue = new TextField(_back.width*0.25, _back.height, "ПОПУЛЯРНЫЙ\nПЛАТЕЖ!", "Arial", 24, 0x006097, true);
            _bestValue.nativeFilters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 5, 3)];
            addChild(_bestValue);
        }

        _price = new TextField(_back.width*0.4, _back.height, String(_bank.price)+" руб", "Arial", 24, 0xFFFFFF, true);
        _price.hAlign = HAlign.RIGHT;
        _price.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        addChild(_price);

        _buyBtn = new Button(_assets.getTexture(_bank.best_value ? "bank_bestbuy_btn_up" : "bank_buy_btn_up"), "", _assets.getTexture(_bank.best_value ? "bank_bestbuy_btn_down" : "bank_buy_btn_down"));
        _buyBtn.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_buyBtn);

        _buyTF = new TextField(_buyBtn.width, _buyBtn.height, "КУПИТЬ", "Arial", 24, 0xFFFFFF, true);
        _buyTF.touchable = false;
        _buyTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        addChild(_buyTF);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(_coin, 700, 810);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_coin, -5, 4);
                place(_value, 25, 0);
                _value.fontSize = 16;

                if (_bestValue) {
                    place(_bestValue, 70, 1);
                    _bestValue.fontSize = 8;
                }

                place(_price, 100, 0);
                _price.fontSize = 16;
                place(_buyBtn, 210, 2);
                place(_buyTF, 210, 2);
                _buyTF.fontSize = 8;
                break;
        }
    }

    private function handleClick(event:Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        dispatchEventWith(Bank.BUY, true, _bank);
    }
}
}
