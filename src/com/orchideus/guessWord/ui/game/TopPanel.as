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
    }

    override protected function initialize():void {
        _levelTF = new TextField(70, 40, "", "Arial", 36, 0xFFFFFF, true);
        _levelTF.nativeFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _levelTF.x = 64;
        _levelTF.y = 31;
        addChild(_levelTF);

        _moneyTF = new TextField(88, 25, "", "Arial", 20, 0xFFFFFF, true);
        _moneyTF.nativeFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _moneyTF.x = 626;
        _moneyTF.y = 41;
        addChild(_moneyTF);

        _bankBtn = new Button(_assets.getTexture("main_plus_btn_up"), "", _assets.getTexture("main_plus_btn_down"));
        _bankBtn.addEventListener(Event.TRIGGERED, handleBank);
        _bankBtn.x = 712;
        _bankBtn.y = 24;
        addChild(_bankBtn);

        update();
    }

    override protected function align():void {
        super.align();

        switch (_deviceType) {
            case DeviceType.iPad:
                place(_levelTF, 64, 31);
                place(_moneyTF, 626, 41);
                place(_bankBtn, 712, 24);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                resize(_levelTF, 35, 20);
                place(_levelTF, 30, 53);
                _levelTF.fontSize = 16;
                resize(_moneyTF, 44, 12);
                place(_moneyTF, 250, 57);
                _moneyTF.fontSize = 12;
                place(_bankBtn, 293, 51);
                break;
        }
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
