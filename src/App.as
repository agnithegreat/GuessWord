/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 20.05.13
 * Time: 22:48
 * To change this template use File | Settings | File Templates.
 */
package {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.DeviceType;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.localization.LocalizationManager;
import com.orchideus.guessWord.server.Service;

import flash.filesystem.File;

import starling.core.Starling;
import starling.display.Sprite;
import starling.utils.AssetManager;

public class App extends Sprite {

    private var _assets:AssetManager;
    private var _assetsPath: String;
    private var _onLoad: Function;

    private var _deviceType: DeviceType;

    private var _locale: LocalizationManager;

    private var _controller: GameController;

    public function start(assets: AssetManager, assetsPath: String, deviceType: DeviceType):void {
        _assets = assets;

        _assetsPath = assetsPath;

        _deviceType = deviceType;

        _locale = new LocalizationManager();
        // TODO: localization select
        _locale.loadLocale("locale/ru.csv", handleLoadLocale);
    }

    private function handleLoadLocale():void {
        _onLoad = initPreloader;
        _assets.loadQueue(handleProgress);
    }

    private function handleProgress(ratio: Number):void {
        if (_controller) {
            _controller.preloaderProgress(ratio);
        }

        if (ratio == 1) {
            Starling.juggler.delayCall(_onLoad, 0.15);
        }
    }

    private function initPreloader():void {
        Sound.init(_assets);
        Sound.listen(stage);

        Fonts.init();

        Service.init();

        _controller = new GameController(this, _assets, _deviceType, _locale);

        var dir: File = File.applicationDirectory;
        _assets.enqueue(
            dir.resolvePath("sounds"),
            dir.resolvePath("fonts"),
            dir.resolvePath(_assetsPath)
        );
        _onLoad = initGame;
        _assets.loadQueue(handleProgress);
    }

    public function initGame():void {
        _onLoad = null;

        _controller.init();
    }
}
}
