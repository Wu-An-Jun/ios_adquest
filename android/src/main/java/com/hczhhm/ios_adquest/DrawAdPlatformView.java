package com.hczhhm.ios_adquest;

import android.app.Activity;
import android.widget.FrameLayout;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;
import com.advance.AdvanceDraw;
import com.advance.AdvanceDrawListener;
import com.advance.model.AdvanceError;

public class DrawAdPlatformView implements PlatformView {
    private final FrameLayout container;
    private AdvanceDraw advanceDraw;

    public DrawAdPlatformView(Activity activity, int id, Object args) {
        container = new FrameLayout(activity);
        if (args instanceof Map) {
            Map params = (Map) args;
            String placementID = params.get("placementID") != null ? params.get("placementID").toString() : null;
            // String sceneID = params.get("sceneID") != null ? params.get("sceneID").toString() : null;
            if (placementID != null) {
                advanceDraw = new AdvanceDraw(activity, placementID);
                advanceDraw.setAdContainer(container);
                advanceDraw.setAdListener(new AdvanceDrawListener() {
                    @Override
                    public void onAdLoaded() {
                        if (advanceDraw != null) {
                            advanceDraw.show();
                        }
                    }
                    @Override
                    public void onAdShow() {}
                    @Override
                    public void onAdClicked() {}
                    @Override
                    public void onAdFailed(AdvanceError advanceError) {}
                    @Override
                    public void onSdkSelected(String id) {}
                });
                advanceDraw.loadStrategy();
            }
        }
    }

    @Override
    public android.view.View getView() {
        return container;
    }

    @Override
    public void dispose() {
        if (advanceDraw != null) {
            advanceDraw.destroy();
        }
    }
} 