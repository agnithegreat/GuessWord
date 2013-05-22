/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 13:22
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {

public class Player {

    public static var level: int;
    public static var money: int;

    public static function parse(data: Object) {
        level = data.level;
        money = data.money;
    }
}
}
