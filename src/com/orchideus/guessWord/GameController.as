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
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.data.Pic;
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.data.Variables;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.server.Server;
import com.orchideus.guessWord.ui.MainScreen;
import com.sticksports.nativeExtensions.inAppPurchase.InAppPurchase;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.EventDispatcher;
import starling.utils.AssetManager;

public class GameController extends EventDispatcher {

    public static const PROGRESS: String = "progress_GameController";
    public static const SHOW_LANGUAGES: String = "show_languages_GameController";
    public static const FRIENDS: String = "friends_GameController";

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
        if (_player.lang) {
            crateGame();
        } else {
            dispatchEventWith(SHOW_LANGUAGES);
        }
    }

    private function crateGame():void {
        _game = new Game();
        _game.addEventListener(Game.SEND_WORD, handleSendWord);

        _server = new Server();
        _server.init("1", _player.uid);
        _server.addEventListener(Server.DATA, handleData);

        _server.getParameters();
        _server.getFriendBar("");

        _view.showGame();
    }

    private function addViewEventListeners():void {
        _view.addEventListener(Language.LANGUAGE, handleSelectLanguage);
        _view.addEventListener(Bank.OPEN, handleOpenBank);
        _view.addEventListener(Pic.SELECT, handleSelectPic);
        _view.addEventListener(Bonus.USE, handleUseBonus);
        _view.addEventListener(Bank.BUY, handleBuyBank);
        _view.addEventListener(Friend.INVITE, handleInvite);
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
                    Bonus.init(data.variables);
                    Bank.parse(data.bank);
                    Variables.parse(data.variables);

                    _game.updateStack(data.player.params);
                    _game.initWord(data.word);
                    _game.changePic(data.player.params.changed_pic);
                    _game.init();
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

                    Sound.play(Sound.OPEN_LETTER);
                }
                break;
            case Server.REMOVE_LETTERS:
                if (data.result == "success") {
                    _player.parse(data.player.params);
                    _game.word.clear(false);
                    _game.updateStack(data.player.params);

                    Sound.play(Sound.REMOVE_LETTERS);
                }
                break;
            case Server.CHANGE_PICTURE:
                if (data.result == "success") {
                    _player.parse(data.player.params);
                    _game.changePic(data.player.params.changed_pic);

                    Sound.play(Sound.CHANGE_PIC);
                }
                break;
            case Server.GET_FRIEND_BAR:
                if (data.result == "success") {
                    Friend.parse(data.friends);
                    dispatchEventWith(FRIENDS);
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
        _game.init();
        _tempData = null;
    }

    private function handleUseBonus(event: Event):void {
        var bonus: Bonus = event.data as Bonus;
        if (bonus.price > _player.money) {
            _view.showBank();
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
        }
        _currentBonus = null;
    }

    // ***********************
    // ** section from view **
    // ***********************
    private function handleSelectLanguage(event: Event):void {
        // TODO: сделать LocaleManager
        _player.setLanguage((event.data as Language).title);

        crateGame();
    }

    private function handleOpenBank(event: Event):void {
        _view.showBank();
    }

    private function handleBuyBank(event: Event):void {
        if (InAppPurchase.isSupported && InAppPurchase.canMakePayments) {
            var bank: Bank = event.data as Bank;
            InAppPurchase.purchaseProduct(String(bank.id));
            // TODO: wait for signal, then finishTransaction(id);
        }
    }

    private function handleSelectPic(event: Event):void {
        _currentPic = event.data as Pic;
        if (_currentBonus && _currentBonus.id==Bonus.CHANGE_PICTURE) {
            applyBonus();
        } else {
            _game.zoom();
        }
    }

    private function handleInvite(event: Event):void {
        // TODO: invite friend
    }
}
}
