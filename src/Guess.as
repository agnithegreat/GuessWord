package {
import com.orchideus.guessWord.data.DeviceType;

import flash.desktop.NativeApplication;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.filesystem.File;
import flash.geom.Rectangle;
import flash.system.Capabilities;

import starling.core.Starling;
import starling.events.Event;
import starling.utils.AssetManager;
import starling.utils.RectangleUtil;
import starling.utils.ScaleMode;
import starling.utils.formatString;

public class Guess extends Sprite {

    [Embed(source="../assets/textures/960.jpg")]
    private static var Background960:Class;

    [Embed(source="../assets/textures/1136.jpg")]
    private static var Background1136:Class;

    [Embed(source="../assets/textures/2048.jpg")]
    private static var Background2048:Class;

    private var _background: Bitmap;

    private var _assets: AssetManager;

    private var viewPort:Rectangle;

    private var basicAssetsPath:String;

    private var _deviceType: DeviceType;

    private var _starling: Starling;

    public function Guess() {
        if (stage) {
            handleAddedToStage();
        } else {
            addEventListener(flash.events.Event.ADDED_TO_STAGE, handleAddedToStage);
        }
    }

    private function handleAddedToStage(event:flash.events.Event = null):void {
        removeEventListener(flash.events.Event.ADDED_TO_STAGE, handleAddedToStage);
        init();
    }

    private function init():void {
        var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
        Starling.multitouchEnabled = true;
        Starling.handleLostContext = !iOS;

        var deviceSize: Rectangle = iOS ? new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight) : new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _deviceType = deviceSize.width==768 || deviceSize.width==1536 ? DeviceType.iPad : (deviceSize.height==1136 ? DeviceType.iPhone5 : DeviceType.iPhone4);
        viewPort = RectangleUtil.fit(_deviceType.size, deviceSize, ScaleMode.SHOW_ALL);

        var isPad: int = deviceSize.width==768 || deviceSize.width==1536 ? 4 : 2;

        _assets = new AssetManager(2);
        basicAssetsPath = formatString("textures/{0}x", isPad);

        var dir: File = File.applicationDirectory;
        _assets.enqueue(
                dir.resolvePath(formatString("preloader/{0}x", isPad))
        );
        initApp ();
    }

    private function initApp ():void {
        _background = _deviceType == DeviceType.iPhone4 ? new Background960() : _deviceType == DeviceType.iPhone5 ? new Background1136() : new Background2048();
        Background960 = Background1136 = Background2048 = null;

        _background.x = viewPort.x;
        _background.y = viewPort.y;
        _background.width  = viewPort.width;
        _background.height = viewPort.height;
        _background.smoothing = true;
        addChild(_background);

        _starling = new Starling(App, stage, viewPort);
        _starling.stage.stageWidth = _deviceType.size.width;
        _starling.stage.stageHeight = _deviceType.size.height;
        _starling.showStats = true;
        _starling.simulateMultitouch = false;
        _starling.enableErrorChecking = Capabilities.isDebugger;

        _starling.addEventListener(starling.events.Event.ROOT_CREATED, handleRootCreated);

        NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.ACTIVATE, function (e:*):void { _starling.start(); });

        NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.DEACTIVATE, function (e:*):void { _starling.stop(); });
    }

    private function handleRootCreated(event: Object,  app: App):void {
        _starling.removeEventListener(starling.events.Event.ROOT_CREATED, handleRootCreated);
        app.start(_assets, basicAssetsPath, _deviceType, _background);
        _starling.start();
    }
}
}
