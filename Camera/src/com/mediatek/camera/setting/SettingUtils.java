/* Copyright Statement:
 *
 * This software/firmware and related documentation ("MediaTek Software") are
 * protected under relevant copyright laws. The information contained herein is
 * confidential and proprietary to MediaTek Inc. and/or its licensors. Without
 * the prior written permission of MediaTek inc. and/or its licensors, any
 * reproduction, modification, use or disclosure of MediaTek Software, and
 * information contained herein, in whole or in part, shall be strictly
 * prohibited.
 * 
 * MediaTek Inc. (C) 2014. All rights reserved.
 * 
 * BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
 * THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
 * RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER
 * ON AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL
 * WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR
 * NONINFRINGEMENT. NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH
 * RESPECT TO THE SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY,
 * INCORPORATED IN, OR SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES
 * TO LOOK ONLY TO SUCH THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO.
 * RECEIVER EXPRESSLY ACKNOWLEDGES THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO
 * OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES CONTAINED IN MEDIATEK
 * SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK SOFTWARE
 * RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
 * STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S
 * ENTIRE AND CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE
 * RELEASED HEREUNDER WILL BE, AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE
 * MEDIATEK SOFTWARE AT ISSUE, OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE
 * CHARGE PAID BY RECEIVER TO MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
 *
 * The following software/firmware and/or related documentation ("MediaTek
 * Software") have been modified by MediaTek Inc. All revisions are subject to
 * any receiver's applicable license agreements with MediaTek Inc.
 */
package com.mediatek.camera.setting;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.graphics.Point;
import android.hardware.Camera.Size;
import android.media.CamcorderProfile;
import android.view.Display;
import android.view.View;
import android.view.WindowManager;
//TODO:CamcorderProfileEx
import com.mediatek.camcorder.CamcorderProfileEx;
import com.mediatek.camera.ISettingCtrl;
import com.mediatek.camera.platform.Parameters;
import com.mediatek.camera.setting.preference.ListPreference;
import com.mediatek.camera.setting.preference.RecordLocationPreference;
import com.mediatek.camera.util.Log;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
/* Vanzo:hanshengpeng on: Thu, 22 Jan 2015 16:58:22 +0800
 */
import com.android.camera.FeatureSwitcher;
// End of Vanzo:hanshengpeng

public class SettingUtils {
    private static final String TAG = "SettingUtils";
    
    public static final String PICTURE_RATIO_16_9                   = "1.7778";
    public static final String PICTURE_RATIO_5_3                    = "1.6667";
    public static final String PICTURE_RATIO_3_2                    = "1.5";
    public static final String PICTURE_RATIO_4_3                    = "1.3333";
    public static final String STEREO3D_ENABLE                      = "1";
    public static final String STEREO3D_DISABLE                     = "0";
    public static final String RESET_STATE_VALUE_DISABLE            = "disable-value";
    public static final String KEY_INTO_VIDEO_FACE_BEAUTY_NORMAL    = "face-beauty-normal";
    public static final String STEREO_CAMERA_ON                     = "on";
    public static final String STEREO_CAMERA_OFF                    = "off";
    
    private static final String ENABLE_LIST_HEAD             = "[L];";
    private static final String ENABLE_LIST_SEPERATOR        = ";";
    
    
    private static final float ALPHA_ENABLE = 1.0F;
    private static final float ALPHA_DISABLE = 0.3F;
    public static final double ASPECT_TOLERANCE = 0.001;
    // TODO
    public static final boolean SUPPORTED_SHOW_CONINUOUS_SHOT_NUMBER = true;
    public static final double[] RATIOS = new double[] { 1.3333, 1.5, 1.6667, 1.7778 };
    
    // public static final boolean SUPPORTED_SHOW_CONINUOUS_SHOT_NUMBER =
    // !FeatureSwitcher.isLcaRAM();
    
    public static final MappingFinder MAPPING_FINDER_PICTURE_SIZE = new PictureSizeMappingFinder();
    public static final MappingFinder MAPPING_FINDER_FLASH = new FlashMappingFinder();
    public static final MappingFinder MAPPING_FINDER_VIDEO_QUALITY = new VideoQualityMappingFinder();
    
    private static final int NOT_FOUND = -1;
    private static final int UNKNOWN = -1;
    public static final int CURRENT_VERSION = 5;
    public static final int CURRENT_LOCAL_VERSION = 2;
    public static final int INTO_VIDEO_FACE_BEAUTY_NORMAL           = 1;
    public static final int INTO_VIDEO_FACE_BEAUTY_NON_NORMAL       = 0;
    
    private static final DecimalFormat DECIMAL_FORMATOR = new DecimalFormat("######.####",
            new DecimalFormatSymbols(Locale.ENGLISH));
    
    private static double mCurrentFullScreenRatio;
    private static int mLimitResolution;
    
    private SettingUtils() {
    }
    
    // add for pip, pip should restore top camera's(preview size, picture
    // size,zsd, anti flicker)
    public static void setPreferenceValue(Context context, SharedPreferences sharedPreferences,
            int settingId, String value) {
        String key = SettingConstants.getSettingKey(settingId);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(key, value);
        editor.apply();
    }
    
    public static String getPreferenceValue(Context context, SharedPreferences sharedPreferences,
            int settingId, String defaultValue) {
        String key = SettingConstants.getSettingKey(settingId);
        String value = sharedPreferences.getString(key, defaultValue);
        if ((settingId == SettingConstants.ROW_SETTING_PICTURE_RATIO) && (value == null)) {
            value = PICTURE_RATIO_4_3;
        }
        Log.i(TAG, "getPreferenceValue(" + settingId + ") return " + value);
        return value;
    }
    
    public static void setPictureSize(Context context, Parameters parameters,
            SharedPreferences sharedPreferences, String pictureSize, SettingItem previewRatioSetting) {
        if (pictureSize == null) {
/* Vanzo:hanshengpeng on: Thu, 22 Jan 2015 17:53:27 +0800
 * control default preview size
            initialCameraPictureSize(context, parameters, sharedPreferences);
 */
            initialCameraPictureSize(context, parameters, sharedPreferences, -1);
// End of Vanzo:hanshengpeng
        } else {
            List<Size> supported = parameters.getSupportedPictureSizes();
            String defaultRatio = getDefaultValueFromXml(context, previewRatioSetting);
            String targetRatio = getPreferenceValue(context, sharedPreferences,
                    SettingConstants.ROW_SETTING_PICTURE_RATIO, defaultRatio);
            setCameraPictureSize(pictureSize, supported, parameters, targetRatio,
                    context);
        }
    }
    
    public static void setPreviewSize(Context context, Parameters parameters, String prviewRatio) {
        double previewRatio = Double.parseDouble(prviewRatio);
        List<Size> sizes = parameters.getSupportedPreviewSizes();
        Size optimalSize = getOptimalPreviewSize(context, sizes, previewRatio, false, true);
         
        Size original = parameters.getPreviewSize();
        if (!original.equals(optimalSize) ) {
            Log.i(TAG, "setPreviewSize, Width = " + optimalSize.width +",Height = " + optimalSize.height);
            parameters.setPreviewSize(optimalSize.width, optimalSize.height);
        }
        setPreviewFrameRate(context, parameters, -1);
    }
    
    public static void setPipPreviewSize(Activity activity, Parameters parameters, Parameters topParameters, ISettingCtrl iSettingCtrl, String value) {
        Log.d(TAG, "setPipPreviewSize(" + value + ")");
        // Set Bottom sensor optimal preview size.
        setPreviewSize(activity, parameters, value);
        
        // Set Top sensor optimal preview size.
        double previewRatio = Double.parseDouble(iSettingCtrl.getSettingValue(SettingConstants.KEY_PICTURE_RATIO));
        List<Size> sizes = parameters.getSupportedPreviewSizes();
        Size optimalSize = getOptimalPreviewSize(activity, sizes, previewRatio, false, true);
        if (topParameters != null) {
            Size topOptimalSize = getOptimalPreviewSize(activity, topParameters.getSupportedPreviewSizes(), previewRatio, false, true);
            optimalSize = (optimalSize.width > topOptimalSize.width)? topOptimalSize : optimalSize;
            topParameters.setPreviewSize(optimalSize.width, optimalSize.height);
        }
        // Set Preview Frame Rate
        setPipPreviewFrameRate(iSettingCtrl, parameters, topParameters);
    }
    
    public static String getOptimalPreviewSize(Context context, Parameters parameters, String ratio) {
        double previewRatio = Double.parseDouble(ratio);
        List<Size> sizes = parameters.getSupportedPreviewSizes();
        Size optimalSize = getOptimalPreviewSize(context, sizes, previewRatio, false, true);
        return buildSize(optimalSize);
    }
    
    // TODO why use this name ?
    public static String getDefaultValueFromXml(Context context, SettingItem settingItem) {
        int settingId = settingItem.getSettingId();
        String value = SettingDataBase.getDefaultValue(settingId);
        if (value == null) {
            ListPreference pref = settingItem.getListPreference();
            if (!SUPPORTED_SHOW_CONINUOUS_SHOT_NUMBER
                    && settingId == SettingConstants.ROW_SETTING_CONTINUOUS_NUM) {
                value = SettingConstants.DEFAULT_CONINUOUS_CAPTURE_NUM;
            } else {
                if (pref != null) {
                    value = pref.findSupportedDefaultValue();
                    if (value == null && pref.getEntryValues() != null
                            && pref.getEntryValues().length > 0) {
                        value = String.valueOf(pref.getEntryValues()[0]);
                    }
                }
                // last defense for some preference may be removed for supported
                // values less than 2.
                if (value == null) {
                    int resId = SettingDataBase.getDefaultSettingID(settingId);
                    if (resId != UNKNOWN) {
                        value = context.getString(resId);
                    }
                }
            }
            SettingDataBase.setDefaultValue(settingId, value);
            Log.i(TAG, "getDefaultValueFromXml(" + settingId + ") " + pref);
        }
        Log.d(TAG, "getDefaultValueFromXml(" + settingId + ") return " + value);
        return value;
    }
    
    public static boolean setCameraPictureSize(String candidate, List<Size> supported,
            Parameters parameters, String targetRatio, Context context) {
        Log.d(TAG, "setCameraPictureSize(" + candidate + ")");
        int index = candidate.indexOf('x');
        if (index == NOT_FOUND) {
            return false;
        }
        List<String> supportedRatioSizes = buildSupportedPictureSize(context, parameters,
                targetRatio);
        candidate = MAPPING_FINDER_PICTURE_SIZE.find(candidate, supportedRatioSizes);
        index = candidate == null ? NOT_FOUND : candidate.indexOf('x');
        int width = Integer.parseInt(candidate.substring(0, index));
        int height = Integer.parseInt(candidate.substring(index + 1));
        parameters.setPictureSize(width, height);
        return true;
    }
    
    public static boolean isSupported(Object value, List<?> supported) {
        return supported == null ? false : supported.indexOf(value) >= 0;
    }
    
    public static void initialCameraPictureSize(Context context, Parameters parameters, 
/* Vanzo:hanshengpeng on: Thu, 22 Jan 2015 17:54:05 +0800
 * control default preview size
            SharedPreferences sharedPreferences) {
 */
            SharedPreferences sharedPreferences, int cameraId) {
// End of Vanzo:hanshengpeng
        // / M: here we find the full screen picture size for default, not first
        // one in arrays.xml
        List<String> supportedRatios = buildPreviewRatios(context, parameters);
        String ratioString = null;
        if (supportedRatios != null && supportedRatios.size() > 0) {
            SharedPreferences.Editor editor = sharedPreferences.edit();
            ratioString = supportedRatios.get(supportedRatios.size() - 1);
/* Vanzo:hanshengpeng on: Thu, 22 Jan 2015 16:42:42 +0800
 * control default preview size
 */
            if (!FeatureSwitcher.isFrontCameraPreviewFullscreen() && cameraId == 1
                    || !FeatureSwitcher.isBackCameraPreviewFullscreen() && cameraId == 0)
                ratioString = supportedRatios.get(0);
// End of Vanzo:hanshengpeng
            editor.putString(SettingConstants.KEY_PICTURE_RATIO, ratioString);
            editor.apply();
        }
        List<String> supportedSizes = buildSupportedPictureSize(context, parameters, ratioString);
        if (supportedSizes != null && supportedSizes.size() > 0) {
            String findPictureSize = supportedSizes.get(supportedSizes.size() - 1);
            SharedPreferences.Editor editor = sharedPreferences.edit();
            editor.putString(SettingConstants.KEY_PICTURE_SIZE, findPictureSize);
            editor.apply();
            Point ps = SettingUtils.getSize(findPictureSize);
            parameters.setPictureSize(ps.x, ps.y);
        }
    }
    
    public static List<String> buildSupportedPictureSize(Context context,
            Parameters parameters, String targetRatio) {
        ArrayList<String> list = new ArrayList<String>();
        double ratio = 0;
        if (targetRatio == null) {
            ratio = findFullscreenRatio(context, parameters);
        } else {
            try {
                ratio = Double.parseDouble(targetRatio);
            } catch (NumberFormatException e) {
                Log.w(TAG, "buildSupportedPictureSize() bad ratio: " + targetRatio, e);
                ratio = findFullscreenRatio(context, parameters);
            }
        }
        List<Size> sizes = parameters.getSupportedPictureSizes();
        if (sizes != null) {
            for (Size size : sizes) {
                if (toleranceRatio(ratio, (double) size.width / size.height)) {
                    list.add(buildSize(size.width, size.height));
                }
            }
        }
        Log.d(TAG,
                "buildSupportedPictureSize(" + parameters + ", " + targetRatio + ")" + list.size());
        for (String added : list) {
            Log.d(TAG, "buildSupportedPictureSize() add " + added);
        }
        return list;
    }
    
    public static List<String> buildPreviewRatios(Context context, Parameters parameters) {
        List<String> supportedRatios = new ArrayList<String>();
        String findString = null;
        if (context != null && parameters != null) {
            double find = findFullscreenRatio(context, parameters);
            mCurrentFullScreenRatio = find;
            supportedRatios.add(SettingUtils.getRatioString(4d / 3)); // add
                                                                      // standard
                                                                      // ratio
            findString = SettingUtils.getRatioString(find);
            if (!supportedRatios.contains(findString)) { // add full screen
                                                         // ratio
                supportedRatios.add(findString);
            }
        }
        Log.d(TAG, "buildPreviewRatios(" + parameters + ") add supportedRatio " + findString);
        return supportedRatios;
    }
    
    public static double getFullScreenRatio() {
        return mCurrentFullScreenRatio;
    }
    
    public static void setLimitResolution(final int resolution) {
        Log.i(TAG, "[setLimitResolution], resolution:" + resolution);
        mLimitResolution = resolution;
    }
    
    public static int getLimitResolution() {
        return mLimitResolution;
    }
    
    public static void filterLimitResolution(List<String> pictureSizes) {
        Log.i(TAG, "[filterLimitResolution], mLimitResolution:" + mLimitResolution);
        if (mLimitResolution > 0) {
            for (int i = 0; i < pictureSizes.size(); i++) {
                String size = pictureSizes.get(i);
                int index = size.indexOf('x');
                int width = Integer.parseInt(size.substring(0, index));
                int height = Integer.parseInt(size.substring(index + 1));
                if (width * height > mLimitResolution) {
                    pictureSizes.remove(i);
                    i--;
                }
            }
        }
    }
    
    public static double findFullscreenRatio(Context context, Parameters parameters) {
        double find = 4d / 3;
        if (context != null && parameters != null) {
            WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            Display display = wm.getDefaultDisplay();
            Point point = new Point();
            display.getRealSize(point);
            
            double fullscreen;
            if (point.x > point.y) {
                fullscreen = (double) point.x / point.y;
            } else {
                fullscreen = (double) point.y / point.x;
            }
            Log.i(TAG, "fullscreen = " + fullscreen + " x = " + point.x + " y = " + point.y);
            for (int i = 0; i < RATIOS.length; i++) {
                if (Math.abs(RATIOS[i] - fullscreen) < Math.abs(fullscreen - find)) {
                    find = RATIOS[i];
                }
            }
        }
        List<Size> sizes = parameters.getSupportedPictureSizes();
        if (sizes != null) {
            for (Size size : sizes) {
                if (toleranceRatio(find, (double) size.width / size.height)) {
                    Log.i(TAG, "findFullscreenRatio(" + parameters + ") return " + find);
                    return find;
                }
            }
            find = 4d / 3;
        }
        Log.d(TAG, "findFullscreenRatio(" + parameters + ") return " + find);
        return find;
    }
    
    public static void setPreviewFrameRate(Context context, Parameters parameters,
            int supportedFramerate) {
        List<Integer> frameRates = null;
        if (supportedFramerate > 0) {
            frameRates = new ArrayList<Integer>();
            frameRates.add(supportedFramerate);
        }
        
        if (frameRates == null) {
            // Reset preview frame rate to the maximum because it may be lowered
            // by
            // video camera application.
            frameRates = parameters.getSupportedPreviewFrameRates();
        }
        
        if (frameRates != null) {
            Integer max = Collections.max(frameRates);
            parameters.setPreviewFrameRate(max);
            Log.i(TAG, "setPreviewFrameRate max = " + max + " frameRates = " + frameRates);
        }
    }
    
    public static Size getOptimalPreviewSize(Context context, List<Size> sizes, double targetRatio,
            boolean findMinalRatio, boolean needStandardPreview) {
        // Use a very small tolerance because we want an exact match.
        // final double EXACTLY_EQUAL = 0.001;
        if (sizes == null) {
            return null;
        }
        
        Size optimalSize = null;
        double minDiff = Double.MAX_VALUE;
        double minDiffWidth = Double.MAX_VALUE;
        
        // Because of bugs of overlay and layout, we sometimes will try to
        // layout the viewfinder in the portrait orientation and thus get the
        // wrong size of preview surface. When we change the preview size, the
        // new overlay will be created before the old one closed, which causes
        // an exception. For now, just get the screen size.
        WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        Display display = wm.getDefaultDisplay();
        Point point = new Point();
        display.getRealSize(point);
        int targetHeight = Math.min(point.x, point.y);
        int targetWidth = Math.max(point.x, point.y);
        if (findMinalRatio) {
            // Find minimal aspect ratio for that: special video size maybe not
            // have the mapping preview size.
            double minAspectio = Double.MAX_VALUE;
            for (Size size : sizes) {
                double aspectRatio = (double) size.width / size.height;
                if (Math.abs(aspectRatio - targetRatio) <= Math.abs(minAspectio - targetRatio)) {
                    minAspectio = aspectRatio;
                }
            }
            Log.d(TAG, "getOptimalPreviewSize(" + targetRatio + ") minAspectio=" + minAspectio);
            targetRatio = minAspectio;
        }
        
        // Try to find an size match aspect ratio and size
        for (Size size : sizes) {
            double ratio = (double) size.width / size.height;
            if (Math.abs(ratio - targetRatio) > ASPECT_TOLERANCE) {
                continue;
            }
            if (Math.abs(size.height - targetHeight) < minDiff) {
                optimalSize = size;
                minDiff = Math.abs(size.height - targetHeight);
                minDiffWidth = Math.abs(size.width - targetWidth);
            } else if ((Math.abs(size.height - targetHeight) == minDiff)
                    && Math.abs(size.width - targetWidth) < minDiffWidth) {
                optimalSize = size;
                minDiffWidth = Math.abs(size.width - targetWidth);
            }
        }
        // Cannot find the one match the aspect ratio. This should not happen.
        // Ignore the requirement.
        // / M: This will happen when native return video size and wallpaper
        // want to get specified ratio.
        if (optimalSize == null && needStandardPreview) {
            Log.w(TAG, "No preview size match the aspect ratio" + targetRatio + ","
                    + "then use the standard(4:3) preview size");
            minDiff = Double.MAX_VALUE;
            targetRatio = Double.parseDouble(PICTURE_RATIO_4_3);
            for (Size size : sizes) {
                double ratio = (double) size.width / size.height;
                if (Math.abs(ratio - targetRatio) > ASPECT_TOLERANCE) {
                    continue;
                }
                if (Math.abs(size.height - targetHeight) < minDiff) {
                    optimalSize = size;
                    minDiff = Math.abs(size.height - targetHeight);
                }
            }
        }
        return optimalSize;
    }
    
    public static String getRatioString(double ratio) {
        return DECIMAL_FORMATOR.format(ratio);
    }
    
    public static Point getSize(String sizeString) {
        Point size = null;
        int index = sizeString.indexOf('x');
        if (index != UNKNOWN) {
            int width = Integer.parseInt(sizeString.substring(0, index));
            int height = Integer.parseInt(sizeString.substring(index + 1));
            size = new Point(width, height);
        }
        Log.d(TAG, "[getSize] (" + sizeString + ") return " + size);
        return size;
    }
    
    public static String buildSize(Size size) {
        if (size != null) {
            return "" + size.width + "x" + size.height;
        } else {
            return "null";
        }
    }
    
    public static String buildSize(int width, int height) {
        return "" + width + "x" + height;
    }
    
    public static boolean equals(Object a, Object b) {
        return (a == b) || (a == null ? false : a.equals(b));
    }
    
    public interface MappingFinder {
        public String find(String current, List<String> supportedList);
        
        public int findIndex(String current, List<String> supportedList);
    }
    
    public static class VideoQualityMappingFinder implements MappingFinder {
        @Override
        public String find(String current, List<String> supportedList) {
            String supported = current;
            if (supportedList != null && !supportedList.contains(current)) {
                if (Integer.toString(CamcorderProfileEx.QUALITY_FINE).equals(current)) {
                    supported = Integer.toString(CamcorderProfileEx.QUALITY_HIGH); 
                                                                                     // normal
                                                                                     // fine
                                                                                     // quality
                                                                                     // to
                                                                                     // high
                                                                                     // in
                                                                                     // pip
                                                                                     // mode
                }
            }
            if (!supportedList.contains(supported)) {
                supported = supportedList.get(0);
            }
            return supported;
        }
        
        @Override
        public int findIndex(String current, List<String> supportedList) {
            int index = UNKNOWN;
            if (supportedList != null) {
                String supported = find(current, supportedList);
                index = supportedList.indexOf(supported);
            }
            Log.i(TAG, "VideoQualityMappingFinder [findIndex](" + current + ", " + supportedList
                    + ") return " + index);
            return index;
        }
    }
    
    public static class FlashMappingFinder implements MappingFinder {
        @Override
        public String find(String current, List<String> supportedList) {
            String supported = current;
            if (supportedList != null && !supportedList.contains(current)) {
                if (Parameters.FLASH_MODE_ON.equals(current)) { // if cannot
                                                                // find on, it
                                                                // video mode,
                                                                // match torch
                    supported = Parameters.FLASH_MODE_TORCH;
                } else if (Parameters.FLASH_MODE_TORCH.equals(current)) { // if
                                                                          // cannot
                                                                          // find
                                                                          // torch,
                                                                          // it
                                                                          // video
                                                                          // mode,
                                                                          // match
                                                                          // on
                    supported = Parameters.FLASH_MODE_ON;
                }
            }
            if (!supportedList.contains(supported)) {
                supported = supportedList.get(0);
            }
            Log.i(TAG, "find(" + current + ") return " + supported);
            return supported;
        }
        
        @Override
        public int findIndex(String current, List<String> supportedList) {
            int index = UNKNOWN;
            if (supportedList != null) {
                String supported = find(current, supportedList);
                index = supportedList.indexOf(supported);
            }
            Log.d(TAG, "findIndex(" + current + ", " + supportedList + ") return " + index);
            return index;
        }
    }
    
    public static class PictureSizeMappingFinder implements MappingFinder {
        @Override
        public String find(String current, List<String> supportedList) {
            String supported = current;
            int index = current.indexOf('x');
            if (index != UNKNOWN && supportedList != null && !supportedList.contains(current)) {
                // find other appropriate size
                int size = supportedList.size();
                Point findPs = SettingUtils.getSize(supportedList.get(size - 1));
                Point candidatePs = SettingUtils.getSize(current);
/* Vanzo:yaokaikai on: Thu, 30 Jul 2015 15:13:34 +0800
                for (int i = size - 2; i >= 0; i--) {
                    Point ps = SettingUtils.getSize(supportedList.get(i));
                    if (ps != null
                            && Math.abs(ps.x - candidatePs.x) < Math.abs(findPs.x - candidatePs.x)) {
                        findPs = ps;
                    }
                }
 * change camera size same
 */
            for (int i = size - 2; i >= 0; i--) {
                    Point ps = SettingUtils.getSize(supportedList.get(i));
                    if (ps != null && Math.abs(ps.x*ps.y- candidatePs.x*candidatePs.y) <
                            Math.abs(findPs.x*findPs.y- candidatePs.x*candidatePs.y)) {
                        findPs = ps;
                    }
                }
// End of Vanzo:yaokaikai
                supported = SettingUtils.buildSize(findPs.x, findPs.y);
            }
            if (!supportedList.contains(supported)) {
                supported = supportedList.get(0);
            }
            Log.d(TAG, "find(" + current + ") return " + supported);
            return supported;
        }
        
        @Override
        public int findIndex(String current, List<String> supportedList) {
            int index = UNKNOWN;
            if (supportedList != null) {
                String supported = find(current, supportedList);
                index = supportedList.indexOf(supported);
            }
            Log.d(TAG, "findIndex(" + current + ", " + supportedList + ") return " + index);
            return index;
        }
    }
    
    public static void restorePreferences(Context context, SharedPreferences sharedPreferences,
            Parameters parameters, boolean isNonePickIntent) {
        String current3DMode = readPreferredCamera3DMode(sharedPreferences);
        Editor editor = sharedPreferences.edit();
        String smileShotValue = sharedPreferences.getString(SettingConstants.KEY_SMILE_SHOT, "off");
        String hdrValue = sharedPreferences.getString(SettingConstants.KEY_HDR, "off");
        String asdValue = sharedPreferences.getString(SettingConstants.KEY_ASD, "off");
        String gestureValue = sharedPreferences.getString(SettingConstants.KEY_GESTURE_SHOT, "off");
        editor.clear();
        editor.apply();
        if (!isNonePickIntent) {
            // 3rd party launch back camera should not changed smile shot,
            // hdr, asd, gesture sharepereference value,
            // because they do not access to smile shot, hdr, asd, gesture.
            editor.putString(SettingConstants.KEY_SMILE_SHOT, smileShotValue);
            editor.putString(SettingConstants.KEY_HDR, hdrValue);
            editor.putString(SettingConstants.KEY_ASD, asdValue);
            editor.putString(SettingConstants.KEY_GESTURE_SHOT, gestureValue);
            editor.apply();
        }
        upgradeLocalPreferences(sharedPreferences);
        writePreferredCamera3DMode(sharedPreferences, current3DMode);
    }
    
    public static void upgradeGlobalPreferences(SharedPreferences pref, int numberOfCameras) {
        upgradeOldVersion(pref);
        upgradeCameraId(pref, numberOfCameras);
    }
    
    public static void upgradeLocalPreferences(SharedPreferences pref) {
        int version;
        try {
            version = pref.getInt(SettingConstants.KEY_LOCAL_VERSION, 0);
        } catch (Exception ex) {
            Log.w(TAG, "[upgradeLocalPreferences]Exception = " + ex);
            version = 0;
        }
        if (version == CURRENT_LOCAL_VERSION){
            Log.i(TAG, "[upgradeLocalPreferences]version = " + version);
            return;
        }
        SharedPreferences.Editor editor = pref.edit();
        if (version == 1) {
            // We use numbers to represent the quality now. The quality
            // definition is identical to
            // that of CamcorderProfile.java.
            editor.remove("pref_video_quality_key");
        }
        editor.putInt(SettingConstants.KEY_LOCAL_VERSION, CURRENT_LOCAL_VERSION);
        editor.apply();
    }
    
    public static int readPreferredCameraId(SharedPreferences pref) {
        return Integer.parseInt(pref.getString(SettingConstants.KEY_CAMERA_ID, "0"));
    }
    
    public static void resetCameraId(SharedPreferences pref) {
        writePreferredCameraId(pref, 0);
    }
    
    public static void writePreferredCameraId(SharedPreferences pref, int cameraId) {
        Editor editor = pref.edit();
        editor.putString(SettingConstants.KEY_CAMERA_ID, Integer.toString(cameraId));
        editor.apply();
    }
    
    public static String readPreferredCamera3DMode(SharedPreferences pref) {
        return pref.getString(SettingConstants.KEY_STEREO3D_MODE, STEREO3D_DISABLE);
    }
    
    public static void writePreferredCamera3DMode(SharedPreferences pref, String camera3DMode) {
        Editor editor = pref.edit();
        editor.putString(SettingConstants.KEY_STEREO3D_MODE, camera3DMode);
        editor.apply();
    }
    
    public static String readPreferredStereoCamera(SharedPreferences pref) {
        Log.i("Test", "readPreferredStereCamera " + pref.getString(SettingConstants.KEY_DUAL_CAMERA_MODE, STEREO_CAMERA_OFF));
        return pref.getString(SettingConstants.KEY_DUAL_CAMERA_MODE, STEREO_CAMERA_OFF);
    }
    
    public static void writePreferredStereoCamera(SharedPreferences pref,
            String stereoCamera) {
        Log.i(TAG, "writePreferredStereoCamera stereoCamera = " + stereoCamera);
        Editor editor = pref.edit();
        editor.putString(SettingConstants.KEY_DUAL_CAMERA_MODE, stereoCamera);
        editor.apply();
    }
    
    public static void updateSettingCaptureModePreferences(SharedPreferences pref) {
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SettingConstants.KEY_SMILE_SHOT, "off");
        editor.putString(SettingConstants.KEY_HDR, "off");
        editor.putString(SettingConstants.KEY_ASD, "off");
        editor.putString(SettingConstants.KEY_GESTURE_SHOT, "off");
        editor.putString(SettingConstants.KEY_SLOW_MOTION, "off");
        editor.apply();
    }
    
    public static void updateFaceDetectionPreferences(SharedPreferences pref) {
        SharedPreferences.Editor editor = pref.edit();
        // the value should be "on"
        // because first launch camera the value should be on
        editor.putString(SettingConstants.KEY_CAMERA_FACE_DETECT, "on");
        // editor.putString(KEY_FB_EXTREME_BEAUTY, "true");//[Need Check,Maybe
        // not need this]
        editor.putInt(KEY_INTO_VIDEO_FACE_BEAUTY_NORMAL, INTO_VIDEO_FACE_BEAUTY_NORMAL);
        editor.apply();
    }
    
    public static void setEnabledState(View view, boolean enabled) {
        if (view != null) {
            float alpha = enabled ? ALPHA_ENABLE : ALPHA_DISABLE;
            view.setAlpha(alpha);
        }
    }
    
    public static boolean isDisableValue(String value) {
        boolean reset = false;
        if (RESET_STATE_VALUE_DISABLE.equals(value)) {
            reset = true;
        }
        Log.d(TAG, "isResetValue(" + value + ") return " + reset);
        return reset;
    }
    
    public static String buildEnableList(String[] list, String current) {
        String listStr = null;
        if (list != null) {
            listStr = ENABLE_LIST_HEAD + current + ENABLE_LIST_SEPERATOR;
            List<String> uniqueList = new ArrayList<String>();
            for (int i = 0, len = list.length; i < len; i++) {
                if (uniqueList.contains(list[i])) {
                    continue;
                }
                uniqueList.add(list[i]);
                if (i == (len - 1)) {
                    listStr += list[i];
                } else {
                    listStr += (list[i] + ENABLE_LIST_SEPERATOR);
                }
            }
        }
        Log.d(TAG, "buildEnableList(" + current + ") return " + listStr);
        return listStr;
    }
    
    public static boolean isBuiltList(String listString) {
        boolean isList = false;
        if (listString != null && listString.startsWith(ENABLE_LIST_HEAD)) {
            isList = true;
        }
        Log.d(TAG, "isBuiltList(" + listString + ") return " + isList);
        return isList;
    }
    
    public static List<String> getEnabledList(String listString) {
        ArrayList<String> list = new ArrayList<String>();
        if (isBuiltList(listString)) {
            String[] temp = listString.split(ENABLE_LIST_SEPERATOR);
            for (int i = 2, len = temp.length; i < len; i++) {
                if (!list.contains(temp[i])) {
                    list.add(temp[i]);
                }
            }
        }
        Log.d(TAG, "getEnabledList(" + listString + ") return " + list);
        return list;
    }
    
    public static String getDefaultValue(String listString) {
        String value = null;
        if (isBuiltList(listString)) {
            String[] temp = listString.split(ENABLE_LIST_SEPERATOR);
            if (temp != null && temp.length > 1) {
                value = temp[1];
            }
        }
        Log.i(TAG, "getDefaultValue(" + listString + ") return " + value);
        return value;
    }
    
    public static boolean contains(int[] list, int value) {
        boolean find = false;
        if (list != null) {
            for (int i = 0, len = list.length; i < len; i++) {
                if (list[i] == value) {
                    find = true;
                    break;
                }
            }
        }
        Log.d(TAG, "contains(" + list + ", " + value + ") return " + find);
        return find;
    }
    
    public static boolean contains(String[] list, String value) {
        boolean find = false;
        if (list != null && value != null) {
            for (int i = 0, len = list.length; i < len; i++) {
                if (value.equals(list[i])) {
                    find = true;
                    break;
                }
            }
        }
        Log.d(TAG, "contains(" + list + ", " + value + ") return " + find);
        return find;
    }
    
    public static boolean contains(CharSequence[] list, String value) {
        boolean find = false;
        if (list != null && value != null) {
            for (int i = 0, len = list.length; i < len; i++) {
                if (value.equals(list[i])) {
                    find = true;
                    break;
                }
            }
        }
        Log.d(TAG, "contains(" + list + ", " + value + ") return " + find);
        return find;
    }
    
    public static int index(String[] list, String value) {
        int findIndex = UNKNOWN;
        if (list != null && value != null) {
            for (int i = 0, len = list.length; i < len; i++) {
                if (value.equals(list[i])) {
                    findIndex = i;
                    break;
                }
            }
        }
        Log.v(TAG, "index(" + list + ", " + value + ") return " + findIndex);
        return findIndex;
    }
    
    public static int index(CharSequence[] list, String value) {
        int findIndex = UNKNOWN;
        if (list != null && value != null) {
            for (int i = 0, len = list.length; i < len; i++) {
                if (value.equals(list[i])) {
                    findIndex = i;
                    break;
                }
            }
        }
        Log.d(TAG, "index(" + list + ", " + value + ") return " + findIndex);
        return findIndex;
    }
    
/*    public static int getMainColor(Context context) {
        // M: For 4.4 migration because resource remove interface
        // int themeColor = 0;
        int finalColor = 0;
        // if (FeatureSwitcher.isThemeEnabled()) {
        // Resources res = context.getResources();
        // themeColor = res.getThemeMainColor();
        // }
        // if (themeColor == 0) {
        finalColor = context.getResources().getColor(R.color.setting_item_text_color_highlight);
        // } else {
        // finalColor = themeColor;
        // }
        Log.d(TAG, "getMainColor" + finalColor);
        return finalColor;
    }*/
    
    private static void setPictureSizeToSharedPreference(Context context, int width, int height, 
            SharedPreferences sharedPreferences) {
        String findPictureSize = buildSize(width, height);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(SettingConstants.KEY_PICTURE_SIZE, findPictureSize);
        editor.apply();
    }
    
    private static boolean toleranceRatio(double target, double candidate) {
        boolean tolerance = true;
        if (candidate > 0) {
            tolerance = Math.abs(target - candidate) <= ASPECT_TOLERANCE;
        }
        Log.d(TAG, "toleranceRatio(" + target + ", " + candidate + ") return " + tolerance);
        return tolerance;
    }
    
    private static void upgradeOldVersion(SharedPreferences pref) {
        int version;
        try {
            version = pref.getInt(SettingConstants.KEY_VERSION, 0);
        } catch (Exception ex) {
            version = 0;
        }
        if (version == CURRENT_VERSION)
            return;
        
        SharedPreferences.Editor editor = pref.edit();
        if (version == 0) {
            // We won't use the preference which change in version 1.
            // So, just upgrade to version 1 directly
            version = 1;
        }
        if (version == 1) {
            // Change jpeg quality {65,75,85} to {normal,fine,superfine}
            String quality = pref.getString(SettingConstants.KEY_JPEG_QUALITY, "85");
            if (quality.equals("65")) {
                quality = "normal";
            } else if (quality.equals("75")) {
                quality = "fine";
            } else {
                quality = "superfine";
            }
            editor.putString(SettingConstants.KEY_JPEG_QUALITY, quality);
            version = 2;
        }
        if (version == 2) {
            editor.putString(SettingConstants.KEY_RECORD_LOCATION,
                    pref.getBoolean(SettingConstants.KEY_RECORD_LOCATION, false) ? RecordLocationPreference.VALUE_ON
                            : RecordLocationPreference.VALUE_NONE);
            version = 3;
        }
        if (version == 3) {
            // Just use video quality to replace it and
            // ignore the current settings.
            editor.remove("pref_camera_videoquality_key");
            editor.remove("pref_camera_video_duration_key");
        }
        
        editor.putInt(SettingConstants.KEY_VERSION, CURRENT_VERSION);
        editor.apply();
    }
    
    private static void upgradeCameraId(SharedPreferences pref, int numberOfCameras) {
        // The id stored in the preference may be out of range if we are running
        // inside the emulator and a webcam is removed.
        // Note: This method accesses the global preferences directly, not the
        // combo preferences.
        int cameraId = readPreferredCameraId(pref);
        if (cameraId == 0)
            return; // fast path
            
        if (cameraId < 0 || cameraId >= numberOfCameras) {
            writePreferredCameraId(pref, 0);
        }
    }
    
    private static void setPipPreviewFrameRate(ISettingCtrl iSettingCtrl, Parameters parameters, Parameters topParameters) {
        String zsdValue = iSettingCtrl.getSettingValue(SettingConstants.KEY_CAMERA_ZSD);
        List<Integer> pipFrameRates = null;
        List<Integer> pipTopFrameRates = null;
        if ("on".equals(zsdValue)) {
            pipFrameRates = parameters.getPIPFrameRateZSDOn();
            if (topParameters != null) {
                pipTopFrameRates = topParameters.getPIPFrameRateZSDOn();
            }
            Log.i(TAG, "getPIPFrameRateZSDOn pipFrameRates " + pipFrameRates
                    + " pipTopFrameRates = " + pipTopFrameRates);
        } else {
            pipFrameRates = parameters.getPIPFrameRateZSDOff();
            if (topParameters != null) {
                pipTopFrameRates = topParameters.getPIPFrameRateZSDOff();
            }
            Log.i(TAG, "getPIPFrameRateZSDOff pipFrameRates = " + pipFrameRates
                    + " pipTopFrameRates = " + pipTopFrameRates);
        }
        // close dynamic frame rate, if dynamic frame rate is supported
        closeDynamicFrameRate(parameters);
        closeDynamicFrameRate(topParameters);
        
        if (pipFrameRates != null) {
            Integer backFramerate = Collections.max(pipFrameRates);
            parameters.setPreviewFrameRate(backFramerate);
            
        }
        if (topParameters != null) {
            Integer frontFramerate = Collections.max(pipTopFrameRates);
            topParameters.setPreviewFrameRate(frontFramerate);
        }
    }
    
    private static void closeDynamicFrameRate(Parameters parameters) {
        if (parameters == null) {
            Log.i(TAG, "closeDynamicFrameRate but why parameters is null");
            return;
        }
        boolean support = parameters.isDynamicFrameRateSupported();
        if (support) {
            parameters.setDynamicFrameRate(false);
        }
        Log.i(TAG, "closeDynamicFrameRate support = " + support);
    }
}
