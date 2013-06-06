/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 11:44
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.server.Server;
import com.orchideus.guessWord.ui.MainScreen;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.EventDispatcher;
import starling.utils.AssetManager;

public class GameController extends EventDispatcher {

    public static const PROGRESS: String = "progress_GameController";

    private var _player: Player;
    public function get player():Player {
        return _player;
    }

    private var _game: Game;
    public function get game():Game {
        return _game;
    }

    private var _view: MainScreen;

    private var _server: Server;

    private var _loaded: Boolean;

    public function GameController(container: Sprite, assets: AssetManager, deviceType: DeviceType) {
        _player = new Player();

        _view = new MainScreen(assets, deviceType, this);
        _view.addEventListener(Language.LANGUAGE, handleSelectLanguage);
        _view.addEventListener(Bank.OPEN, handleOpenBank);
        container.addChild(_view);
    }

    public function preloaderProgress(value: Number):void {
        dispatchEventWith(PROGRESS, false, value);
    }

    public function init():void {
        _loaded = true;
        if (!_player.lang) {
            return;
        }

        _game = new Game();
//        _game.addEventListener(Game.SEND_WORD, handleSendWord);
//        _game.addEventListener(Game.USE_BONUS, handleUseBonus);

        _server = new Server();
        _server.init("1", _player.uid);
        _server.addEventListener(Server.DATA, handleData);

        _server.getParameters();

        _view.showGame();
    }

    // ************************
    // ** section from model **
    // ************************
//    private function handleSendWord(event: Event):void {
//        _server.checkWord(_game.word.word_id, _game.word.word);
//    }
//
//    public function nextRound():void {
//        _game.word.clear(true);
//        _game.initWord(_tempData.new_word);
//        _tempData = null;
//    }

//    private function handleUseBonus(event: Event):void {
//        switch (event.data) {
//            case Bonus.OPEN_LETTER:
//                _server.openLetter();
//                break;
//            case Bonus.REMOVE_LETTERS:
//                _server.removeLetters();
//                break;
//            case Bonus.CHANGE_PICTURE:
////                _server.changePicture();
//                break;
//            case Bonus.REMOVE_WRONG_PICTURE:
//                _server.removeWrongPicture();
//                break;
//        }
//    }

    private function handleData(event: Event):void {
        var data: Object = event.data;
        switch (data.method) {
            case Server.GET_PARAMETERS:
                if (data.result == "success") {
                    _player.parse(data.player.params);
//                    Bonus.parse(data.variables);
//                    Bank.parse(data.bank);
//                    Variables.parse(data.variables);
//
//                    _game.updateStack(data.player.params);
                    _game.initWord(data.word);
                }
                break;
//            case Server.CHECK_WORD:
//                if (data.result == "success") {
//                    _tempData = data;
//                    _game.updateStack(data.player.params);
//                    _game.updatePlayer(data.player.params);
//                    _game.updateDescription(data.word);
//                    _game.win();
//                } else {
//                    _game.wordError();
//                }
//                break;
//            case Server.OPEN_LETTER:
//                _game.word.clear(false);
//                _game.updatePlayer(data.player.params);
//                _game.updateWord(data.word);
//                break;
//            case Server.REMOVE_LETTERS:
//                _game.word.clear(false);
//                _game.updateStack(data.player.params);
//                _game.updatePlayer(data.player.params);
//                break;
//            case Server.CHANGE_PICTURE:
//                _game.updatePlayer(data.player.params);
//                break;
//            case Server.REMOVE_WRONG_PICTURE:
//                _game.updatePlayer(data.player.params);
//                break;
        }
    }

    // ***********************
    // ** section from view **
    // ***********************
    private function handleSelectLanguage(event: Event):void {
        // TODO: сделать LocaleManager
        _player.lang = (event.data as Language).title;

        if (_loaded) {
            init();
        }
    }

    private function handleOpenBank(event: Event):void {
        // TODO: проверка, можно ли открывать сейчас
        _view.showBank();
    }
}
}
