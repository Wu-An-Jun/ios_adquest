package com.hczhhm.ios_adquest;

import android.app.Activity;
import android.widget.FrameLayout;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;
import com.advance.AdvanceBanner;
import com.advance.AdvanceBannerListener;
import com.advance.model.AdvanceError;

public class BannerAdPlatformView implements PlatformView {
    private final FrameLayout container;
    private AdvanceBanner advanceBanner;

    public BannerAdPlatformView(Activity activity, int id, Object args) {
        container = new FrameLayout(activity);
        if (args instanceof Map) {
            Map params = (Map) args;
            String placementID = params.get("placementID") != null ? params.get("placementID").toString() : null;
            // sceneID 可选参数
            // String sceneID = params.get("sceneID") != null ? params.get("sceneID").toString() : null;
            if (placementID != null) {
                advanceBanner = new AdvanceBanner(activity, container, placementID);
                advanceBanner.setAdListener(new AdvanceBannerListener() {
                    @Override
                    public void onDislike() {
                        container.removeAllViews();
                    }
                    @Override
                    public void onAdShow() {}
                    @Override
                    public void onAdFailed(AdvanceError advanceError) {}
                    @Override
                    public void onSdkSelected(String id) {}
                    @Override
                    public void onAdClicked() {}
                    @Override
                    public void onAdLoaded() {}
                });
                advanceBanner.loadStrategy();
            }
        }
    }

    @Override
    public android.view.View getView() {
        return container;
    }

    @Override
    public void dispose() {
        if (advanceBanner != null) {
            advanceBanner.destroy();
        }
    }
} 