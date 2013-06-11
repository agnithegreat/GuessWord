/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 21:48
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

public class TopPanel extends AbstractView {

    private var _player: Player;

    private var _levelTF: TextField;

    private var _moneyTF: TextField;
    private var _bankBtn: Button;

    public function TopPanel(assets: AssetManager, deviceType: DeviceType, player: Player) {
        _player = player;
        _player.addEventListener(Player.UPDATE, handleUpdate);

        super(assets, deviceType);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _bankBtn = new Button(_assets.getTexture("main_plus_btn_up"), "", _assets.getTexture("main_plus_btn_down"));
        _bankBtn.addEventListener(Event.TRIGGERED, handleBank);
        addChild(_bankBtn);

        super.initialize();

        addChild(_levelTF);

        addChild(_moneyTF);

        update();
    }

    override protected function initializeIPad():void {
        _levelTF = createTextField(70, 40, 36);
        _levelTF.nativeFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _levelTF.x = 64;
        _levelTF.y = 31;

        _moneyTF = createTextField(88, 25, 20);
        _moneyTF.nativeFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _moneyTF.x = 626;
        _moneyTF.y = 41;

        _bankBtn.x = 712;
        _bankBtn.y = 24;
    }

    override protected function initializeIPhone():void {
        _levelTF = createTextField(35, 20, 16);
        _levelTF.nativeFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _levelTF.x = 30;
        _levelTF.y = 53;

        _moneyTF = createTextField(44, 12, 12);
        _moneyTF.nativeFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _moneyTF.x = 250;
        _moneyTF.y = 57;

        _bankBtn.x = 292;
        _bankBtn.y = 51;
    }

    private function update():void {
        _levelTF.text = String(_player.level);
        _moneyTF.text = String(_player.money);
    }

    private function handleUpdate(event: Event):void {
        update();
    }

    private function handleBank(event:Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        dispatchEventWith(Bank.OPEN, true);
    }
}
}
