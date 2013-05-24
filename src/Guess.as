package {

import flash.desktop.NativeApplication;
import flash.display.Bitmap;
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

[SWF(frameRate="60")]
public class Guess extends Sprite {

    [Embed(source="assets/preloader.png")]
    private static var Background:Class;

//    // Startup image for HD screens
//    [Embed(source="../assets/textures/loaderHD.png")]
//    private static var BackgroundHD:Class;

//    [Embed(source="../fonts/poplarstd.ttf", embedAsCFF="false", fontFamily="Polar Std")]
//    private static const Polar:Class;

    private var _assets: AssetManager;
    private var _background: Bitmap;

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
        init();
    }

    private function init():void {
        var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
        Starling.multitouchEnabled = true;
        Starling.handleLostContext = !iOS;

        SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;

//        Fonts.init(_config.data.path+"/fonts/", [fontFileName]);

        viewPort = RectangleUtil.fit(
                new Rectangle(0, 0, Constants.WIDTH, Constants.HEIGHT),
                iOS ? new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight) : new Rectangle(0, 0, Constants.WIDTH, Constants.HEIGHT),
                ScaleMode.SHOW_ALL);

        // TODO: подготовить графику для retina
//        _scaleFactor = viewPort.width < 1024 ? 1 : 2;
        _scaleFactor = 1;
        _assets = new AssetManager(_scaleFactor);
        basicAssetsPath = formatString("textures/{0}x", _scaleFactor);

        _assets.verbose = true;

        var dir: File = File.applicationDirectory;
        _assets.enqueue(
                dir.resolvePath("sounds"),
                dir.resolvePath("fonts"),
                dir.resolvePath("textures")
        );
        initApp ();
    }

    private function initApp ():void {
        _background = new Background();
//        _background = _scaleFactor == 1 ? new Background() : new BackgroundHD();
//        Background = BackgroundHD = null;

        _background.x = viewPort.x;
        _background.y = viewPort.y;
//        _background.width  = viewPort.width;
//        _background.height = viewPort.height;
        _background.smoothing = true;
        addChild(_background);

        _starling = new Starling(App, stage, viewPort);
        _starling.stage.stageWidth  = Constants.WIDTH;
        _starling.stage.stageHeight = Constants.HEIGHT;
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
        removeChild(_background);

        var bgTexture: Texture = Texture.fromBitmap(_background, false, false, _scaleFactor);

        app.start(_assets, bgTexture);
        _starling.start();
    }
}
}
