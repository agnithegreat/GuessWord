/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 11:55
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui {
import starling.display.Image;
import starling.display.Sprite;
import starling.utils.AssetManager;

public class Preloader extends Sprite {

    private var _background: Image;

    public function Preloader(assets: AssetManager) {
        _background = new Image(assets.getTexture("preloader"));
        addChild(_background);
    }
}
}
