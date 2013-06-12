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

    private var _timeBar: Image;
    private var _timeTF: TextField;

    private var _bonusTF: TextField;
    private var _bonusValueTF: TextField;

    public function ScoreBar(refs: CommonRefs, controller: GameController) {
        _controller = controller;
        _controller.score.addEventListener(Score.UPDATE, handleUpdate);

        super(refs);

        // TODO: подобрать фильтры
    }

    override protected function initialize():void {
        _coinsContainer = new Sprite();
        addChild(_coinsContainer);

        _front = new Image(_refs.assets.getTexture("main_GRADUSNIK"));
        addChild(_front);

        _timeBar = new Image(_refs.assets.getTexture("main_time_under"));
        addChild(_timeBar);

        super.initialize();

        addChild(_timeTF);

        addChild(_bonusTF);

        addChild(_bonusValueTF);

        createCoins();
    }

    override protected function initializeIPad():void {
        _timeBar.x = -9;
        _timeBar.y = 316;

        for (var i:int = 1; i <= 6; i++) {
            var tf: TextField = createTextField(30, 30, 16, String(i*2)+"-");
            tf.hAlign = HAlign.RIGHT;
            tf.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
            tf.x = -20;
            tf.y = 326 - i * 39;
            this["_score"+i] = tf;
            addChild(tf);
        }

        _timeTF = createTextField(_timeBar.width, _timeBar.height, 24, "00:00");
        _timeTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _timeTF.x = -9;
        _timeTF.y = 316;

        _bonusTF = createTextField(_timeBar.width, _timeBar.height, 20, _refs.locale.getString("main.score.bonus"));
        _bonusTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _bonusTF.x = -9;
        _bonusTF.y = 354;

        _bonusValueTF = createTextField(_timeBar.width, _timeBar.height, 24, "", 0xFFCC00);
        _bonusValueTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _bonusValueTF.x = -9;
        _bonusValueTF.y = 376;

        _coinsContainer.x = 10;
        _coinsContainer.y = 318;

        TILE = 7;
    }

    override protected function initializeIPhone():void {
        _timeBar.x = -4;
        _timeBar.y = 132;

        for (var i:int = 1; i <= 6; i++) {
            var tf: TextField = createTextField(16, 16, 7, String(i*2)+"-");
            tf.hAlign = HAlign.RIGHT;
            tf.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
            tf.x = -12;
            tf.y = 140 - i * 19;
            this["_score"+i] = tf;
            addChild(tf);
        }

        _timeTF = createTextField(_timeBar.width, _timeBar.height, 10, "00:00");
        _timeTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _timeTF.x = -4;
        _timeTF.y = 132;

        _bonusTF = createTextField(_timeBar.width, _timeBar.height, 8, _refs.locale.getString("main.score.bonus"));
        _bonusTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _bonusTF.x = -4;
        _bonusTF.y = 151;

        _bonusValueTF = createTextField(_timeBar.width, _timeBar.height, 10, "", 0xFFCC00);
        _bonusValueTF.nativeFilters = [new GlowFilter(0, 1, 3, 3, 3, 3)];
        _bonusValueTF.x = -4;
        _bonusValueTF.y = 160;

        _coinsContainer.x = 6;
        _coinsContainer.y = 127;

        TILE = 3;
    }

    private function createCoins():void {
        for (var i:int = 0; i < 36; i++) {
            var coin: Image = new Image(_refs.assets.getTexture("main_bonus_coin"));
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
