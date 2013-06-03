/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.tile.BonusTile;

import feathers.controls.Screen;

import starling.display.Button;

import starling.display.Image;
import starling.events.Event;
import starling.utils.AssetManager;

public class GameScreen extends Screen {

    private var _assets: AssetManager;
    public function get assets():AssetManager {
        return _assets;
    }
    public function set assets(value: AssetManager):void {
        _assets = value;
    }

    private var _app: App;
    public function get app():App {
        return _app;
    }
    public function set app(value: App):void {
        _app = value;
        _app.addEventListener(App.INIT, handleInit);
    }

    private var _game: Game;

    private var _background: Image;

    private var _topPanel: TopPanel;
    private var _leftPanel: LeftPanel;
    private var _middlePanel: MiddlePanel;
    private var _bottomPanel: BottomPanel;

    private var _winPanel: WinPanel;

    private var _soundBtn: Button;

    override protected function initialize():void {
        _background = new Image(assets.getTexture("main_under"));
        addChild(_background);

        _topPanel = new TopPanel(_assets);
        addChild(_topPanel);

        _leftPanel = new LeftPanel(_assets);
        _leftPanel.addEventListener(BonusTile.USE, handleUseBonus);
        addChild(_leftPanel);

        _middlePanel = new MiddlePanel(_assets);
        addChild(_middlePanel);

        _bottomPanel = new BottomPanel(_assets);
        addChild(_bottomPanel);

        _winPanel = new WinPanel(_assets);
        _winPanel.addEventListener(WinPanel.CONTINUE, handleContinue);
        addChild(_winPanel);
        _winPanel.visible = false;

        _soundBtn = new Button(_assets.getTexture("sound_btn_down"), "", _assets.getTexture("sound_btn_up"));
        _soundBtn.addEventListener(Event.TRIGGERED, handleSound);
        _soundBtn.x = 700;
        _soundBtn.y = 810;
        addChild(_soundBtn);
    }

    private function handleInit(event: Event):void {
        _game = _app.game;
        _game.addEventListener(Game.INIT, handleInitGame);
        _game.addEventListener(Game.WIN, handleWin);
        _game.addEventListener(Game.UPDATE, handleUpdate);

        _topPanel.init();
        _leftPanel.init();
        _middlePanel.init();
        _bottomPanel.init(_game);
        _winPanel.init();
    }

    private function handleInitGame(event: Event):void {
        _middlePanel.update(_game);
    }

    private function handleUpdate(event: Event):void {
        _topPanel.update();
    }

    private function handleUseBonus(event: Event):void {
        _game.useBonus(event.data as Bonus);
    }

    private function handleWin(event: Event):void {
        _middlePanel.updateDescription(_game);

        _bottomPanel.visible = false;
        _winPanel.visible = true;
    }

    private function handleContinue(event: Event):void {
        _bottomPanel.visible = true;
        _winPanel.visible = false;

        _app.nextRound();
    }

    private function handleSound(event: Event):void {
        Sound.play(Sound.CLICK);

        Sound.enabled = !Sound.enabled;

        // TODO: добавить стейты
        _soundBtn.downState = _assets.getTexture("sound_btn_down");
        _soundBtn.upState = _assets.getTexture("sound_btn_up");
    }
}
}
