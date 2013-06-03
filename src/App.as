/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 20.05.13
 * Time: 22:48
 * To change this template use File | Settings | File Templates.
 */
package {
import com.laiyonghao.Uuid;
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.Bonus;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.data.Variables;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.server.Server;
import com.orchideus.guessWord.ui.Screen;

import flash.filesystem.File;
import flash.media.AudioPlaybackMode;
import flash.media.SoundMixer;

import flash.net.SharedObject;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class App extends Sprite {

    public static const PROGRESS: String = "progress_App";
    public static const INIT: String = "init_App";

    private var _assets:AssetManager;
    private var _assetsPath: String;
    private var _onLoad: Function;

    private var _screen: Screen;

    private var _data: SharedObject;

    private var _loaded: Boolean;

    private var _server: Server;

    private var _game: Game;
    public function get game():Game {
        return _game;
    }

    private var _tempData: Object;

    public function start(assets: AssetManager, assetsPath: String):void {
        _assets = assets;
        _onLoad = initPreloader;
        _assets.loadQueue(handleProgress);

        _assetsPath = assetsPath;

        _data = SharedObject.getLocal("data");
        if (!_data.data.created) {
            _data.data.uid = (new Uuid()).toString();
            _data.data.sound = true;
            _data.data.created = 1;
        }
    }

    private function handleProgress(ratio: Number):void {
        dispatchEventWith(PROGRESS, false, ratio);
        if (ratio == 1) {
            Starling.juggler.delayCall(_onLoad, 0.15);
        }
    }

    private function initPreloader():void {
        Fonts.init();
        Sound.init(_assets);
        SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;

        _screen = new Screen(this, _assets);
        addChild(_screen);

        _screen.showPreloader(_data.data.language ? null : handleSelectLanguage);

        var dir: File = File.applicationDirectory;
        _assets.enqueue(
            dir.resolvePath("sounds"),
            dir.resolvePath("fonts"),
            dir.resolvePath(_assetsPath)
        );
        _onLoad = initStart;
        _assets.loadQueue(handleProgress);
    }

    private function handleSelectLanguage(lang: String):void {
        _data.data.language = lang;
        if (_loaded) {
            initStart();
        }
    }

    private function initStart():void {
        _loaded = true;
        if (!_data.data.language) {
            return;
        }

        _game = new Game();
        _game.addEventListener(Game.SEND_WORD, handleSendWord);
        _game.addEventListener(Game.USE_BONUS, handleUseBonus);

        _server = new Server();
        _server.init("1", _data.data.uid);

        _server.addEventListener(Server.DATA, handleData);
        _server.getParameters();
    }

    private function handleSendWord(event: Event):void {
        _server.checkWord(_game.word.word_id, _game.word.word);
    }

    private function handleUseBonus(event: Event):void {
        switch (event.data) {
            case Bonus.OPEN_LETTER:
                _server.openLetter();
                break;
            case Bonus.REMOVE_LETTERS:
                _server.removeLetters();
                break;
            case Bonus.CHANGE_PICTURE:
//                _server.changePicture();
                break;
            case Bonus.REMOVE_WRONG_PICTURE:
                _server.removeWrongPicture();
                break;
        }
    }

    public function nextRound():void {
        _game.word.clear(true);
        _game.initWord(_tempData.new_word);
        _tempData = null;
    }

    private function handleData(event: Event):void {
        var data: Object = event.data;
        switch (data.method) {
            case Server.GET_PARAMETERS:
                if (data.result == "success") {
                    Bonus.parse(data.variables);
                    Bank.parse(data.bank);
                    Variables.parse(data.variables);

                    _screen.showGame();
                    dispatchEventWith(INIT);

                    _game.updateStack(data.player.params);
                    _game.updatePlayer(data.player.params);
                    _game.initWord(data.word);
                }
                break;
            case Server.CHECK_WORD:
                if (data.result == "success") {
                    _tempData = data;
                    _game.updateStack(data.player.params);
                    _game.updatePlayer(data.player.params);
                    _game.updateDescription(data.word);
                    _game.win();
                } else {
                    _game.wordError();
                }
                break;
            case Server.OPEN_LETTER:
                _game.word.clear(false);
                _game.updatePlayer(data.player.params);
                _game.updateWord(data.word);
                break;
            case Server.REMOVE_LETTERS:
                _game.word.clear(false);
                _game.updateStack(data.player.params);
                _game.updatePlayer(data.player.params);
                break;
            case Server.CHANGE_PICTURE:
                _game.updatePlayer(data.player.params);
                break;
            case Server.REMOVE_WRONG_PICTURE:
                _game.updatePlayer(data.player.params);
                break;
        }
    }
}
}
