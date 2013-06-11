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

        // TODO: localization
        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _back = new Image(_assets.getTexture(_bank.best_value ? "bank_bestitem_under" : "bank_item_under"));
        addChild(_back);

        _coin = new Image(_assets.getTexture("bank_coin_ico"));
        addChild(_coin);

        _buyBtn = new Button(_assets.getTexture(_bank.best_value ? "bank_bestbuy_btn_up" : "bank_buy_btn_up"), "", _assets.getTexture(_bank.best_value ? "bank_bestbuy_btn_down" : "bank_buy_btn_down"));
        _buyBtn.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_buyBtn);

        super.initialize();

        _value.hAlign = HAlign.LEFT;
        addChild(_value);

        _price.hAlign = HAlign.RIGHT;
        addChild(_price);

        _buyTF.touchable = false;
        addChild(_buyTF);
    }

    override protected function initializeIPad():void {
        _coin.x = -10;
        _coin.y = 4;

        _value = createTextField(115, 55, 24, String(_bank.value));
        _value.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        _value.x = 44;

        if (_bank.best_value) {
            _bestValue = createTextField(115, 55, 14, "ПОПУЛЯРНЫЙ\nПЛАТЕЖ!", 0x006097);
            _bestValue.nativeFilters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 5, 3)];
            _bestValue.x = 122;
            _bestValue.y = 2;
            addChild(_bestValue);
        }

        _price = createTextField(195, 55, 24, String(_bank.price)+" руб");
        _price.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        _price.x = 177;

        _buyBtn.x = 382;
        _buyBtn.y = 2;

        _buyTF = createTextField(_buyBtn.width, _buyBtn.height, 16, "КУПИТЬ");
        _buyTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _buyTF.x = 382;
        _buyTF.y = 2;
    }

    override protected function initializeIPhone():void {
        _coin.x = -5;
        _coin.y = 4;

        _value = createTextField(65, 33, 16, String(_bank.value));
        _value.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        _value.x = 25;

        if (_bank.best_value) {
            _bestValue = createTextField(65, 33, 8, "ПОПУЛЯРНЫЙ\nПЛАТЕЖ!", 0x006097);
            _bestValue.nativeFilters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 5, 3)];
            _bestValue.x = 70;
            _bestValue.y = 1;
            addChild(_bestValue);
        }

        _price = createTextField(105, 33, 16, String(_bank.price)+" руб");
        _price.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        _price.x = 100;

        _buyBtn.x = 210;
        _buyBtn.y = 2;

        _buyTF = createTextField(_buyBtn.width, _buyBtn.height, 8, "КУПИТЬ");
        _buyTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _buyTF.x = 210;
        _buyTF.y = 2;
    }

    private function handleClick(event:Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        dispatchEventWith(Bank.BUY, true, _bank);
    }
}
}
