/**
 * Created with IntelliJ IDEA.
 * User: virich
 * Date: 05.06.13
 * Time: 14:49
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.data {
import flash.geom.Rectangle;

public class DeviceType {

    public static const iPhone4: DeviceType = new DeviceType(320,480);
    public static const iPhone5: DeviceType = new DeviceType(320,568);
    public static const iPad: DeviceType = new DeviceType(768,1024);

    public var size: Rectangle;

    public function DeviceType(w: int, h: int) {
        this.size = new Rectangle(0, 0, w, h);
    }
}
}
