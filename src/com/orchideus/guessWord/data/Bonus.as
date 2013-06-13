/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 16:16
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import com.orchideus.guessWord.localization.LocalizationManager;

public class Bonus {

    public static const USE: String = "use_Bonus";

    public static const OPEN_LETTER: String = "open_letter";
    public static const REMOVE_LETTERS: String = "remove_letters";
    public static const CHANGE_PICTURE: String = "change_picture";

    public static var BONUSES: Object = {};

    public static function init(data: Object, locale: LocalizationManager):void {
        BONUSES[OPEN_LETTER] = new Bonus(OPEN_LETTER, "main_openletter_ico", locale.getString("main.bonus.openletter").split("\n"), data.opensymbol_price);
        BONUSES[REMOVE_LETTERS] = new Bonus(REMOVE_LETTERS, "main_removeletters_ico", locale.getString("main.bonus.removeletters").split("\n"), data.removesymbols_price);
        BONUSES[CHANGE_PICTURE] = new Bonus(CHANGE_PICTURE, "main_onemorepic_ico", locale.getString("main.bonus.changepic").split("\n"), data.changepic_price);
    }

    public var id: String;
    public var icon: String;
    public var text: Array;
    public var price: int;

    public function Bonus(id: String, icon: String, text: Array, price: int) {
        this.id = id;
        this.icon = icon;
        this.text = text;
        this.price = price;
    }
}
}
