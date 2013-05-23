/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 23.05.13
 * Time: 10:59
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.game.Word;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class WordView extends Sprite {

    public static const TILE: int = 52;
    public static const MAX_LETTERS: int = 15;

    private var _word: Word;

    private var _assets: AssetManager;

    private var _letters: Vector.<Image>;
    private var _container: Sprite;

    private var _error: Image;

    public function WordView(word: Word, assets: AssetManager) {
        _word = word;
        _word.addEventListener(Word.UPDATE, handleUpdate);
        _word.addEventListener(Word.ERROR, handleError);

        _assets = assets;

        _container = new Sprite();
        addChild(_container);

        _error = new Image(assets.getTexture("error"));

        _letters = new <Image>[];
        for (var i:int = 0; i < MAX_LETTERS; i++) {
            _letters[i] = new Image(_assets.getTexture("empty_symbol"));
            _letters[i].x = i*TILE;
        }
    }

    private function handleUpdate(event:Event):void {
        _container.removeChildren();

        for (var i:int = 0; i < _letters.length; i++) {
            if (i<_word.letters.length) {
                _container.addChild(_letters[i]);
            }
        }

        pivotX = width/2;
    }

    private function handleError(event:Event):void {
        _container.removeChildren();
        addChild(_error);

        pivotX = width/2;
    }
}
}
