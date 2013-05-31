/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:16
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {

public class Bonus {

    public static var BONUSES: Array = [new Bonus("open_letter_ico", "A_ico", ["ОТКРЫТЬ","БУКВУ"], 49),
                                        new Bonus("remove_letters_ico", "A_ico", ["УБРАТЬ","БУКВЫ"], 39),
                                        new Bonus("change_pic_ico", "pic_ico", ["ЕЩЕ","КАРТИНКА"], 29),
                                        new Bonus("remove_letters_ico", "A_ico", ["УБРАТЬ","ЛИШНЮЮ"], 19)
                                       ];

    public var icon1: String;
    public var icon2: String;
    public var text: Array;
    public var price: int;

    public function Bonus(icon1: String, icon2: String, text: Array, price: int) {
        this.icon1 = icon1;
        this.icon2 = icon2;
        this.text = text;
        this.price = price;
    }
}
}
