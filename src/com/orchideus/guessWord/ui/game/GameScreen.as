/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.abstract.Screen;

import starling.display.Button;
import starling.events.Event;
import starling.utils.AssetManager;

public class GameScreen extends Screen {

    private var _controller: GameController;

    private var _topPanel: TopPanel;
    private var _leftPanel: LeftPanel;
    private var _middlePanel: MiddlePanel;
    private var _bottomPanel: BottomPanel;

    private var _winPanel: WinPanel;

    private var _soundBtn: Button;

    public function GameScreen(assets:AssetManager, deviceType: DeviceType, controller: GameController) {
        _controller = controller;
        _controller.game.addEventListener(Game.INIT, handleInitGame);
//        _game.addEventListener(Game.WIN, handleWin);

        super(assets, deviceType, "main_under");
    }

    override protected function initialize():void {
        _topPanel = new TopPanel(_assets, _deviceType, _controller.player);
        addChild(_topPanel);

//        _leftPanel = new LeftPanel(_assets);
//        _leftPanel.addEventListener(BonusTile.USE, handleUseBonus);
//        addChild(_leftPanel);

        _middlePanel = new MiddlePanel(_assets, _deviceType, _controller.game);
        addChild(_middlePanel);

//        _bottomPanel = new BottomPanel(_assets);
//        addChild(_bottomPanel);

//        _winPanel = new WinPanel(_assets);
//        _winPanel.addEventListener(WinPanel.CONTINUE, handleContinue);
//        addChild(_winPanel);
//        _winPanel.visible = false;

//        _soundBtn = new Button(_assets.getTexture("sound_btn_down"), "", _assets.getTexture("sound_btn_up"));
//        _soundBtn.addEventListener(Event.TRIGGERED, handleSound);
//        _soundBtn.x = 700;
//        _soundBtn.y = 810;
//        addChild(_soundBtn);
    }

    override protected function align():void {
        super.align();

        switch (_deviceType) {
            case DeviceType.iPad:
                break;
            case DeviceType.iPhone5:
                break;
            case DeviceType.iPhone4:
                place(this, 0, -44);
                break;
        }
    }

    private function handleInitGame(event: Event):void {
//        _leftPanel.init();
//        _bottomPanel.init(_game);
//        _winPanel.init();

        _middlePanel.update();
    }

    private function handleUseBonus(event: Event):void {
//        _game.useBonus(event.data as Bonus);
    }

    private function handleWin(event: Event):void {
//        _middlePanel.updateDescription(_game);

        _bottomPanel.visible = false;
        _winPanel.visible = true;
    }

    private function handleContinue(event: Event):void {
        _bottomPanel.visible = true;
        _winPanel.visible = false;

//        _app.nextRound();
    }

    private function handleSound(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);

        Sound.enabled = !Sound.enabled;

        // TODO: добавить стейты
        _soundBtn.downState = _assets.getTexture("sound_btn_down");
        _soundBtn.upState = _assets.getTexture("sound_btn_up");
    }
}
}
