/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 11.06.13
 * Time: 23:17
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.game {
import starling.events.EventDispatcher;

public class Score extends EventDispatcher {

    public static const UPDATE: String = "update_Score";

    private var _time: int;
    public function get time():int {
        return _time;
    }

    private var _totalTime: int;
    public function get progress():Number {
        return _time/_totalTime;
    }

    private var _totalBonus: int;
    private var _bonusDecrease: int;

    public function get bonus():int {
        var bonus: int =  Math.ceil(_time/_totalTime * _totalBonus/_bonusDecrease)*_bonusDecrease;
        return bonus>_bonusDecrease ? bonus : _bonusDecrease;
    }

    public function init(time: int, bonus: int, bonusDecrease: int):void {
        _time = time;
        _totalTime = time;
        _totalBonus = bonus;
        _bonusDecrease = bonusDecrease;
    }

    public function set time(value: int):void {
        _time = _totalTime-value;
        _time = Math.max(_time, 0);
        dispatchEventWith(UPDATE);
    }
}
}
