/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 03.06.13
 * Time: 15:07
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.preloader {
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.data.Language;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Button;
import starling.display.Image;
import starling.text.TextField;

public class LanguageTile extends AbstractView {

    private var _lang: Language;
    public function get lang():Language {
        return _lang;
    }

    private var _back: Button;
    private var _text: TextField;
    private var _textFilters: Array;
    private var _icon: Image;

    public function LanguageTile(refs: CommonRefs, lang: Language) {
        _lang = lang;

        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _back = new Button(_refs.assets.getTexture("preloader_btn_up"), "", _refs.assets.getTexture("preloader_btn_down"));
        addChild(_back);

        _icon = new Image(_refs.assets.getTexture(_lang.icon));
        _icon.touchable = false;
        addChild(_icon);

        super.initialize();

        _text.touchable = false;
        addChild(_text);
    }

    override protected function initializeIPhone():void {
        _text = createTextField(_back.width*0.8, _back.height, 20, _lang.title);
        _textFilters = [new GlowFilter(0, 1, 2, 2, 2, 3)];
        _text.x = 40;

        _icon.x = -10;
        _icon.y = -6;
    }

    override protected function applyFilters():void {
        _text.nativeFilters = _textFilters;
    }

    override public function destroy():void {
        super.destroy();

        _lang = null;

        removeChild(_back, true);
        _back = null;

        removeChild(_text, true);
        _text = null;

        removeChild(_icon, true);
        _icon = null;
    }
}
}
