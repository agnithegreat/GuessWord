/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 12:42
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {

public class Language {

    public static const LANGUAGE: String = "language_Language";

    public static var languages: Array = [
        createLang("Русский", "preloader_rus_ico"),
        createLang("Deutsch", "preloader_deutch_ico"),
        createLang("English", "preloader_eng_ico"),
        createLang("Français", "preloader_franc_ico"),
        createLang("Español", "preloader_esp_ico"),
        createLang("Italiano", "preloader_ital_ico"),
        createLang("Português", "preloader_port_ico"),
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
