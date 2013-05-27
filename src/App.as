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
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.data.Variables;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.server.Server;
import com.orchideus.guessWord.ui.Screen;

import flash.filesystem.File;

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

    private var _user: SharedObject;

    private var _server: Server;

    private var _game: Game;
    public function get game():Game {
        return _game;
    }

    public function App() {
    }

    public function start(assets: AssetManager, assetsPath: String):void {
        _assets = assets;
        _onLoad = initPreloader;
        _assets.loadQueue(handleProgress);

        _assetsPath = assetsPath;
    }

    private function handleProgress(ratio: Number):void {
        dispatchEventWith(PROGRESS, false, ratio);
        if (ratio == 1) {
            Starling.juggler.delayCall(_onLoad, 0.15);
        }
    }

    private function initPreloader():void {
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

        _user = SharedObject.getLocal("user");
        if (!_user.data) {
            _user.data.uuid = (new Uuid()).toString();
        }

//        _server.init("1", _user.data.uuid);
        _server.init("1", "3602866");

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
