/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:55
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.extensions.Gauge;
import starling.utils.AssetManager;

public class Preloader extends Sprite {

    private var _background: Image;
    private var _progress: Gauge;

    public function Preloader(assets: AssetManager) {
        _background = new Image(assets.getTexture("preloader"));
        addChild(_background);

        _background.x = (768-_background.width)/2;
        _background.y = (1024-_background.height)/2;

//        _progress = new Gauge(assets.getTexture("progress"));
//        _progress.ratioH = 0;
//        addChild(_progress);
//
//        Starling.juggler.tween(_progress, 1, {ratioH: 1});
    }
}
}
