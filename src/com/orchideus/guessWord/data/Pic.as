/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 30.05.13
 * Time: 15:33
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import starling.events.EventDispatcher;

public class Pic extends EventDispatcher {

    public static const SELECT: String = "select_Pic";

    public var id: int;
    public var url: String;
    public var description: String;
    public var wrong: Boolean;

    public function Pic(id: int) {
        this.id = id;
    }
}
}
