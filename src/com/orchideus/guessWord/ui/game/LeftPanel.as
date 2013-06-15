/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:25
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.ui.abstract.AbstractView;
import com.orchideus.guessWord.ui.tile.BonusTile;

public class LeftPanel extends AbstractView {

    private var _openLetter: BonusTile;
    private var _removeLetters: BonusTile;
    private var _changePic: BonusTile;

    public function LeftPanel(refs: CommonRefs) {
        super(refs);
    }

    override protected function initialize():void {
        _openLetter = new BonusTile(_refs, Bonus.BONUSES[Bonus.OPEN_LETTER]);
        addChild(_openLetter);

        _removeLetters = new BonusTile(_refs, Bonus.BONUSES[Bonus.REMOVE_LETTERS]);
        addChild(_removeLetters);

        _changePic = new BonusTile(_refs, Bonus.BONUSES[Bonus.CHANGE_PICTURE]);
        addChild(_changePic);

        super.initialize();
    }

    override protected function initializeIPhone():void {
        _openLetter.x = 2;
        _openLetter.y = 180;

        _removeLetters.x = 2;
        _removeLetters.y = 330;

        _changePic.x = 2;
        _changePic.y = 480;
    }
}
}
