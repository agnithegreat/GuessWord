/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:23
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.ui.tile.LetterTile;

import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.utils.AssetManager;

public class BottomPanel extends Sprite {

    private var _assets: AssetManager;

    private var _game: Game;

    private var _letters: Vector.<LetterTile>;

    private var _wordView: WordView;
    private var _lettersView: LettersView;

    public function BottomPanel(assets: AssetManager) {
        _assets = assets;
    }

    public function init(game: Game):void {
        _game = game;

//        _letters = new <LetterTile>[];
//        for (var i:int = 0; i < _game.stack.letters.length; i++) {
//            _letters[i] = new LetterTile(_game.stack.letters[i], _assets);
//        }

        _wordView = new WordView(_game.word, _assets);
        _wordView.x = Guess.size.width/2;
        _wordView.y = 712;
        addChild(_wordView);

        _lettersView = new LettersView(_game.stack, _assets);
        _lettersView.x = Guess.size.width/2;
        _lettersView.y = 785;
        addChild(_lettersView);
    }

    public function update():void {

    }
}
}
