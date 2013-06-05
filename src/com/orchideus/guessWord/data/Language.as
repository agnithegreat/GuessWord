/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 12:42
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
public class Language {

    public static var languages: Array = [
        createLang("Русский", "rus_ico"),
        createLang("Deutsch", "deutch_ico"),
        createLang("English", "eng_ico"),
        createLang("Français", "franc_ico"),
        createLang("Español", "esp_ico"),
        createLang("Italiano", "ital_ico"),
        createLang("Português", "port_ico"),
    ];

    private static function createLang(title: String, icon: String):Language {
        var lang: Language = new Language();
        lang.title = title;
        lang.icon = icon;
        return lang;
    }

    public var title: String;
    public var icon: String;
}
}
