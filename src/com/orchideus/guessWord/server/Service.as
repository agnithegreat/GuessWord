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
import com.tapjoy.extensions.TapjoyAIR;
import com.tapjoy.extensions.TapjoyViewChangedEvent;

public class Service {

    private static var _inAppPurchase: InAppPurchase;

    private static var _tapjoy: TapjoyAIR;

    private static var _moneyUpdate: Function;

    public static function init(moneyUpdate: Function):void {
        _moneyUpdate = moneyUpdate;

        _inAppPurchase = InAppPurchase.getInstance();
        _inAppPurchase.init();

        initAds();
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

    private static function initAds():void {
        initTapjoy();
    }

    private static function initTapjoy():void {
        TapjoyAIR.requestTapjoyConnect("951fca37-f876-4382-bc27-827859c41c07", "eDAROwXqiPJlMAaS9G9w");

        _tapjoy = TapjoyAIR.getTapjoyConnectInstance();
        _tapjoy.addEventListener(TapjoyViewChangedEvent.TJ_VIEW_CLOSED, handleCloseTapjoy);
    }

    public static function showOffers():void {
        _tapjoy.showOffers();
    }

    private static function handleCloseTapjoy(event: TapjoyViewChangedEvent):void {
        _moneyUpdate();
    }
}
}
