/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 15:45
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

public class WinPanel extends AbstractView {

    public static const CONTINUE: String = "continue_WinPanel";

    private var _winTF: TextField;

    private var _continueBtn: Button;

    public function WinPanel(assets: AssetManager, deviceType: DeviceType) {
        super(assets, deviceType);
    }

    override protected function initialize():void {
        _winTF = new TextField(400, 50, "ОТЛИЧНО!", "Arial", 28, 0xFFFFFF, true);
        _winTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _winTF.pivotX = _winTF.width/2;
        addChild(_winTF);


        // TODO: кнопка "продолжить"
        _continueBtn = new Button(_assets.getTexture("main_invite_btn_up"), "ПРОДОЛЖИТЬ", _assets.getTexture("main_invite_btn_down"));

//        _continueBtn.fontBold = true;
//        _continueBtn.fontColor = 0xFFFFFF;
//        _continueBtn.fontName = "Arial";
//        _continueBtn.fontSize = 32;

        _continueBtn.pivotX = _continueBtn.width/2;
        addChild(_continueBtn);

        _continueBtn.addEventListener(Event.TRIGGERED, handleContinue);
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(_winTF, (stage.stageWidth)/2, 712);
                place(_continueBtn, (stage.stageWidth)/2, 785);
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_winTF, (stage.stageWidth)/2, 400);
                place(_continueBtn, (stage.stageWidth)/2, 440);
                break;
        }
    }

    private function handleContinue(event: Event):void {
        dispatchEventWith(CONTINUE);
    }
}
}
