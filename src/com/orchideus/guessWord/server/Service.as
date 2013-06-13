/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 13.06.13
 * Time: 11:18
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.server {
import com.freshplanet.ane.AirAlert.AirAlert;
import com.freshplanet.nativeExtensions.InAppPurchase;
import com.orchideus.guessWord.data.Bank;

public class Service {

    private static var _inAppPurchase: InAppPurchase;

    public static function init():void {
        _inAppPurchase = InAppPurchase.getInstance();
        _inAppPurchase.init();
    }

    public static function makePurchase(bank: Bank):void {
        if (_inAppPurchase.isInAppPurchaseSupported && _inAppPurchase.userCanMakeAPurchase()) {
            _inAppPurchase.makePurchase(String(bank.id));
        }
    }

    public static function showAlert(title: String, msg: String, callback: Function = null):void {
        if (AirAlert.isSupported) {
            AirAlert.getInstance().showAlert(title, msg, "Close", callback);
        }
    }
}
}
