/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 27.05.13
 * Time: 22:18
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.game.Letter;
import com.orchideus.guessWord.ui.abstract.AbstractView;
import com.orchideus.guessWord.ui.tile.LetterTile;

import starling.display.Image;

public class SlotTile extends AbstractView {

    private var _back: Image;

    private var _letter: LetterTile;

    public function SlotTile(refs: CommonRefs, letter: Letter) {
        _letter = new LetterTile(refs, letter);

        super(refs);
    }

    override protected function initialize():void {
        _back = new Image(_refs.assets.getTexture("main_mistake_shadow"));
        _back.touchable = false;
        addChild(_back);

        addChild(_letter);

        super.initialize();
    }

    override protected function initializeIPhone():void {
        _back.x = 2;
    }

    override public function destroy():void {
        _back.dispose();
        removeChild(_back);
        _back = null;

        _letter.destroy();
        removeChild(_letter);
        _letter = null;
    }
}
}
