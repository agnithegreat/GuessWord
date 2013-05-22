/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 22.05.13
 * Time: 13:11
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {

public class Bank {

    public static var VALUES: Vector.<Bank>;

    public var id: int;
    public var value: int;
    public var price: int;
    public var best_value: Boolean;
    public var network: int;

    public static function parse(data: Object):void {
        VALUES = new <Bank>[];

        for (var i:int = 0; i < data.length; i++) {
            var bank: Bank = new Bank();
            bank.id = data[i].id;
            bank.value = data[i].value;
            bank.price = data[i].price;
            bank.best_value = data[i].best_value == 1;
            bank.network = data[i].network;
            VALUES.push(bank);
        }
    }

}
}