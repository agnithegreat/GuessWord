/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.game.Game;

import feathers.controls.Screen;

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
    private var _middlePanel: MiddlePanel;
    private var _bottomPanel: BottomPanel;

    override protected function initialize():void {
        _background = new Image(assets.getTexture("main_under"));
        addChild(_background);

        _topPanel = new TopPanel(_assets);
        addChild(_topPanel);

        _middlePanel = new MiddlePanel(_assets);
        addChild(_middlePanel);

        _bottomPanel = new BottomPanel(_assets);
        addChild(_bottomPanel);
    }

    private function handleInit(event: Event):void {
        _game = _app.game;
        _game.addEventListener(Game.INIT, handleInitGame);
        _game.addEventListener(Game.UPDATE, handleUpdate);
        _game.addEventListener(Game.WIN, handleWin);

        _topPanel.init();
        _middlePanel.init();
        _bottomPanel.init(_game);
    }

    private function handleInitGame(event: Event):void {
        _middlePanel.update(_game);
    }

    private function handleUpdate(event: Event):void {
        _topPanel.update();
    }

    private function handleWin(event:Event):void {
        Sound.play(Sound.WIN);
    }
}
}
