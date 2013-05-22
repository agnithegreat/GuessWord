/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 20.05.13
 * Time: 22:48
 * To change this template use File | Settings | File Templates.
 */
package {
import com.orchideus.guessWord.data.Bank;
import com.orchideus.guessWord.data.Player;
import com.orchideus.guessWord.data.Variables;
import com.orchideus.guessWord.game.Game;
import com.orchideus.guessWord.server.Server;
import com.orchideus.guessWord.ui.Screen;

import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class App extends Sprite {

    private var _server: Server;

    private var _game: Game;

    private var _screen: Screen;

    public function App() {
    }

    public function start(assets: AssetManager):void {
        _game = new Game();

        _screen = new Screen();
        addChild(_screen);

        _server = new Server();

        // TODO: сделать параметры динамическими
        _server.init("1", "vk", "3602860");

        _server.addEventListener(Server.DATA, handleData);
        _server.getParameters();
    }

    private function handleData(event: Event):void {
        var data: Object = event.data;
        switch (data.method) {
            case Server.GET_PARAMETERS:
                Player.parse(data.player.params);
                _game.init(data.player.params);
                Bank.parse(data.bank);
                Variables.parse(data.variables);
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
