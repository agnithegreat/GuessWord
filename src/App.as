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
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.ui.preloader.Preloader;

import flash.filesystem.File;
import flash.net.SharedObject;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.AssetManager;

public class App extends Sprite {

    private var _assets:AssetManager;
    private var _assetsPath: String;
    private var _onLoad: Function;

    private var _deviceType: DeviceType;

    private var _preloader: Preloader;

    private var _language: SharedObject;
    public function get lang():String {
        return _language.data.language;
    }
    public function set lang(value: String):void {
        _language.data.language = value;
    }

    private var _loaded: Boolean;

    private var _controller: GameController;

    public function start(assets: AssetManager, assetsPath: String, deviceType: DeviceType):void {
        _assets = assets;
        _onLoad = initPreloader;
        _assets.loadQueue(handleProgress);

        _assetsPath = assetsPath;

        _deviceType = deviceType;
    }

    private function handleProgress(ratio: Number):void {
        if (_preloader) {
            _preloader.setProgress(ratio);
        }

        if (ratio == 1) {
            Starling.juggler.delayCall(_onLoad, 0.15);
        }
    }

    private function initPreloader():void {
        Sound.init(_assets);
        Sound.listen(this);

        Fonts.init();

        _language = SharedObject.getLocal("data");

        _preloader = new Preloader(_assets, _deviceType);
        _preloader.addEventListener(Preloader.SELECT_LANGUAGE, handleSelectLanguage);
        addChild(_preloader);
        _preloader.init(lang);

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
        if (lang) {
            _controller = new GameController(this, _assets, _deviceType);
            hidePreloader();
        } else {
            _loaded = true;
        }
    }

    private function hidePreloader():void {
        _preloader.destroy();
        removeChild(_preloader, true);
        _preloader = null;
    }

    private function handleSelectLanguage(event: Event):void {
        // TODO: сделать LocaleManager
        lang = (event.data as Language).title;
        if (_loaded) {
            initGame();
        }
    }
}
}
