/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 10:46
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.bank {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;

public class BankTile extends AbstractView {

    private var _bank: Bank;

    private var _back: Image;

    private var _coin: Image;
    private var _value: TextField;
    private var _valueFilters: Array;

    private var _bestValue: TextField;
    private var _bestValueFilters: Array;

    private var _price: TextField;
    private var _priceFilters: Array;

    private var _buyBtn: Button;
    private var _buyTF: TextField;
    private var _buyFilters: Array;

    public function BankTile(refs: CommonRefs, bank: Bank) {
        _bank = bank;

        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _back = new Image(_refs.assets.getTexture(_bank.best_value ? "bank_bestitem_under" : "bank_item_under"));
        _back.touchable = false;
        addChild(_back);

        _coin = new Image(_refs.assets.getTexture("bank_coin_ico"));
        _coin.touchable = false;
        addChild(_coin);

        _buyBtn = new Button(_refs.assets.getTexture(_bank.best_value ? "bank_bestbuy_btn_up" : "bank_buy_btn_up"), "", _refs.assets.getTexture(_bank.best_value ? "bank_bestbuy_btn_down" : "bank_buy_btn_down"));
        _buyBtn.addEventListener(Event.TRIGGERED, handleClick);
        addChild(_buyBtn);

        super.initialize();

        _value.touchable = false;
        _value.hAlign = HAlign.LEFT;
        addChild(_value);

        _price.touchable = false;
        _price.hAlign = HAlign.RIGHT;
        addChild(_price);

        _buyTF.touchable = false;
        addChild(_buyTF);
    }

    override protected function initializeIPad():void {
        _coin.x = -10;
        _coin.y = 4;

        _value = createTextField(115, 55, 24, String(_bank.value));
        _valueFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        _value.x = 44;

        if (_bank.best_value) {
            _bestValue = createTextField(115, 55, 14, _refs.locale.getString("bank.tile.bestbuy"), 0x006097);
            _bestValueFilters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 5, 3)];
            _bestValue.x = 122;
            _bestValue.y = 2;
            addChild(_bestValue);
        }

        _price = createTextField(195, 55, 24, String(_bank.price)+" "+_refs.locale.getString("bank.tile.currency"));
        _priceFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        _price.x = 177;

        _buyBtn.x = 382;
        _buyBtn.y = 2;

        _buyTF = createTextField(_buyBtn.width, _buyBtn.height, 16, _refs.locale.getString("bank.tile.buy"));
        _buyFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _buyTF.x = 382;
        _buyTF.y = 2;
    }

    override protected function initializeIPhone():void {
        _coin.x = -5;
        _coin.y = 4;

        _value = createTextField(65, 33, 16, String(_bank.value));
        _valueFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        _value.x = 25;

        if (_bank.best_value) {
            _bestValue = createTextField(65, 33, 8, _refs.locale.getString("bank.tile.bestbuy"), 0x006097);
            _bestValueFilters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 5, 3)];
            _bestValue.x = 70;
            _bestValue.y = 1;
            addChild(_bestValue);
        }

        _price = createTextField(105, 33, 16, String(_bank.price)+" "+_refs.locale.getString("bank.tile.currency"));
        _priceFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        _price.x = 100;

        _buyBtn.x = 210;
        _buyBtn.y = 2;

        _buyTF = createTextField(_buyBtn.width, _buyBtn.height, 8, _refs.locale.getString("bank.tile.buy"));
        _buyFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _buyTF.x = 210;
        _buyTF.y = 2;
    }

    override protected function applyFilters():void {
        _value.nativeFilters = _valueFilters;
        if (_bestValue) {
            _bestValue.nativeFilters = _bestValueFilters;
        }
        _price.nativeFilters = _priceFilters;
        _buyTF.nativeFilters = _buyFilters;
    }

    private function handleClick(event:Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        dispatchEventWith(Bank.BUY, true, _bank);
    }
}
}
