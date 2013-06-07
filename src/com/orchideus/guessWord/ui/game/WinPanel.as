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
import starling.utils.VAlign;

public class WinPanel extends AbstractView {

    public static const CONTINUE: String = "continue_WinPanel";

    private var _winTF: TextField;
    private var _msgTF: TextField;

    private var _continueBtn: Button;
    private var _continueTF: TextField;

    public function WinPanel(assets: AssetManager, deviceType: DeviceType) {
        super(assets, deviceType);
    }

    override protected function initialize():void {
        _winTF = new TextField(stage.stageWidth, 50, "ОТЛИЧНО!", "Arial", 28, 0xFFFFFF, true);
        _winTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        addChild(_winTF);

        _msgTF = new TextField(stage.stageWidth, 100, "", "Arial", 28, 0xFFFFFF, true);
        _msgTF.vAlign = VAlign.TOP;
        _msgTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        addChild(_msgTF);

        _continueBtn = new Button(_assets.getTexture("main_next_btn_up"), "", _assets.getTexture("main_next_btn_down"));
        _continueBtn.addEventListener(Event.TRIGGERED, handleContinue);
        _continueBtn.pivotX = _continueBtn.width/2;
        addChild(_continueBtn);

        _continueTF = new TextField(_continueBtn.width, _continueBtn.height, "ПРОДОЛЖИТЬ", "Arial", 24, 0xFFFFFF, true);
        _continueTF.pivotX = _continueTF.width/2;
        _continueTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 4, 3)];
        _continueTF.touchable = false;
        addChild(_continueTF);

        // TODO: replace amount
        _msgTF.text = "ЧТОБЫ ДОГНАТЬ БЛИЖАЙШЕГО ДРУГА\nВАМ НУЖНО ОТГАДАТЬ ЕЩЕ " + 18 + " СЛОВ"
    }

    override protected function align():void {
        switch (_deviceType) {
            case DeviceType.iPad:
                place(_winTF, 0, 712);
                place(_continueBtn, (stage.stageWidth)/2, 785);
                place(_continueTF, (stage.stageWidth)/2, 785);
                _continueTF.fontSize = 36;
                break;
            case DeviceType.iPhone5:
            case DeviceType.iPhone4:
                place(_winTF, 0, 330);
                _winTF.fontSize = 20;
                place(_msgTF, 0, 370);
                _msgTF.fontSize = 12;
                place(_continueBtn, (stage.stageWidth)/2, 420);
                place(_continueTF, (stage.stageWidth)/2, 420);
                _continueTF.fontSize = 18;
                break;
        }
    }

    private function handleContinue(event: Event):void {
        dispatchEventWith(CONTINUE);
    }
}
}
