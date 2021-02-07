package com.wotuo.driver;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.PowerManager;
import android.provider.Settings;
import android.util.DisplayMetrics;
import android.view.WindowManager;

import androidx.annotation.Nullable;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
//import android.util.Log;

public class MainActivity extends FlutterActivity {


//    private static String resourceToUriString(Context context, int resId) {
//        return
//                ContentResolver.SCHEME_ANDROID_RESOURCE
//                        + "://"
//                        + context.getResources().getResourcePackageName(resId)
//                        + "/"
//                        + context.getResources().getResourceTypeName(resId)
//                        + "/"
//                        + context.getResources().getResourceEntryName(resId);
//    }

    private static final String CHANNEL = "android/back/desktop";
    private static final String CHANNEL_NOTICE = "crossingthestreams.io/resourceResolver";


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {


        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        Log.e("slh", "来了");
                        if (call.method.equals("backDesktop")) {
                            Log.e("slh", "点返回键了");
                            moveTaskToBack(true);
                            //模拟HOME效果
//                            Intent intent = new Intent(Intent.ACTION_MAIN);
//
//                            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//
//                            intent.addCategory(Intent.CATEGORY_HOME);
//
//                            startActivity(intent);
                            result.success(true);
                        }else {
                            result.notImplemented();
                        }
                    }
                });
        super.configureFlutterEngine(flutterEngine);

    }


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        DisplayMetrics metric = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(metric);
        int width = metric.widthPixels; // 宽度（baiPX）
        int height = metric.heightPixels; // 高度（PX）
        float density = metric.density; // 密度（0.75 / 1.0 / 1.5）
        int densityDpi = metric.densityDpi; // 密度DPI（120 / 160 / 240）

        Log.e("c","宽："+width + "，高："+height+",dpi："+densityDpi);

        getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON, WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

        openSpeaker();
        if(!isTaskRoot()){
            finish();
        }
        if(!isIgnoringBatteryOptimizations()){
            requestIgnoreBatteryOptimizations();
        }
        PlayMusicService.startService(this);
        acquireWakeLock();

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        releaseWakeLock();
    }

    private int currVolume = 0;

    /**
     * 打开扬声器
     */
    private void openSpeaker() {
        try {
            AudioManager audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
            audioManager.setMode(AudioManager.ROUTE_SPEAKER);
            currVolume = audioManager.getStreamVolume(AudioManager.STREAM_VOICE_CALL);
            if (!audioManager.isSpeakerphoneOn()) {
                //setSpeakerphoneOn() only work when audio mode set to MODE_IN_CALL.
                audioManager.setMode(AudioManager.MODE_IN_CALL);
                audioManager.setSpeakerphoneOn(true);
                audioManager.setStreamVolume(AudioManager.STREAM_VOICE_CALL,
                        audioManager.getStreamMaxVolume(AudioManager.STREAM_VOICE_CALL),
                        AudioManager.STREAM_VOICE_CALL);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 关闭扬声器
     */
    public void closeSpeaker() {
        try {
            AudioManager audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
            if (audioManager != null) {
                if (audioManager.isSpeakerphoneOn()) {
                    audioManager.setSpeakerphoneOn(false);
                    audioManager.setStreamVolume(AudioManager.STREAM_VOICE_CALL, currVolume,
                            AudioManager.STREAM_VOICE_CALL);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 判断我们的应用是否在白名单中
     *
     * @return
     */
    @TargetApi(Build.VERSION_CODES.M)
    private boolean isIgnoringBatteryOptimizations() {
        boolean isIgnoring = false;
        PowerManager powerManager = (PowerManager) getSystemService(POWER_SERVICE);
        if (powerManager != null) {
            isIgnoring = powerManager.isIgnoringBatteryOptimizations(getPackageName());
        }
//        Log.e(TAG, "判断我们的应用是否在白名单中: " + isIgnoring);
        return isIgnoring;
    }

    /**
     * 申请加入白名单：
     */
    public void requestIgnoreBatteryOptimizations() {
        try {
            Intent intent = new Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
            intent.setData(Uri.parse("package:" + getPackageName()));
            startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * import android.os.PowerManager;
     * 获取电源锁，保持该服务在屏幕熄灭时仍然获取CPU时，保持运行
     */
    private PowerManager.WakeLock wakeLock = null;
    private void acquireWakeLock() {
        if (null == wakeLock) {
            PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
            wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK
                    | PowerManager.ON_AFTER_RELEASE, getClass()
                    .getCanonicalName());
            if (null != wakeLock) {
                Log.e("TAG", "call acquireWakeLock");
                wakeLock.acquire();
            }
        }
    }

    // 释放设备电源锁
    private void releaseWakeLock() {
        if (null != wakeLock && wakeLock.isHeld()) {
            Log.e("TAG", "call releaseWakeLock");
            wakeLock.release();
            wakeLock = null;
        }
    }


//    private String channel = "android/back/desktop";
//
//    @java.lang.Override
//    protected void onCreate(android.os.Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//
//        // 1.创建MethodChannel对象
//        new MethodChannel((BinaryMessenger) getFlutterEngine(), channel).setMethodCallHandler(
//                (call, result) -> {
//                    // 在这个回调里处理从Flutter来的调用
//                    if (call.method.equals("backDesktop")) {
//                        moveTaskToBack(false);
//                    }
//                });
//
//
//    }
//通讯名称,回到手机桌面
//    private final String chanel = "android/back/desktop";
//    //返回手机桌面事件
//    static final String eventBackDesktop = "backDesktop";
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {//API>21,设置状态栏颜色透明
//            getWindow().setStatusBarColor(0);
//        }
//        GeneratedPluginRegistrant.registerWith(this);
//        initBackTop();
//    }
//
//    @Override
//    protected void onResume() {
//        super.onResume();
//        UmengGlobal.getInstance(this).onResume();
//    }
//
//    @Override
//    protected void onPause() {
//        super.onPause();
//        UmengGlobal.getInstance(this).onPause();
//    }
//
//    //注册返回到手机桌面事件
//    private void initBackTop() {
//        new MethodChannel(getFlutterView(), chanel).setMethodCallHandler(
//                (methodCall, result) -> {
//                    if (methodCall.method.equals(eventBackDesktop)) {
//                        moveTaskToBack(false);
//                        result.success(true);
//                    }
//                }
//        );
//    }
}