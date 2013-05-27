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

    private var _server: Server;

    private var _game: Game;
    public function get game():Game {
        return _game;
    }

    public function start(assets: AssetManager, assetsPath: String):void {
        _assets = assets;
        _onLoad = initPreloader;
        _assets.loadQueue(handleProgress);

        _assetsPath = assetsPath;

        _data = SharedObject.getLocal("data");
        if (!_data.data.created) {
            _data.data.uid = (new Uuid()).toString();
            _data.data.sound = true;
            _data.data.created = true;
        }
        _data.data.uid = "3602860";
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

        _screen.showPreloader();

        var dir: File = File.applicationDirectory;
        _assets.enqueue(
            dir.resolvePath("sounds"),
            dir.resolvePath("fonts"),
            dir.resolvePath(_assetsPath)
        );
        _onLoad = initStart;
        _assets.loadQueue(handleProgress);
    }

    private function initStart():void {
        _game = new Game();
        _game.addEventListener(Game.SEND_WORD, handleSendWord);

        _screen.showGame();

        dispatchEventWith(INIT);

        _server = new Server();
        _server.init("1", _data.data.uid);

        _server.addEventListener(Server.DATA, handleData);
        _server.getParameters();
    }

    private function handleSendWord(event: Event):void {
        _server.checkWord(_game.word.word_id, _game.word.word);
    }

    private function handleData(event: Event):void {
        var data: Object = event.data;
        switch (data.method) {
            case Server.GET_PARAMETERS:
                if (data.result == "success") {
                    Bank.parse(data.bank);
                    Variables.parse(data.variables);
                    _game.init(data.player.params);
                    _game.initWord(data.word);
                }
                break;
            case Server.CHECK_WORD:
                if (data.result == "success") {
                    _game.win();

                    // TODO: сделать обработчик, начислить бабло
                    _game.word.clear();
                    _game.init(data.player.params);
                    _game.initWord(data.new_word);
                } else {
                    _game.wordError();
                }
                break;
//            case Server.GET_PARAMETERS:
//                break;
//            case Server.GET_PARAMETERS:
//                break;
//            case Server.GET_PARAMETERS:
//                break;
//            case Server.GET_PARAMETERS:
//                break;
        }
    }
}
}
