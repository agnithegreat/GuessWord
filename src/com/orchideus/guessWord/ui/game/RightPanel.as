/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 9:32
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.ui.abstract.AbstractView;
import com.orchideus.guessWord.ui.tile.AskHelpTile;
import com.orchideus.guessWord.ui.tile.InviteTile;

import starling.utils.AssetManager;

public class RightPanel extends AbstractView {

    private var _controller:GameController;

    private var _askHelp: AskHelpTile;
    private var _invite: InviteTile;

    private var _bar: ScoreBar;

    public function RightPanel(assets: AssetManager, deviceType: DeviceType, controller: GameController) {
        _controller = controller;

        super(assets, deviceType);
    }

    override protected function initialize():void {
        _bar = new ScoreBar(_assets, _deviceType, _controller);
        addChild(_bar);

        _askHelp = new AskHelpTile(_assets, _deviceType);
        addChild(_askHelp);

        _invite = new InviteTile(_assets, _deviceType);
        addChild(_invite);

        super.initialize();
    }

    override protected function initializeIPad():void {
        _bar.x = 697;
        _bar.y = 283;

        _askHelp.x = 686;
        _askHelp.y = 92;

        _invite.x = 686;
        _invite.y = 211;
    }

    override protected function initializeIPhone():void {
        _bar.x = 288;
        _bar.y = 188;

        _askHelp.x = 282;
        _askHelp.y = 80;

        _invite.x = 282;
        _invite.y = 138;
    }
}
}
