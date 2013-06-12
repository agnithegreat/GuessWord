/**
 * Created with IntelliJ IDEA.
 * User: agnithegreat
 * Date: 12.06.13
 * Time: 12:59
 * To change this template use File | Settings | File Templates.
 */
package com.orchideus.guessWord.server {
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.RemoteNotificationEvent;
import flash.events.StatusEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestDefaults;
import flash.net.URLRequestMethod;
import flash.notifications.NotificationStyle;
import flash.notifications.RemoteNotifier;
import flash.notifications.RemoteNotifierSubscribeOptions;

public class PushNotifications {

    private var _remoteNotifier: RemoteNotifier;

    public function init():void {
        if ( RemoteNotifier.supportedNotificationStyles.length > 0) {
            var preferredNotificationStyles:Vector.<String> = new Vector.<String>;

            preferredNotificationStyles.push(NotificationStyle.ALERT);
            preferredNotificationStyles.push(NotificationStyle.SOUND);
            preferredNotificationStyles.push(NotificationStyle.BADGE);

            var subscribeOptions:RemoteNotifierSubscribeOptions = new RemoteNotifierSubscribeOptions();
            subscribeOptions.notificationStyles = preferredNotificationStyles;

            _remoteNotifier = new RemoteNotifier();

            _remoteNotifier.addEventListener(RemoteNotificationEvent.TOKEN, sendDeviceTokenToServer);
            _remoteNotifier.addEventListener(RemoteNotificationEvent.NOTIFICATION, notificationReceivedByApp);
            _remoteNotifier.addEventListener(StatusEvent.STATUS, subscriptionFailureCallback);

            // calling subscribe method without any subscribe options automatically subscribes // for all notification styles supported on that platform
            _remoteNotifier.subscribe(subscribeOptions);
        }
    }

    protected function subscriptionFailureCallback(event:StatusEvent):void {
        trace("Received Status event for registrationFailure with code:" + event.code + " and level:" + event.level + "\n");
    }

    protected function notificationReceivedByApp(event:RemoteNotificationEvent):void {
        trace("Received RemoteNotificationEvent.RECEIVED\n");
        for (var i:String in event.data) {
            trace("Key:value pair " + i + ":" + event.data[i] + "\n");
        }
    }

    protected function sendDeviceTokenToServer(event:RemoteNotificationEvent):void {
        trace("Received " + event.type + " with tokenString:" + event.tokenId + "\n");
        var urlRequest:URLRequest;
        var urlLoader:URLLoader = new URLLoader();
        var urlString:String = "https://go.urbanairship.com/api/device_tokens/" + event.tokenId;
        urlRequest = new URLRequest(urlString);
        urlRequest.authenticate = true;
        urlRequest.method = URLRequestMethod.PUT;
        URLRequestDefaults.setLoginCredentialsForHost("go.urbanairship.com","<Your App Key Here>","<Your App Secret Here>") ;
        urlLoader.load(urlRequest);
//        urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
//        urlLoader.addEventListener(Event.COMPLETE, onComplete);
//        urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
    }
}
}
