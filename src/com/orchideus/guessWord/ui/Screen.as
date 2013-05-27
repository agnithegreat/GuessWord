/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.ui.game.GameScreen;
import com.orchideus.guessWord.ui.preloader.Preloader;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import starling.display.Sprite;
import starling.utils.AssetManager;

public class Screen extends Sprite {

    public static const PRELOADER: String = "preloader";
    public static const GAME_SCREEN: String = "game_screen";

    private var _navigator: ScreenNavigator;

    public function Screen(app: App, assets: AssetManager) {
        _navigator = new ScreenNavigator();
        addChild(_navigator);

        _navigator.addScreen(PRELOADER, new ScreenNavigatorItem(Preloader, null, {"assets": assets, "app": app}));
        _navigator.addScreen(GAME_SCREEN, new ScreenNavigatorItem(GameScreen, null, {"assets": assets, "app": app}));
    }

    public function showPreloader():void {
        _navigator.showScreen(PRELOADER);
    }

    public function showGame():void {
        _navigator.showScreen(GAME_SCREEN);
    }
}
}
