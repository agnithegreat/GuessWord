/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 29.05.13
 * Time: 14:25
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.game.Letter;
import com.orchideus.guessWord.ui.abstract.AbstractView;

public class ErrorView extends AbstractView {

    private var _letters: String;

    public function ErrorView(refs: CommonRefs, letters: String) {
        _letters = letters;

        super(refs);
    }

    override protected function initialize():void {
        for (var i:int = 0; i < _letters.length; i++) {
            var letter: Letter = new Letter();
            letter.setLetter(_letters.charAt(i), false);
            var slot: SlotTile = new SlotTile(_refs, letter);
            slot.x = i * BottomPanel.TILE;
            addChild(slot);
            letter.mistake();
        }
    }
}
}
