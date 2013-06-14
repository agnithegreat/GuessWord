/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 15:45
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.VAlign;

public class WinPanel extends AbstractView {

    public static const CONTINUE: String = "continue_WinPanel";

    private var _controller: GameController;

    private var _winTF: TextField;
    private var _msgTF: TextField;

    private var _continueBtn: Button;
    private var _continueTF: TextField;

    public function WinPanel(refs: CommonRefs, controller: GameController) {
        _controller = controller;

        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _continueBtn = new Button(_refs.assets.getTexture("main_next_btn_up"), "", _refs.assets.getTexture("main_next_btn_down"));
        _continueBtn.addEventListener(Event.TRIGGERED, handleContinue);
        _continueBtn.pivotX = _continueBtn.width/2;
        addChild(_continueBtn);

        super.initialize();

        _winTF.touchable = false;
        addChild(_winTF);

        _msgTF.touchable = false;
        _msgTF.vAlign = VAlign.TOP;
        addChild(_msgTF);

        _continueTF.pivotX = _continueTF.width/2;
        _continueTF.touchable = false;
        addChild(_continueTF);

        _msgTF.text = _refs.locale.getString("main.success.msg").replace("[value]", Math.max(0, Friend.bestResult-_controller.player.level));
    }

    override protected function initializeIPad():void {
        _winTF = createTextField(stage.stageWidth, 50, 42, _refs.locale.getString("main.success.title"));
        _winTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _winTF.y = 695;

        _msgTF = createTextField(stage.stageWidth, 60, 18);
        _msgTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _msgTF.y = 750;

        _continueBtn.x = stage.stageWidth/2;
        _continueBtn.y = 805;

        _continueTF = createTextField(_continueBtn.width, _continueBtn.height, 30, _refs.locale.getString("main.success.continue"));
        _continueTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 4, 3)];
        _continueTF.x = stage.stageWidth/2;
        _continueTF.y = 805;
    }

    override protected function initializeIPhone():void {
        _winTF = createTextField(stage.stageWidth, 50, 20, _refs.locale.getString("main.success.title"));
        _winTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _winTF.y = 330;

        _msgTF = createTextField(stage.stageWidth, 100, 12);
        _msgTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _msgTF.y = 370;

        _continueBtn.x = stage.stageWidth/2;
        _continueBtn.y = 420;

        _continueTF = createTextField(_continueBtn.width, _continueBtn.height, 18, _refs.locale.getString("main.success.continue"));
        _continueTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 4, 3)];
        _continueTF.x = stage.stageWidth/2;
        _continueTF.y = 420;
    }

    private function handleContinue(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);
        dispatchEventWith(CONTINUE);
    }
}
}
