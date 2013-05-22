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
import com.orchideus.guessWord.ui.Preloader;
import com.orchideus.guessWord.ui.Screen;

import flash.net.SharedObject;

import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class App extends Sprite {

    private var _assets:AssetManager;

    private var _user: SharedObject;

    private var _server: Server;

    private var _game: Game;

    private var _screen: Screen;

    public function App() {
    }

    public function start(assets: AssetManager):void {
        _assets = assets;
        _assets.loadQueue(handleProgress);
    }

    private function handleProgress(ratio: Number):void {
        if (ratio == 1) {
            Starling.juggler.delayCall(initStart, 0.15);
        }
    }

    private function initStart():void {
        _game = new Game();

        _screen = new Screen(_game, _assets);
        addChild(_screen);

//        addChild(new Preloader(_assets));

        _server = new Server();

        _user = SharedObject.getLocal("user");
        if (!_user.data) {
            _user.data.uuid = (new Uuid()).toString();
        }

//        _server.init("1", _user.data.uuid);
        _server.init("1", "3602860");

        _server.addEventListener(Server.DATA, handleData);
        _server.getParameters();
    }

    private function handleData(event: Event):void {
        var data: Object = event.data;
        switch (data.method) {
            case Server.GET_PARAMETERS:
                Player.parse(data.player.params);
                Bank.parse(data.bank);
                Variables.parse(data.variables);
                _game.initWord(data.word);
                break;
//            case Server.GET_PARAMETERS:
//                break;
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
