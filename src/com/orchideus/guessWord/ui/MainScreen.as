/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 13:14
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.Screen;
import com.orchideus.guessWord.ui.game.GameScreen;

import starling.utils.AssetManager;

public class MainScreen extends Screen {

    private var _currentScreen: Screen;

    public function MainScreen(assets:AssetManager, deviceType: DeviceType) {
        super(assets, deviceType, "main_under");
    }

    public function showGame(controller: GameController):void {
        _currentScreen = new GameScreen(_assets, _deviceType, controller);
        addChild(_currentScreen);
    }

    public function showBank():void {
        // TODO: сделать банк
        trace("open bank");
    }

    override public function destroy():void {
        super.destroy();

        if (_currentScreen) {
            _currentScreen.destroy();
            removeChild(_currentScreen);
            _currentScreen = null;
        }
    }
}
}
