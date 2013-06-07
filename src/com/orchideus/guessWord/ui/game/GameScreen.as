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
import com.orchideus.guessWord.ui.friends.FriendBar;

import starling.display.Button;
import starling.events.Event;
import starling.utils.AssetManager;

public class GameScreen extends Screen {

    private var _controller: GameController;

    private var _topPanel: TopPanel;
    private var _leftPanel: LeftPanel;
    private var _rightPanel: RightPanel;
    private var _middlePanel: MiddlePanel;
    private var _bottomPanel: BottomPanel;
    private var _winPanel: WinPanel;

    private var _friendBar: FriendBar;

    private var _soundBtn: Button;

    public function GameScreen(assets:AssetManager, deviceType: DeviceType, controller: GameController) {
        _controller = controller;
        _controller.game.addEventListener(Game.INIT, handleInitGame);
        _controller.game.addEventListener(Game.WIN, handleWin);

        super(assets, deviceType, "main_under");
    }

    override protected function initialize():void {
        _topPanel = new TopPanel(_assets, _deviceType, _controller.player);
        addChild(_topPanel);

        _leftPanel = new LeftPanel(_assets, _deviceType);

        _rightPanel = new RightPanel(_assets, _deviceType);
        addChild(_rightPanel);

        _middlePanel = new MiddlePanel(_assets, _deviceType, _controller.game);
        addChild(_middlePanel);

        _bottomPanel = new BottomPanel(_assets, _deviceType, _controller.game);
        addChild(_bottomPanel);

        _winPanel = new WinPanel(_assets, _deviceType);
        _winPanel.addEventListener(WinPanel.CONTINUE, handleContinue);
        addChild(_winPanel);
        _winPanel.visible = false;

        _friendBar = new FriendBar(_assets, _deviceType, _controller);
        addChild(_friendBar);

        _soundBtn = new Button(_assets.getTexture("main_sound_up"), "", _assets.getTexture("main_sound_down"));
        _soundBtn.addEventListener(Event.TRIGGERED, handleSound);
        addChild(_soundBtn);

        updateSoundState();
    }

    override protected function align():void {
        super.align();

        switch (_deviceType) {
            case DeviceType.iPad:
                place(_friendBar, 55, 328);
                place(_soundBtn, 700, 810);
                break;
            case DeviceType.iPhone5:
                place(_friendBar, 0, 475);
                place(_soundBtn, 55, 328);
                break;
            case DeviceType.iPhone4:
                place(this, 0, -44);
                place(_friendBar, 0, 475);
                place(_soundBtn, 55, 328);
                break;
        }
    }

    private function handleInitGame(event: Event):void {
        addChild(_leftPanel);

        _bottomPanel.visible = true;
        _winPanel.visible = false;

        _middlePanel.update();
    }

    private function handleWin(event: Event):void {
        _middlePanel.updateDescription();

        _bottomPanel.visible = false;
        _winPanel.visible = true;
    }

    private function handleContinue(event: Event):void {
        _controller.nextRound();
    }

    private function handleSound(event: Event):void {
        dispatchEventWith(Sound.SOUND, true, Sound.CLICK);

        Sound.enabled = !Sound.enabled;
        updateSoundState();
    }

    private function updateSoundState():void {
        _soundBtn.upState = Sound.enabled ? _assets.getTexture("main_sound_up") : _assets.getTexture("main_no_sound_up");
        _soundBtn.downState = Sound.enabled ? _assets.getTexture("main_sound_down") : _assets.getTexture("main_no_sound_down");
    }
}
}
