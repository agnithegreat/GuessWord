/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 21:48
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

public class TopPanel extends AbstractView {

    private var _player: Player;

    private var _levelTF: TextField;
    private var _levelFilters: Array;

    private var _moneyTF: TextField;
    private var _moneyFilters: Array;
    private var _bankBtn: Button;

    private var _bankTouch: Button;

    public function TopPanel(refs: CommonRefs, player: Player) {
        _player = player;
        _player.addEventListener(Player.UPDATE, handleUpdate);

        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _bankBtn = new Button(_refs.assets.getTexture("main_plus_btn_up"), "", _refs.assets.getTexture("main_plus_btn_down"));
        _bankBtn.addEventListener(Event.TRIGGERED, handleBank);
        addChild(_bankBtn);

        super.initialize();

        _levelTF.touchable = false;
        addChild(_levelTF);

        _moneyTF.touchable = false;
        addChild(_moneyTF);

        update();
    }

    override protected function initializeIPad():void {
        _levelTF = createTextField(70, 40, 36);
        _levelFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _levelTF.x = 64;
        _levelTF.y = 31;

        _moneyTF = createTextField(88, 30, 24);
        _moneyFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _moneyTF.x = 622;
        _moneyTF.y = 37;

        _bankBtn.x = 712;
        _bankBtn.y = 24;
    }

    override protected function initializeIPhone():void {
        _levelTF = createTextField(35, 20, 16);
        _levelFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _levelTF.x = 30;
        _levelTF.y = 53;

        _moneyTF = createTextField(44, 12, 12);
        _moneyFilters = [new GlowFilter(0x333333, 1, 3, 3, 3, 3)];
        _moneyTF.x = 250;
        _moneyTF.y = 57;

        _bankBtn.x = 292;
        _bankBtn.y = 51;

        _bankTouch = new Button(Texture.fromColor(35, 30, 0xFFFFFFFF));
        _bankTouch.addEventListener(Event.TRIGGERED, handleBank);
        _bankTouch.alpha = 0;
        addChildAt(_bankTouch, 0);
        _bankTouch.x = 220;
        _bankTouch.y = 47;
    }

    override protected function applyFilters():void {
        _levelTF.nativeFilters = _levelFilters;
        _moneyTF.nativeFilters = _moneyFilters;
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
