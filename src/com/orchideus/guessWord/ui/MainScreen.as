/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 13:14
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.ui.abstract.Screen;
import com.orchideus.guessWord.ui.bank.BankPopup;
import com.orchideus.guessWord.ui.game.GameScreen;
import com.orchideus.guessWord.ui.preloader.Preloader;

import feathers.core.PopUpManager;

import starling.display.Quad;

public class MainScreen extends Screen {

    private var _controller: GameController;

    private var _preloader: Preloader;
    private var _game: GameScreen;
    private var _bank: BankPopup;

    private var _overlay: Quad;
    public function getOverlay():Quad {
        return _overlay;
    }

    public function MainScreen(refs: CommonRefs, controller: GameController) {
        _controller = controller;

        super(refs);
    }

    override protected function initialize():void {
        _preloader = new Preloader(_refs, _controller);
        addChild(_preloader);

        _overlay = new Quad(stage.stageWidth, stage.stageHeight, 0);
        _overlay.alpha = 0.5;
    }

    public function showGame():void {
        if (_preloader) {
            _preloader.destroy();
            removeChild(_preloader, true);
            _preloader = null;
        }

        _game = new GameScreen(_refs, _controller);
        addChild(_game);
    }

    public function showBank():void {
        if (!_bank) {
            _bank = new BankPopup(_refs);
        }

        PopUpManager.addPopUp(_bank, true, true, getOverlay);
    }

    override public function destroy():void {
        super.destroy();

        if (_game) {
            _game.destroy();
            removeChild(_game);
            _game = null;
        }
    }
}
}
