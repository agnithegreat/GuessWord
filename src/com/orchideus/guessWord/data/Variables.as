/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 13:16
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {

public class Variables {

    public static var newtwork: String;
    public static var version: int;
    public static var appid: int;

    public static var task_bonus: int;

    public static var opensymbol_price: int;
    public static var removesymbols_price: int;
    public static var changepic_price: int;
    public static var changewrongpic_price: int;

    public static var bonus_time: int;
    public static var bonus_max: int;
    public static var bonus_interval: int;
    public static var bonus_dec: int;

    public static function parse(data: Object):void {
        newtwork = data.newtwork;
        version = data.version;
        appid = data.appid;

        task_bonus = data.task_bonus;

        opensymbol_price = data.opensymbol_price;
        removesymbols_price = data.removesymbols_price;
        changepic_price = data.changepic_price;
        changewrongpic_price = data.changewrongpic_price;

        bonus_time = data.bonus_time;
        bonus_max = data.bonus_max;
        bonus_interval = data.bonus_interval;
        bonus_dec = data.bonus_dec;
    }
}
}
