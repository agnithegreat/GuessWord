/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 20.05.13
 * Time: 22:48
 * To change this template use File | Settings | File Templates.
 */
package {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.data.Sound;
import com.orchideus.guessWord.localization.LocalizationManager;

import flash.display.Bitmap;

import starling.core.Starling;
import starling.display.Sprite;
import starling.utils.AssetManager;

public class App extends Sprite {

    private var _assets:AssetManager;
    private var _onLoad: Function;

    private var _background: Bitmap;

    private var _locale: LocalizationManager;

    private var _controller: GameController;

    public function start(assets: AssetManager,  background: Bitmap):void {
        _assets = assets;

        _background = background;

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

        _locale = new LocalizationManager();
        _controller = new GameController(this, _assets, _locale);

        var lang: String = _controller.player.lang ? _controller.player.lang : "en";
        _locale.loadLocale(Language.langs[lang].path, handleLoadLocale);
    }

    private function handleLoadLocale():void {
        if (_background) {
            _background.parent.removeChild(_background);
            _background = null;
        }

        _controller.initPreloader();

        _assets.enqueue("textures/2x/main.png", "textures/2x/main.xml");
        for (var i:int = 0; i < Sound.sounds.length; i++) {
            _assets.enqueue("sounds/"+Sound.sounds[i]+".mp3");
        }
        _onLoad = initGame;
        _assets.loadQueue(handleProgress);
    }

    public function initGame():void {
        _onLoad = null;

        _controller.init();
    }
}
}
