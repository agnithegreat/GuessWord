/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.abstract.Screen;
import com.orchideus.guessWord.ui.friends.FriendBar;

import starling.display.Button;
import starling.events.Event;

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

    public function GameScreen(refs: CommonRefs, controller: GameController) {
        _controller = controller;

        _controller.addEventListener(GameController.CHANGE_IMAGE, handleChangeImage);
        _controller.addEventListener(GameController.IMAGE_CHANGED, handleImageChanged);

        _controller.game.addEventListener(Game.INIT, handleInitGame);
        _controller.game.addEventListener(Game.WIN, handleWin);

        super(refs, "main_under");
    }

    override protected function initialize():void {
        _topPanel = new TopPanel(_refs, _controller.player);
        addChild(_topPanel);

        _leftPanel = new LeftPanel(_refs);

        _rightPanel = new RightPanel(_refs, _controller);
        addChild(_rightPanel);

        _middlePanel = new MiddlePanel(_refs, _controller.game);
        addChild(_middlePanel);

        _bottomPanel = new BottomPanel(_refs, _controller);
        addChild(_bottomPanel);

        _winPanel = new WinPanel(_refs, _controller);
        _winPanel.addEventListener(WinPanel.CONTINUE, handleContinue);
        addChild(_winPanel);
        _winPanel.visible = false;

        _friendBar = new FriendBar(_refs, _controller);
        addChild(_friendBar);

        _soundBtn = new Button(_refs.assets.getTexture("main_sound_up"), "", _refs.assets.getTexture("main_sound_down"));
        _soundBtn.addEventListener(Event.TRIGGERED, handleSound);
        addChild(_soundBtn);

        super.initialize();

        updateSoundState();
    }

    override protected function initializeIPhone():void {
        y = (stage.stageHeight-_background.height)/2;

        _friendBar.y = 950;

        _soundBtn.x = 110;
        _soundBtn.y = 656;
    }

    private function handleInitGame(event: Event):void {
        addChild(_leftPanel);

        _bottomPanel.visible = true;
        _winPanel.visible = false;

        _middlePanel.update();
    }

    private function handleChangeImage(event: Event):void {
        _middlePanel.showSelectImage();
    }

    private function handleImageChanged(event: Event):void {
        _middlePanel.hideSelectImage();
    }

    private function handleWin(event: Event):void {
        _middlePanel.updateDescription();

        _winPanel.update();

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
        _soundBtn.upState = Sound.enabled ? _refs.assets.getTexture("main_sound_up") : _refs.assets.getTexture("main_no_sound_up");
        _soundBtn.downState = Sound.enabled ? _refs.assets.getTexture("main_sound_down") : _refs.assets.getTexture("main_no_sound_down");
    }
}
}
