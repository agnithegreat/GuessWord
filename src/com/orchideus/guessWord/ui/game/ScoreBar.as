/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 07.06.13
 * Time: 9:35
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.ui.game {
import com.orchideus.guessWord.GameController;
import com.orchideus.guessWord.data.CommonRefs;
import com.orchideus.guessWord.game.Score;
import com.orchideus.guessWord.ui.abstract.AbstractView;

import flash.filters.GlowFilter;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;

public class ScoreBar extends AbstractView {

    public static var TILE: int;

    private var _controller: GameController;

    private var _front: Image;

    private var _coinsContainer: Sprite;

    private var _score1: TextField;
    private var _score2: TextField;
    private var _score3: TextField;
    private var _score4: TextField;
    private var _score5: TextField;
    private var _score6: TextField;
    private var _scoreFilters: Array;

    private var _timeBar: Image;
    private var _timeTF: TextField;
    private var _timeFilters: Array;

    private var _bonusTF: TextField;
    private var _bonusFilters: Array;
    private var _bonusValueTF: TextField;
    private var _bonusValueFilters: Array;

    public function ScoreBar(refs: CommonRefs, controller: GameController) {
        _controller = controller;
        _controller.score.addEventListener(Score.UPDATE, handleUpdate);

        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _coinsContainer = new Sprite();
        _coinsContainer.touchable = false;
        addChild(_coinsContainer);

        _front = new Image(_refs.assets.getTexture("main_GRADUSNIK"));
        _front.touchable = false;
        addChild(_front);

        _timeBar = new Image(_refs.assets.getTexture("main_time_under"));
        _timeBar.touchable = false;
        addChild(_timeBar);

        super.initialize();

        _timeTF.touchable = false;
        addChild(_timeTF);

        _bonusTF.touchable = false;
        addChild(_bonusTF);

        _bonusValueTF.touchable = false;
        addChild(_bonusValueTF);

        createCoins();
    }

    override protected function initializeIPhone():void {
        _timeBar.x = -8;
        _timeBar.y = 264;

        _scoreFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];

        for (var i:int = 1; i <= 6; i++) {
            var tf: TextField = createTextField(32, 32, 14, String(i*2)+"-");
            tf.hAlign = HAlign.RIGHT;
            tf.touchable = false;
            tf.x = -24;
            tf.y = 280 - i * 38;
            this["_score"+i] = tf;
            addChild(tf);
        }

        _timeTF = createTextField(_timeBar.width, _timeBar.height, 20, "00:00");
        _timeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _timeTF.x = -8;
        _timeTF.y = 264;

        _bonusTF = createTextField(_timeBar.width, _timeBar.height, 16, _refs.locale.getString("main.score.bonus"));
        _bonusFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _bonusTF.x = -8;
        _bonusTF.y = 302;

        _bonusValueTF = createTextField(_timeBar.width, _timeBar.height, 20, "", 0xFFCC00);
        _bonusValueFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _bonusValueTF.x = -8;
        _bonusValueTF.y = 320;

        _coinsContainer.x = 12;
        _coinsContainer.y = 254;

        TILE = 6;
    }

    override protected function applyFilters():void {
        for (var i: int = 1; i <= 6; i++) {
            var tf: TextField = this["_score"+i];
            tf.nativeFilters = _scoreFilters;
        }
        _timeTF.nativeFilters = _timeFilters;
        _bonusTF.nativeFilters = _bonusFilters;
        _bonusValueTF.nativeFilters = _bonusValueFilters;
    }

    private function createCoins():void {
        for (var i:int = 0; i < 36; i++) {
            var coin: Image = new Image(_refs.assets.getTexture("main_bonus_coin"));
            coin.touchable = false;
            coin.y = -i*TILE;
            _coinsContainer.addChild(coin);
        }
    }

    private function handleUpdate(event: Event):void {
        _bonusValueTF.text = String(_controller.score.bonus);
        _timeTF.text = timeToString(_controller.score.time);

        var amount: int = _coinsContainer.numChildren;
        for (var i:int = 0; i < amount; i++) {
            var coin: Image = _coinsContainer.getChildAt(i) as Image;
            coin.visible = i < _controller.score.progress * amount;
        }

        for (i = 1; i <= 6; i++) {
            var tf: TextField = this["_score"+i];
            tf.color = _controller.score.bonus > i*2 ? 0xFFFFFF : 0xFFCC00;
            tf.alpha = _controller.score.bonus < i*2 ? 0.5 : 1;
        }
    }

    private static function timeToString(time: int):String {
        var m: int = time/60;
        var s: int = time%60;
        var mm: String = m<10 ? "0"+m : String(m);
        var ss: String = s<10 ? "0"+s : String(s);
        return mm+":"+ss;
    }
}
}
