/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 13:06
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.abstract {
import com.orchideus.guessWord.data.CommonRefs;

import starling.display.Image;

public class Screen extends AbstractView {

    protected var _background: Image;

    public function Screen(refs: CommonRefs, background: String = null) {
        super(refs);

        if (background) {
            _background = new Image(_refs.assets.getTexture(background));
            addChild(_background);
        }
    }

    override public function destroy():void {
        super.destroy();

        if (_background) {
            removeChild(_background, true);
            _background = null;
        }
    }
}
}
