package com.hczhhm.ios_adquest;

// BannerAdPlatformViewFactory.java
import android.app.Activity;
import android.content.Context;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import io.flutter.plugin.common.StandardMessageCodec;

public class BannerAdPlatformViewFactory extends PlatformViewFactory {
    private final IosAdquestPlugin plugin;

    public BannerAdPlatformViewFactory(IosAdquestPlugin plugin) {
        super(StandardMessageCodec.INSTANCE);
        this.plugin = plugin;
    }

    @Override
    public PlatformView create(Context context, int id, Object args) {
        Activity activity = plugin.getActivity();
        return new BannerAdPlatformView(activity, id, args);
    }
}