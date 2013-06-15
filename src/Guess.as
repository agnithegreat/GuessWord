package {
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
import starling.utils.formatString;

public class Guess extends Sprite {

    [Embed(source="../assets/textures/960.jpg")]
    private static var Background:Class;

    private var _background: Bitmap;

    // TODO: replace by self-created
    private var _assets: AssetManager;

    private var viewPort:Rectangle;

    private var _starling: Starling;

    private var basicAssetsPath:String;

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
        Starling.handleLostContext = true;

        viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);

        _assets = new AssetManager(1);

        basicAssetsPath = formatString("textures/{0}x", 2);

        var dir: File = File.applicationDirectory;
        _assets.enqueue(
                dir.resolvePath(formatString("preloader/{0}x", 2))
        );
        initApp ();
    }

    private function initApp ():void {
        _background = new Background();
        Background = null;

        _background.x = viewPort.x;
        _background.y = viewPort.y;
        _background.width  = viewPort.width;
        _background.height = viewPort.height;
        _background.smoothing = true;
        addChild(_background);

        _starling = new Starling(App, stage, viewPort);
        _starling.stage.stageWidth = viewPort.width;
        _starling.stage.stageHeight = viewPort.height;
//        _starling.showStats = true;
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
        app.start(_assets, basicAssetsPath, _background);
        _starling.start();
    }
}
}
