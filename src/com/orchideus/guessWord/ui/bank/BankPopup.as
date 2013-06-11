/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:05
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.bank {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.abstract.Screen;

import feathers.core.PopUpManager;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

public class BankPopup extends Screen {

    public static var TILE: int;

    private var _title: TextField;

    private var _closeBtn: Button;

    private var _container: Sprite;

    public function BankPopup(assets: AssetManager, deviceType: DeviceType) {
        super(assets, deviceType, "bank_under");

        // TODO: localization
        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _closeBtn = new Button(_assets.getTexture("bank_close_btn"), "", _assets.getTexture("bank_close_btn_down"));
        _closeBtn.addEventListener(Event.TRIGGERED, handleClose);
        addChild(_closeBtn);

        _container = new Sprite();
        addChild(_container);

        super.initialize();

        _title.touchable = false;
        addChild(_title);

        for (var i:int = 0; i < Bank.VALUES.length; i++) {
            var bank: Bank = Bank.VALUES[i];
            var bankTile: BankTile = new BankTile(_assets, _deviceType, bank);
            _container.addChild(bankTile);
            bankTile.y = i * TILE;
        }
    }

    override protected function initializeIPad():void {
        _title = createTextField(_background.width, 60, 30, "КУПИТЬ МОНЕТЫ");
        _title.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];

        _closeBtn.x = 522;
        _closeBtn.y = 17;

        _container.x = 42;
        _container.y = 76;

        TILE = 54;
    }

    override protected function initializeIPhone():void {
        _title = createTextField(_background.width, 32, 16, "КУПИТЬ МОНЕТЫ");
        _title.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];

        _closeBtn.x = 271;
        _closeBtn.y = 9;

        _container.x = 18;
        _container.y = 35;

        TILE = 30;
    }

    private function handleClose(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        PopUpManager.removePopUp(this);
    }
}
}
