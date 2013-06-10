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

    private var _title: TextField;

    private var _closeBtn: Button;

    private var _container: Sprite;

    public function BankPopup(assets: AssetManager, deviceType: DeviceType) {
        super(assets, deviceType, "bank_under");
    }

    override protected function initialize():void {
        _title = new TextField(_background.width, _background.height*0.14, "КУПИТЬ МОНЕТЫ", "Arial", 24, 0xFFFFFF, true);
        _title.nativeFilters = [new GlowFilter(0, 1, 3, 3, 5, 3)];
        addChild(_title);

        _closeBtn = new Button(_assets.getTexture("bank_close_btn"), "", _assets.getTexture("bank_close_btn_down"));
        _closeBtn.addEventListener(Event.TRIGGERED, handleClose);
        addChild(_closeBtn);

        _container = new Sprite();
        addChild(_container);

        for (var i:int = 0; i < Bank.VALUES.length; i++) {
            var bank: Bank = Bank.VALUES[i];
            var bankTile: BankTile = new BankTile(_assets, _deviceType, bank);
            _container.addChild(bankTile);
            bankTile.y = i * bankTile.height*0.87;
        }
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(_container, 40, 80);
                _title.fontSize = 30;
                place(_closeBtn, 525, 17);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_container, 18, 35);
                _title.fontSize = 14;
                place(_closeBtn, 271, 10);
                break;
        }
    }

    private function handleClose(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        PopUpManager.removePopUp(this);
    }
}
}
