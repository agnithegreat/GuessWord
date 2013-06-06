/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 11:44
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.data.Pic;
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.data.Variables;
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

    private var _currentBonus: Bonus;
    private var _currentPic: Pic;

    private var _view: MainScreen;

    private var _server: Server;

    private var _loaded: Boolean;

    private var _tempData: Object;

    public function GameController(container: Sprite, assets: AssetManager, deviceType: DeviceType) {
        _player = new Player();

        _view = new MainScreen(assets, deviceType, this);
        container.addChild(_view);
        addViewEventListeners();
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
        _game.addEventListener(Game.SEND_WORD, handleSendWord);

        _server = new Server();
        _server.init("1", _player.uid);
        _server.addEventListener(Server.DATA, handleData);

        _server.getParameters();

        _view.showGame();
    }

    private function addViewEventListeners():void {
        _view.addEventListener(Language.LANGUAGE, handleSelectLanguage);
        _view.addEventListener(Bank.OPEN, handleOpenBank);
        _view.addEventListener(Pic.SELECT, handleSelectPic);
        _view.addEventListener(Bonus.USE, handleUseBonus);
    }

    // *************************
    // ** section from server **
    // *************************
    private function handleData(event: Event):void {
        var data: Object = event.data;
        switch (data.method) {
            case Server.GET_PARAMETERS:
                if (data.result == "success") {
                    _player.parse(data.player.params);
                    Bonus.parse(data.variables);
                    Bank.parse(data.bank);
                    Variables.parse(data.variables);

                    // TODO: enable/disable, show/hide bonuses
//                    _changed_pic = Boolean(data.player.params.changed_pic);

                    _game.updateStack(data.player.params);
                    _game.initWord(data.word);
                    _game.initWrongPic(data.player.params);
                }
                break;
            case Server.CHECK_WORD:
                if (data.result == "success") {
                    _player.parse(data.player.params);

                    _tempData = data;
                    _game.updateStack(data.player.params);
                    _game.updateDescription(data.word);
                    _game.win();
                } else {
                    _game.wordError();
                }
                break;
            case Server.OPEN_LETTER:
                if (data.result == "success") {
                    _player.parse(data.player.params);
                    _game.word.clear(false);
                    _game.updateWord(data.word);
                    _game.updateStack(data.player.params);
                }
                break;
            case Server.REMOVE_LETTERS:
                if (data.result == "success") {
                    _player.parse(data.player.params);
                    _game.word.clear(false);
                    _game.updateStack(data.player.params);
                }
                break;
            case Server.CHANGE_PICTURE:
                if (data.result == "success") {
                    _player.parse(data.player.params);
                    _game.changePic(data.player.params.changed_pic);
                }
                break;
            case Server.REMOVE_WRONG_PICTURE:
                if (data.result == "success") {
                    _player.parse(data.player.params);
                    _game.changePic(data.player.params.changed_pic);
                }
                break;
        }
    }

    // ************************
    // ** section from model **
    // ************************
    private function handleSendWord(event: Event):void {
        _server.checkWord(_game.word.word_id, _game.word.word);
    }

    public function nextRound():void {
        _game.word.clear(true);
        _game.initWord(_tempData.new_word);
        _game.initWrongPic(_tempData.player.params);
        _tempData = null;
    }

    private function handleUseBonus(event: Event):void {
        var bonus: Bonus = event.data as Bonus;
        if (bonus.price > _player.money) {
            return;
        }

        _currentBonus = bonus;
        if (_currentBonus.id != Bonus.CHANGE_PICTURE) {
            applyBonus();
        }
    }

    private function applyBonus():void {
        switch (_currentBonus.id) {
            case Bonus.OPEN_LETTER:
                _server.openLetter();
                break;
            case Bonus.REMOVE_LETTERS:
                _server.removeLetters();
                break;
            case Bonus.CHANGE_PICTURE:
                if (_currentPic) {
                    _server.changePicture(_currentPic.id);
                }
                break;
            case Bonus.REMOVE_WRONG_PICTURE:
                _server.removeWrongPicture();
                break;
        }
        _currentBonus = null;
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

    private function handleSelectPic(event: Event):void {
        _currentPic = event.data as Pic;
        if (_currentBonus && _currentBonus.id==Bonus.CHANGE_PICTURE) {
            applyBonus();
        } else {
            _game.zoom();
        }
    }
}
}
