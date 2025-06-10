package com.hczhhm.ios_adquest;

import android.app.Activity;
import android.widget.FrameLayout;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;
import com.advance.AdvanceNativeExpress;
import com.advance.AdvanceNativeExpressListener;
import com.advance.model.AdvanceError;
import com.advance.AdvanceNativeExpressAdItem;
import java.util.List;

public class FeedAdPlatformView implements PlatformView {
    private final FrameLayout container;
    private AdvanceNativeExpress advanceNativeExpress;

    public FeedAdPlatformView(Activity activity, int id, Object args) {
        container = new FrameLayout(activity);
        if (args instanceof Map) {
            Map params = (Map) args;
            String placementID = params.get("placementID") != null ? params.get("placementID").toString() : null;
            // String sceneID = params.get("sceneID") != null ? params.get("sceneID").toString() : null;
            if (placementID != null) {
                advanceNativeExpress = new AdvanceNativeExpress(activity, placementID);
                advanceNativeExpress.setAdContainer(container);
                advanceNativeExpress.setAdListener(new AdvanceNativeExpressListener() {
                    @Override
                    public void onAdLoaded(List<AdvanceNativeExpressAdItem> list) {
                        if (advanceNativeExpress != null) {
                            advanceNativeExpress.show();
                        }
                    }
                    @Override
                    public void onAdRenderSuccess(android.view.View view) {}
                    @Override
                    public void onAdClose(android.view.View view) {
                        container.removeAllViews();
                    }
                    @Override
                    public void onAdShow(android.view.View view) {}
                    @Override
                    public void onAdFailed(AdvanceError advanceError) {}
                    @Override
                    public void onSdkSelected(String id) {}
                    @Override
                    public void onAdRenderFailed(android.view.View view) {}
                    @Override
                    public void onAdClicked(android.view.View view) {}
                });
                advanceNativeExpress.loadStrategy();
            }
        }
    }

    @Override
    public android.view.View getView() {
        return container;
    }

    @Override
    public void dispose() {
        if (advanceNativeExpress != null) {
            advanceNativeExpress.destroy();
        }
    }
} 