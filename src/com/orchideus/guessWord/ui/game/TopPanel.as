/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 21:48
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.data.Sound;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

public class TopPanel extends Sprite {

    private var _player: Player;

    private var _assets: AssetManager;

    private var _levelTF: TextField;

    private var _moneyTF: TextField;
    private var _bankBtn: Button;

    public function TopPanel(assets: AssetManager) {
        _assets = assets;
    }

    public function init(player: Player):void {
        _player = player;
        _player.addEventListener(Player.UPDATE, handleUpdate);

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

        _bankBtn = new Button(_assets.getTexture("plus_btn_up"), "", _assets.getTexture("plus_btn_down"));
        _bankBtn.addEventListener(Event.TRIGGERED, handleBank);
        _bankBtn.x = 712;
        _bankBtn.y = 24;
        addChild(_bankBtn);

        update();
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
