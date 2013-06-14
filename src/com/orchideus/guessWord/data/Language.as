/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 12:42
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import flash.utils.Dictionary;

public class Language {

    public static const LANGUAGE: String = "language_Language";

    public static var langs: Dictionary = new Dictionary();

    public static var languages: Vector.<Language> = new <Language>[
        createLang("ru", "Русский", "preloader_rus_ico"),
        createLang("de", "Deutsch", "preloader_deutch_ico"),
        createLang("en", "English", "preloader_eng_ico"),
        createLang("fr", "Français", "preloader_franc_ico"),
        createLang("es", "Español", "preloader_esp_ico"),
        createLang("it", "Italiano", "preloader_ital_ico"),
        createLang("po", "Português", "preloader_port_ico")
    ];

    private static function createLang(id: String, title: String, icon: String):Language {
        var lang: Language = new Language();
        lang.id = id;
        lang.title = title;
        lang.icon = icon;

        langs[id] = lang;

        return lang;
    }

    public var id: String;
    public var title: String;
    public var icon: String;

    public function get path():String {
        return "locale/"+id+".csv";
    }
}
}
