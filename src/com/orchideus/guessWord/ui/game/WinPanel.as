/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 15:45
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

public class WinPanel extends Sprite {

    public static const CONTINUE: String = "continue_WinPanel";

    private var _assets: AssetManager;

    private var _winTF: TextField;

    private var _continueBtn: Button;

    public function WinPanel(assets: AssetManager) {
        _assets = assets;
    }

    public function init():void {
        _winTF = new TextField(400, 50, "ОТЛИЧНО!", "Arial", 28, 0xFFFFFF, true);
        _winTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _winTF.x = stage.stageWidth/2;
        _winTF.y = 712;
        _winTF.pivotX = _winTF.width/2;
        addChild(_winTF);

        _continueBtn = new Button(_assets.getTexture("invitefriend_btn_up"), "ПРОДОЛЖИТЬ", _assets.getTexture("invitefriend_btn_down"));

        _continueBtn.fontBold = true;
        _continueBtn.fontColor = 0xFFFFFF;
        _continueBtn.fontName = "Arial";
        _continueBtn.fontSize = 32;

        _continueBtn.x = stage.stageWidth/2;
        _continueBtn.y = 785;
        _continueBtn.pivotX = _continueBtn.width/2;
        addChild(_continueBtn);

        _continueBtn.addEventListener(Event.TRIGGERED, handleContinue);
    }

    private function handleContinue(event: Event):void {
        dispatchEventWith(CONTINUE);
    }
}
}
