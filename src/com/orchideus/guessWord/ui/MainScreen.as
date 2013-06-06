/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 13:14
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.Screen;
import com.orchideus.guessWord.ui.game.GameScreen;
import com.orchideus.guessWord.ui.preloader.Preloader;

import starling.events.Touch;
import starling.events.TouchEvent;
import starling.utils.AssetManager;

public class MainScreen extends Screen {

    private var _controller: GameController;

    private var _preloader: Preloader;
    private var _game: GameScreen;

    public function MainScreen(assets:AssetManager, deviceType: DeviceType, controller: GameController) {
        _controller = controller;

        super(assets, deviceType);
    }

    override protected function initialize():void {
        _preloader = new Preloader(_assets, _deviceType, _controller);
        addChild(_preloader);

//        stage.addEventListener(TouchEvent.TOUCH, handleTouch);
    }

    private function handleTouch(event: TouchEvent):void {
        var touch: Touch = event.getTouch(this);
        if (touch) {
            trace(touch.globalX, touch.globalY);
        }
    }

    public function showGame():void {
        if (_preloader) {
            _preloader.destroy();
            removeChild(_preloader, true);
            _preloader = null;
        }

        _game = new GameScreen(_assets, _deviceType, _controller);
        addChild(_game);
    }

    public function showBank():void {
        // TODO: сделать банк
        trace("open bank");
    }

    override public function destroy():void {
        super.destroy();

        if (_game) {
            _game.destroy();
            removeChild(_game);
            _game = null;
        }
    }
}
}
