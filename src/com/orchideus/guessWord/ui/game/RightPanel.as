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

    public function RightPanel(refs: CommonRefs, controller: GameController) {
        _controller = controller;
        _controller.social.addEventListener(Social.LOGGED_IN, handleLoggedIn);

        super(refs);
    }

    override protected function initialize():void {
        _bar = new ScoreBar(_refs, _controller);
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

    override protected function initializeIPad():void {
        _bar.x = 697;
        _bar.y = 283;

        _wordStats.x = 282;
        _wordStats.y = 13;

        _askHelp.x = 686;
        _askHelp.y = 92;

        _invite.x = 686;
        _invite.y = 211;
    }

    override protected function initializeIPhone():void {
        _bar.x = 288;
        _bar.y = 188;

        _wordStats.x = 112;
        _wordStats.y = 46;

        _askHelp.x = 282;
        _askHelp.y = 80;

        _invite.x = 282;
        _invite.y = 138;
    }

    private function handleLoggedIn(event: Event):void {
        _wordStats.enable();
        _askHelp.enable();
        _invite.enable();
    }
}
}
