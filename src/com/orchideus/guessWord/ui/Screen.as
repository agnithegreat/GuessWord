/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.ui.bank.BankPopup;
import com.orchideus.guessWord.ui.game.GameScreen;
import com.orchideus.guessWord.ui.preloader.Preloader;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.core.PopUpManager;

import starling.display.Sprite;
import starling.utils.AssetManager;

public class Screen extends Sprite {

    public static const PRELOADER: String = "preloader";
    public static const GAME_SCREEN: String = "game_screen";
    public static const BANK: String = "bank";

    private var _navigator: ScreenNavigator;

    private var _bankPopup: BankPopup;

    public function Screen(app: App, assets: AssetManager) {
        _navigator = new ScreenNavigator();
        addChild(_navigator);

        _navigator.addScreen(PRELOADER, new ScreenNavigatorItem(Preloader, null, {"assets": assets, "app": app}));
        _navigator.addScreen(GAME_SCREEN, new ScreenNavigatorItem(GameScreen, {BANK: showBank}, {"assets": assets, "app": app}));

        _bankPopup = new BankPopup();
    }

    public function showPreloader(selectLanguage: Function):void {
        _navigator.showScreen(PRELOADER);

        if (selectLanguage is Function) {
            (_navigator.activeScreen as Preloader).showLanguages(selectLanguage);
        }
    }

    public function showGame():void {
        _navigator.showScreen(GAME_SCREEN);
    }

    public function showBank():void {
        // TODO: разобраться, почему не диспатчится
        PopUpManager.addPopUp(_bankPopup);
    }
}
}
