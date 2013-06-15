/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 9:32
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.social.Social;
import com.orchideus.guessWord.ui.abstract.AbstractView;
import com.orchideus.guessWord.ui.tile.AskHelpTile;
import com.orchideus.guessWord.ui.tile.InviteTile;
import com.orchideus.guessWord.ui.tile.WordStatsTile;

import starling.events.Event;

public class RightPanel extends AbstractView {

    private var _controller:GameController;

    private var _wordStats: WordStatsTile;
    private var _askHelp: AskHelpTile;
    private var _invite: InviteTile;

    private var _bar: ScoreBar;

    private var _logged: Boolean;

    public function RightPanel(refs: CommonRefs, controller: GameController) {
        _controller = controller;
        _controller.game.addEventListener(Game.INIT, handleInit);
        _controller.social.addEventListener(Social.LOGGED_IN, handleLoggedIn);

        super(refs);
    }

    override protected function initialize():void {
        _bar = new ScoreBar(_refs, _controller);
        _bar.touchable = false;
        addChild(_bar);

        _wordStats = new WordStatsTile(_refs);
        addChild(_wordStats);

        _askHelp = new AskHelpTile(_refs);
        addChild(_askHelp);

        _invite = new InviteTile(_refs);
        addChild(_invite);

        super.initialize();

        if (_controller.social.session) {
            handleLoggedIn(null);
        }
    }

    override protected function initializeIPhone():void {
        _bar.x = 576;
        _bar.y = 376;

        _wordStats.x = 224;
        _wordStats.y = 92;

        _askHelp.x = 564;
        _askHelp.y = 160;

        _invite.x = 564;
        _invite.y = 276;
    }

    private function handleInit(event: Event):void {
        if (_logged) {
            _wordStats.update(Friend.getAnySucceed(_controller.game.word.word_id));
        }
    }

    private function handleLoggedIn(event: Event):void {
        _askHelp.enable();
        _invite.enable();

        _logged = true;

        handleInit(null);
    }
}
}
