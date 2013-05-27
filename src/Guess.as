package {
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.events.Event;
import flash.filesystem.File;
import flash.geom.Rectangle;
import flash.media.AudioPlaybackMode;
import flash.media.SoundMixer;
import flash.system.Capabilities;

import starling.core.Starling;
import starling.events.Event;
import starling.textures.Texture;

import starling.utils.AssetManager;
import starling.utils.RectangleUtil;
import starling.utils.ScaleMode;
import starling.utils.formatString;

[SWF(frameRate="60", width="768", height="1024")]
public class Guess extends Sprite {

    private static const iPhone: Rectangle = new Rectangle(0,0,320,480);
    private static const iPad: Rectangle = new Rectangle(0,0,768,1024);
    public static var size: Rectangle;

//    // Startup image for HD screens
//    [Embed(source="../assets/textures/loaderHD.png")]
//    private static var BackgroundHD:Class;

//    [Embed(source="../fonts/poplarstd.ttf", embedAsCFF="false", fontFamily="Polar Std")]
//    private static const Polar:Class;

    private var _assets: AssetManager;

    private var viewPort:Rectangle;
    private static var fontFileName:String = "PoplarStd.swf";

    private var basicAssetsPath:String;
    private var _scaleFactor: Number;

    private var _starling: Starling;

    public function Guess() {
        if (stage) {
            handleAddedToStage();
        } else {
            addEventListener(flash.events.Event.ADDED_TO_STAGE, handleAddedToStage);
        }
    }

    private function handleAddedToStage(event:flash.events.Event = null):void {
        removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
        init();
    }

    private function init():void {
        var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
        Starling.multitouchEnabled = true;
        Starling.handleLostContext = !iOS;

        SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;

        GUI.init();

//        Fonts.init(_config.data.path+"/fonts/", [fontFileName]);

        var deviceSize: Rectangle = iOS ? new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight) : new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        size = deviceSize.width==768 || deviceSize.width==1536 ? iPad : iPhone;
        var isPad: int = deviceSize.width==768 || deviceSize.width==1536 ? 2 : 0;
        viewPort = RectangleUtil.fit(size, deviceSize, ScaleMode.SHOW_ALL);

        _scaleFactor = viewPort.width==320 || viewPort.width==768 ? 1 : 2;

        _scaleFactor = 2;
        isPad = 2;

        _assets = new AssetManager(_scaleFactor);
        basicAssetsPath = formatString("textures/{0}x", _scaleFactor + isPad);

        var dir: File = File.applicationDirectory;
        _assets.enqueue(
                dir.resolvePath(formatString("preloader/{0}x", _scaleFactor + isPad))
        );
        initApp ();
    }

    private function initApp ():void {
        _starling = new Starling(App, stage, viewPort);
        _starling.stage.stageWidth = size.width;
        _starling.stage.stageHeight = size.height;
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
        app.start(_assets, basicAssetsPath);
        _starling.start();
    }
}
}
