/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:16
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {

public class Bonus {

    public static const OPEN_LETTER: String = "open_letter";
    public static const REMOVE_LETTERS: String = "remove_letters";
    public static const CHANGE_PICTURE: String = "change_picture";
    public static const REMOVE_WRONG_PICTURE: String = "remove_wrong_picture";

    public static var BONUSES: Object = {};

    public static function parse(data: Object):void {
        BONUSES[OPEN_LETTER] = new Bonus(OPEN_LETTER, "open_letter_ico", "A_ico", ["ОТКРЫТЬ","БУКВУ"], data.opensymbol_price);
        BONUSES[REMOVE_LETTERS] = new Bonus(REMOVE_LETTERS, "remove_letters_ico", "A_ico", ["УБРАТЬ","БУКВЫ"], data.removesymbols_price);
        BONUSES[CHANGE_PICTURE] = new Bonus(CHANGE_PICTURE, "change_pic_ico", "pic_ico", ["ЕЩЕ","КАРТИНКА"], data.changepic_price);
        BONUSES[REMOVE_WRONG_PICTURE] = new Bonus(REMOVE_WRONG_PICTURE, "change_pic_ico", "A_ico", ["УБРАТЬ","ЛИШНЮЮ"], data.changewrongpic_price);
    }

    public var id: String;
    public var icon1: String;
    public var icon2: String;
    public var text: Array;
    public var price: int;

    public function Bonus(id: String, icon1: String, icon2: String, text: Array, price: int) {
        this.id = id;
        this.icon1 = icon1;
        this.icon2 = icon2;
        this.text = text;
        this.price = price;
    }
}
}
