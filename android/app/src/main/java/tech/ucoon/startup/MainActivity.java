package tech.ucoon.startup;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String METHOD_CHANNEL = "ucoon.tech/battery";
    private static final String EVENT_CHANNEL = "ucoon.tech/charging";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), METHOD_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (call.method.equals("getBatteryLevel")){
                    int batteryLevel = getBatteryLevel();
                    if (batteryLevel != -1){
                        String success = (String)call.argument("key") + batteryLevel;
                        result.success(success);
                    }else {
                        result.error("UNAVAILABLE", "Battery level not available.", null);
                    }
                }else {
                    result.notImplemented();
                }
            }
        });

        new EventChannel(flutterEngine.getDartExecutor(), EVENT_CHANNEL).setStreamHandler(new EventChannel.StreamHandler() {
            private BroadcastReceiver chargingStateChangeReceiver;
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                chargingStateChangeReceiver = createChargingStateChangeReceiver(events);
                registerReceiver(chargingStateChangeReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            }

            @Override
            public void onCancel(Object arguments) {
                unregisterReceiver(chargingStateChangeReceiver);
                chargingStateChangeReceiver = null;
            }
        });
    }


    private BroadcastReceiver createChargingStateChangeReceiver(final EventChannel.EventSink eventSink){
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);
                if (status == BatteryManager.BATTERY_STATUS_UNKNOWN){
                    eventSink.error("UNAVAILABLE", "Charging status unavailable", null);
                }else {
                    boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                            status == BatteryManager.BATTERY_STATUS_FULL;
                    eventSink.success(isCharging);
                }
            }
        };
    }

    private int getBatteryLevel(){
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP){
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        }else {
            Intent intent = new ContextWrapper(getApplicationContext()).registerReceiver(null,
                    new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
        return batteryLevel;
    }
}
