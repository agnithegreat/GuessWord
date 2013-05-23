/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.game.Game;

import starling.display.Sprite;
import starling.utils.AssetManager;

public class Screen extends Sprite {

    private var _gameScreen: GameScreen;

    public function Screen(game: Game, assets: AssetManager) {
        _gameScreen = new GameScreen(game, assets);
        addChild(_gameScreen);
    }
}
}
