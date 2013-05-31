/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:11
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.tile {
import com.orchideus.guessWord.data.Bonus;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.AssetManager;

public class BonusTile extends Sprite {

    private var _assets: AssetManager;

    private var _back: Button;

    private var _buttonIcon: Image;

    private var _icon: Image;

    private var _text: TextField;

    private var _moneyIcon: Image;
    private var _price: TextField;

    public function BonusTile(bonus: Bonus, assets: AssetManager) {
        _assets = assets;

        _back = new Button(_assets.getTexture("cheat_btn_up"), "", _assets.getTexture("cheat_btn_down"));
        addChild(_back);

        _buttonIcon = new Image(_assets.getTexture(bonus.icon1));
        _buttonIcon.x = _back.width/2;
        _buttonIcon.pivotX = _buttonIcon.width/2;
        _buttonIcon.pivotY = _buttonIcon.height/2;
        addChild(_buttonIcon);

        _icon = new Image(_assets.getTexture(bonus.icon2));
        _icon.x = _back.width/2;
        _icon.y = 40;
        _icon.pivotX = _icon.width/2;
        addChild(_icon);

        _text = new TextField(_back.width, 70, "", "Arial", 24, 0xFFFFFF, true);
        _text.y = 80;
        addChild(_text);
    }
}
}
