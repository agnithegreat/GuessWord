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
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Friend;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.data.Pic;
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.data.Variables;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.game.Score;
import com.orchideus.guessWord.localization.LocalizationManager;
import com.orchideus.guessWord.server.Server;
import com.orchideus.guessWord.server.Service;
import com.orchideus.guessWord.social.Social;
import com.orchideus.guessWord.ui.MainScreen;

import flash.events.TimerEvent;
import flash.utils.Timer;

import starling.core.Starling;

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

    private var _score: Score;
    public function get score():Score {
        return _score;
    }

    private var _currentBonus: Bonus;
    private var _currentPic: Pic;

    private var _view: MainScreen;

    private var _server: Server;

    private var _locale: LocalizationManager;

    private var _social: Social;
    public function get social():Social {
        return _social;
    }

    private var _date: Date;
    private var _serverTime: uint;
    public function get current_server_time():uint {
        var now: Date = new Date();
        return _serverTime + (now.time-_date.time)/1000;
    }

    private var _bonusTime: uint;

    private var _timer: Timer;

    private var _tempData: Object;
    public function get levelFinished():Boolean {
        return _tempData;
    }

    public function GameController(container: Sprite, assets: AssetManager, deviceType: DeviceType, locale: LocalizationManager) {
        _player = new Player();

        _social = new Social();
        _social.addEventListener(Social.LOGGED_IN, handleLoggedIn);
        _social.addEventListener(Social.GET_FRIENDS, handleGetFriends);

        _timer = new Timer(1000);
        _timer.addEventListener(TimerEvent.TIMER, handleTimer);

        _locale = locale;

        _view = new MainScreen(new CommonRefs(assets, deviceType, _locale), this);
        container.addChild(_view);

        addViewEventListeners();
    }

    public function initPreloader():void {
        _view.showPreloader();
    }

    public function preloaderProgress(value: Number):void {
        dispatchEventWith(PROGRESS, false, value);
    }

    public function init():void {
        _social.init();

        if (_player.lang) {
            crateGame();
        } else {
            dispatchEventWith(SHOW_LANGUAGES);
        }
    }

    private function crateGame():void {
        _game = new Game();
        _game.addEventListener(Game.SEND_WORD, handleSendWord);

        _score = new Score();

        _server = new Server();
        _server.init("1", _player.uid);
        _server.addEventListener(Server.DATA, handleData);
        _server.addEventListener(Server.INTERNET_UNAVAILABLE, handleInternetUnavailable);

        _server.getParameters();

        _view.showGame();
    }

    private function startLevel():void {
        _game.init();
        _score.init(Variables.bonus_time, Variables.bonus_max, Variables.bonus_dec);
    }

    private function addViewEventListeners():void {
        _view.addEventListener(Language.LANGUAGE, handleSelectLanguage);
        _view.addEventListener(Pic.SELECT, handleSelectPic);
        _view.addEventListener(Bonus.USE, handleUseBonus);
        _view.addEventListener(Bank.OPEN, handleOpenBank);
        _view.addEventListener(Bank.BUY, handleBuyBank);

        _view.addEventListener(Social.INVITE, handleInvite);
        _view.addEventListener(Social.ASK, handleAsk);
    }

    private function handleTimer(event: TimerEvent):void {
        if (!levelFinished) {
            _score.time = current_server_time-_bonusTime;
        }
    }

    // *************************
    // ** section from social **
    // *************************
    private function handleLoggedIn(event: Event):void {
        _social.getFriends();
    }

    private function handleGetFriends(event: Event):void {
        Friend.parseFriends(event.data);
        _server.getFriendBar(Friend.uids);
    }

    // *************************
    // ** section from server **
    // *************************
    private function handleData(event: Event):void {
        var data: Object = event.data;
        switch (data.method) {
            case Server.GET_PARAMETERS:
                if (data.result == "success") {
                    _serverTime = data.server_time;
                    _date = new Date();
                    _timer.start();

                    _player.parse(data.player.params);
                    Bonus.init(data.variables, _locale);
                    Bank.parse(data.bank);
                    Variables.parse(data.variables);

                    _bonusTime = data.player.params.current_word_start;

                    _game.updateStack(data.player.params);
                    _game.initWord(data.word);
                    _game.changePic(data.player.params.changed_pic);
                    startLevel();
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
            case Server.START_TIMER:
                _bonusTime = data.new_word.current_word_start;
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
                    Friend.parseAppFriends(data.friends);
                    dispatchEventWith(FRIENDS);
                }
                break;
        }
    }

    private function handleInternetUnavailable(event: Event):void {
        if (Starling.current.isStarted) {
            Service.showAlert(_locale.getString("alert.connection.title"), _locale.getString("alert.connection.msg"));
        }
    }

    // ************************
    // ** section from model **
    // ************************
    private function handleSendWord(event: Event):void {
        if (!levelFinished) {
            _server.checkWord(_game.word.word_id, _game.word.word);
        }
    }

    public function nextRound():void {
        if (levelFinished) {
            _game.word.clear(true);
            _game.initWord(_tempData.new_word);
            startLevel();
            _server.startTimer();
            _tempData = null;
        }
    }

    private function handleUseBonus(event: Event):void {
        if (levelFinished) {
            return;
        }

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
        _player.setLanguage((event.data as Language).id);

        if (_player.lang=="en") {
            crateGame();
        } else {
            _locale.loadLocale(Language.langs[_player.lang].path, crateGame);
        }
    }

    private function handleOpenBank(event: Event):void {
        _view.showBank();
    }

    private function handleBuyBank(event: Event):void {
        Service.makePurchase(event.data as Bank);
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
        _social.invite();
    }

    private function handleAsk(event: Event):void {
        _social.post();
    }
}
}
