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

import android.hardware.Camera.Size;
import android.media.CameraProfile;
import android.text.TextUtils;

import com.mediatek.camera.platform.Parameters;
import com.mediatek.camera.util.Log;

import java.util.ArrayList;
import java.util.List;
/* Vanzo:zhongjunyu on: Mon, 09 Mar 2015 15:55:02 +0800
 * add gy v GestureShot
 */
import com.android.camera.FeatureSwitcher;
// End of Vanzo:zhongjunyu

public class ParametersHelper {
    private static final String TAG = "ParametersHelper";
    
    public static final String KEY_FACEBEAUTY_SMOOTH = "fb-smooth-level";
    public static final String KEY_FACEBEAUTY_SKIN_COLOR = "fb-skin-color";
    public static final String KEY_FACEBEAUTY_SHARP = "fb-sharp";
    public static final String KEY_FACEBEAUTY_SLIM = "fb-slim-face";
    public static final String KEY_FACEBEAUTY_BIG_EYES = "fb-enlarge-eye";
    public static final String KEY_HSVR_SIZE_FPS = "hsvr-size-fps-values";
    
    public static final String KEY_FB_EXTREME_BEAUTY = "fb-extreme-beauty";
    public static final String KEY_VIDED_FACE_BEAUTY_FACE = "fb-face-pos";
    public static final String KEY_VIDED_FACE_BEAUTY_TOUCH = "fb-touch-pos";
    
    public static final String KEY_MFB_AIS = "mfb";
    public static final String KEY_SLOW_MOTION = "slow-motion";
    public static final String KEY_3DNR_MODE = "3dnr-mode";
    // Special case for private key in android.hardware.Camera.
    // Here we defined it for supplying same behavior for get/set/isSupported.
    public static final String KEY_VIDEO_HDR = "video-hdr";
    public static final String KEY_RECORDING_HINT = "recording-hint";
    public static final String KEY_VIDEO_RECORIND_FEATURE_MAX_FPS = "feature-max-fps";
    public static final String KEY_VIDEO_STABLILIZATION = "video-stabilization";
    
    public static final String VIDEO_STABLILIZATION_ON = "true";
    public static final String THREE_DNR_MODE_ON = "on";
    
    private static final String SUPPORTED_VALUES_SUFFIX = "-values";
    private static final String MAX_SUFFIX = "-max";
    private static final String MIN_SUFFIX = "-min";
    
    private static final String KEY_DEPTH_AF_SUPPORTED = "stereo-depth-af-values";
    private static final String KEY_DISTANCE_INFO_SUPPORTED = "stereo-distance-measurement-values";
    private static final String KEY_GESTURE_SHOT_SUPPORTED = "gesture-shot-supported";
    
    /*
     * MR1 put HDR in scene mode. So, here we don't put it into user list. In
     * apply logic, HDR will set in scene mode and show auto scene to final
     * user. If scene mode not find in ListPreference, first one(auto) will be
     * choose. I don't think this is a good design.
     */
    public static final String KEY_SCENE_MODE_HDR = "hdr";
    // special scene mode for operator, like auto.
    public static final String KEY_SCENE_MODE_NORMAL = "normal";
    public static final String ZSD_MODE_ON = "on";
    public static final String ZSD_MODE_OFF = "off";
    //Used for VFB
    private static final String SINGLE_FACE_BEAUTY_MODE = "Single";
    private static final String MULITI_FACE_BEAUTY_MODE = "Multi";
    private static final String VIDEO_FACE_BEAUTY_ENABLE = "true";
    private static final String VIDEO_FACE_BEAUTY_DISABLE = "false";
    
    public static void setParametersValue(Parameters parameters, int cameraId, String key, String value) {
        int settingId = SettingConstants.getSettingId(key);
        Log.i(TAG, "[setParameters]key = " + key + ",value = " + value + ",settingIndex = "
                + settingId);
        if (value == null) {
            return;
        }
        switch (settingId) {
        case SettingConstants.ROW_SETTING_FLASH:// common
            parameters.setFlashMode(value);
            break;
        
        case SettingConstants.ROW_SETTING_DUAL_CAMERA:// common special case
            break;
        
        case SettingConstants.ROW_SETTING_EXPOSURE:// common
            int exposure = Integer.parseInt(value);
            parameters.setExposureCompensation(exposure);
            break;
        
        case SettingConstants.ROW_SETTING_SCENCE_MODE:// common
            if (!parameters.getSceneMode().equals(value)) {
                parameters.setSceneMode(value);
            }
            break;
        
        case SettingConstants.ROW_SETTING_WHITE_BALANCE:// common
            parameters.setWhiteBalance(value);
            break;
        
        case SettingConstants.ROW_SETTING_IMAGE_PROPERTIES:
            break;
        
        case SettingConstants.ROW_SETTING_DUAL_CAMERA_MODE:
            break;
        
        case SettingConstants.ROW_SETTING_HUE:// common
            parameters.setHueMode(value);
            break;
        
        case SettingConstants.ROW_SETTING_FAST_AF:// common
            boolean isDepthAfMode = "on".equals(value) ? true : false;
            parameters.setDepthAFMode(isDepthAfMode);
            break;
            
        case SettingConstants.ROW_SETTING_DISTANCE:// common
            boolean isDistanceMode = "on".equals(value) ? true : false;
            parameters.setDistanceMode(isDistanceMode);
            break;
        
        case SettingConstants.ROW_SETTING_AIS:
            parameters.set(KEY_MFB_AIS, value);
            break;
        
        case SettingConstants.ROW_SETTING_CONTRAST:// common
            parameters.setContrastMode(value);
            break;
        
        case SettingConstants.ROW_SETTING_SHARPNESS:// common
            parameters.setEdgeMode(value);
            break;
        
        case SettingConstants.ROW_SETTING_SATURATION:// common
            parameters.setSaturationMode(value);
            break;
        
        case SettingConstants.ROW_SETTING_BRIGHTNESS:// common
            parameters.setBrightnessMode(value);
            break;
        
        case SettingConstants.ROW_SETTING_COLOR_EFFECT:// common
            parameters.setColorEffect(value);
            break;
        
        case SettingConstants.ROW_SETTING_RECORD_LOCATION:// common app layer
            break;
        
        case SettingConstants.ROW_SETTING_ANTI_FLICKER:// common
            parameters.setAntibanding(value);
            break;
        
        case SettingConstants.ROW_SETTING_SELF_TIMER:// camera app layer
            break;
        
        case SettingConstants.ROW_SETTING_ZSD:// camera
            parameters.setZSDMode(value);
            break;
        
        case SettingConstants.ROW_SETTING_ISO:// camera
            parameters.setISOSpeed(value);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_PROPERTIES:// camera
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_SMOOTH:// camera
            parameters.set(KEY_FACEBEAUTY_SMOOTH, value);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_SKIN_COLOR:// camera
            parameters.set(KEY_FACEBEAUTY_SKIN_COLOR, value);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_SHARP:// camera
            parameters.set(KEY_FACEBEAUTY_SHARP, value);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_SLIM:// camera
            parameters.set(KEY_FACEBEAUTY_SLIM, value);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_BIG_EYES:// camera
            parameters.set(KEY_FACEBEAUTY_BIG_EYES, value);
            break;
        
        case SettingConstants.ROW_SETTING_VIDEO_STABLE:// video
            boolean toggle = "on".equals(value) ? true : false;
            parameters.setVideoStabilization(toggle);
            break;
        
        case SettingConstants.ROW_SETTING_3DNR:
            parameters.set(KEY_3DNR_MODE, value);
            break;
        
        case SettingConstants.ROW_SETTING_MICROPHONE:// video for media recorder
            break;
        
        case SettingConstants.ROW_SETTING_AUDIO_MODE:// video for media recorder
            break;
        
        case SettingConstants.ROW_SETTING_TIME_LAPSE:// video should be
                                                     // rechecked
            break;
        
        case SettingConstants.ROW_SETTING_VIDEO_QUALITY:// video
            break;
        
        case SettingConstants.ROW_SETTING_SLOW_MOTION_VIDEO_QUALITY:// video
            break;
        
        case SettingConstants.ROW_SETTING_RECORDING_HINT:// plus for recroding
                                                         // hint
            parameters.setRecordingHint(Boolean.parseBoolean(value));
            break;
        
        case SettingConstants.ROW_SETTING_CAPTURE_MODE:
            parameters.setCaptureMode(value);
            break;
        
        case SettingConstants.ROW_SETTING_CONTINUOUS_NUM:
            int number = Integer.parseInt(value);
            parameters.setBurstShotNum(number);
            break;
        
        case SettingConstants.ROW_SETTING_SLOW_MOTION:
            parameters.set(ParametersHelper.KEY_SLOW_MOTION, value);
            break;
        
        case SettingConstants.ROW_SETTING_JPEG_QUALITY:
            int jpegQuality = CameraProfile.getJpegEncodingQualityParameter(
                    cameraId, Integer.parseInt(value));
            parameters.setJpegQuality(jpegQuality);
            break;
        
        case SettingConstants.ROW_SETTING_CAMERA_MODE:
            parameters.setCameraMode(Integer.parseInt(value));
            break;
        
        case SettingConstants.ROW_SETTING_PICTURE_SIZE:
            int index = value.indexOf('x');
            if (index == -1) {
                Log.w(TAG, "[setParameters]index = -1,return!");
                return;
            }
            int width = Integer.parseInt(value.substring(0, index));
            int height = Integer.parseInt(value.substring(index + 1));
            parameters.setPictureSize(width, height);
            break;
        
        case SettingConstants.ROW_SETTING_PICTURE_RATIO:
            break;
        
        case SettingConstants.ROW_SETTING_VOICE:
            break;
        
        case SettingConstants.ROW_SETTING_HDR:
            if (isParametersSupported(parameters, key, value)) {
                parameters.set(KEY_VIDEO_HDR, value);
            }    
            break;
        
        case SettingConstants.ROW_SETTING_CAMERA_FACE_DETECT:
            break;
        
        case SettingConstants.ROW_SETTING_MULTI_FACE_MODE:
            if (value != null) {
                String paramtersValue = null;
                if (value != null && SINGLE_FACE_BEAUTY_MODE.equals(value) ) {
                    paramtersValue = VIDEO_FACE_BEAUTY_ENABLE;
                } else if (MULITI_FACE_BEAUTY_MODE.equals(value)) {
                     paramtersValue = VIDEO_FACE_BEAUTY_DISABLE;
                }
                //because if user set the face beauty is off,
                //so the value not need set to native
                if (paramtersValue != null) {
                    parameters.set(KEY_FB_EXTREME_BEAUTY, paramtersValue);
                }
            }
            break;
            
        case SettingConstants.ROW_SETTING_MUTE_RECORDING_SOUND:
            parameters.enableRecordingSound(value);
            break;
        
        case SettingConstants.ROW_SETTING_HEARTBEAT_MONITOR:
            if (isHeartbeatMonitorSupported(parameters)) {
                parameters.set("mtk-heartbeat-monitor", value);
            }
            break;
        
        default:
            Log.e(TAG, "[setParametersValue]key value is wrong, key:" + key);
            break;
        }
    }
    
    public static String getParametersValue(Parameters parameters, String key) {
        int settingId = SettingConstants.getSettingId(key);
        String value = null;
        switch (settingId) {
        case SettingConstants.ROW_SETTING_FLASH:// common
            value = parameters.getFlashMode();
            break;
        
        case SettingConstants.ROW_SETTING_DUAL_CAMERA:// common special case
            break;
        
        case SettingConstants.ROW_SETTING_EXPOSURE:// common
            value = String.valueOf(parameters.getExposureCompensation());
            break;
        
        case SettingConstants.ROW_SETTING_SCENCE_MODE:// common
            value = parameters.getSceneMode();
            break;
        
        case SettingConstants.ROW_SETTING_WHITE_BALANCE:// common
            value = parameters.getWhiteBalance();
            break;
        
        case SettingConstants.ROW_SETTING_IMAGE_PROPERTIES:
            break;
        
        case SettingConstants.ROW_SETTING_DUAL_CAMERA_MODE:
            break;
        
        case SettingConstants.ROW_SETTING_HUE:// common
            value = parameters.getHueMode();
            break;
        
        case SettingConstants.ROW_SETTING_FAST_AF:// common
            value = parameters.getDepthAFMode();
            break;
        
        case SettingConstants.ROW_SETTING_DISTANCE:// common
            value = parameters.getDistanceMode();
            break;
        
        case SettingConstants.ROW_SETTING_AIS:
            value = parameters.get(ParametersHelper.KEY_MFB_AIS);
            break;
        
        case SettingConstants.ROW_SETTING_CONTRAST:// common
            value = parameters.getContrastMode();
            break;
        
        case SettingConstants.ROW_SETTING_SHARPNESS:// common
            value = parameters.getEdgeMode();
            break;
        
        case SettingConstants.ROW_SETTING_SATURATION:// common
            value = parameters.getSaturationMode();
            break;
        
        case SettingConstants.ROW_SETTING_BRIGHTNESS:// common
            value = parameters.getBrightnessMode();
            break;
        
        case SettingConstants.ROW_SETTING_COLOR_EFFECT:// common
            value = parameters.getColorEffect();
            break;
        
        case SettingConstants.ROW_SETTING_RECORD_LOCATION:// common app layer
            break;
        
        case SettingConstants.ROW_SETTING_ANTI_FLICKER:// common
            value = parameters.getAntibanding();
            break;
        
        case SettingConstants.ROW_SETTING_SELF_TIMER:// camera app layer
            break;
        
        case SettingConstants.ROW_SETTING_ZSD:// camera
            value = parameters.getZSDMode();
            break;

        case SettingConstants.ROW_SETTING_ISO:// camera
            value = parameters.getISOSpeed();
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_PROPERTIES:// camera
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_SMOOTH:// camera
            value = parameters.get(KEY_FACEBEAUTY_SMOOTH);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_SKIN_COLOR:// camera
            value = parameters.get(KEY_FACEBEAUTY_SKIN_COLOR);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_SHARP:// camera
            value = parameters.get(KEY_FACEBEAUTY_SHARP);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_SLIM:// camera
            value = parameters.get(KEY_FACEBEAUTY_SLIM);
            break;
        
        case SettingConstants.ROW_SETTING_FACEBEAUTY_BIG_EYES:// camera
            value = parameters.get(KEY_FACEBEAUTY_BIG_EYES);
            break;
        
        case SettingConstants.ROW_SETTING_VIDEO_STABLE:// video
            value = String.valueOf(parameters.getVideoStabilization());
            break;
        
        case SettingConstants.ROW_SETTING_3DNR:
            value = parameters.get(KEY_3DNR_MODE);
            break;
        
        case SettingConstants.ROW_SETTING_MICROPHONE:// video for media recorder
            break;
        
        case SettingConstants.ROW_SETTING_AUDIO_MODE:// video for media recorder
            break;
        
        case SettingConstants.ROW_SETTING_TIME_LAPSE:// video should be
                                                     // rechecked
            break;
        
        case SettingConstants.ROW_SETTING_VIDEO_QUALITY:// video
            break;
        
        case SettingConstants.ROW_SETTING_SLOW_MOTION_VIDEO_QUALITY:// video
            break;
        
        case SettingConstants.ROW_SETTING_CAPTURE_MODE:
            value = parameters.getCaptureMode();
            break;
        
        case SettingConstants.ROW_SETTING_CONTINUOUS_NUM:
            value = parameters.get("burst-num");
            break;
        
        case SettingConstants.ROW_SETTING_SLOW_MOTION:
            value = parameters.get(KEY_SLOW_MOTION);
            Log.i(TAG, "parameters.set/value = " + value);
            break;
        
        case SettingConstants.ROW_SETTING_JPEG_QUALITY:
            value = String.valueOf(parameters.getJpegQuality());
            break;
        
        case SettingConstants.ROW_SETTING_CAMERA_MODE:
            break;
        
        case SettingConstants.ROW_SETTING_PICTURE_SIZE:
            Size size = parameters.getPictureSize();
            value = size.width + "x" + size.height;
            break;
        
        case SettingConstants.ROW_SETTING_PICTURE_RATIO:
            break;
        
        case SettingConstants.ROW_SETTING_VOICE:
            break;
        
        case SettingConstants.ROW_SETTING_HDR:
            value = parameters.get(KEY_VIDEO_HDR);
            break;
        
        case SettingConstants.ROW_SETTING_CAMERA_FACE_DETECT:
            break;
        
        case SettingConstants.ROW_SETTING_MULTI_FACE_MODE:
            if (value != null) {
                value = parameters.get(KEY_FB_EXTREME_BEAUTY);
            }
            break;
            
        case SettingConstants.ROW_SETTING_MUTE_RECORDING_SOUND:
            break;
        
        default:
            Log.e(TAG, "[getParametersValue]key value is wrong, key:" + key);
            break;
        }
        
        return value;
    }
    
    public static boolean isParametersSupported(Parameters parameters, String key, String value) {
        int settingId = SettingConstants.getSettingId(key);
        boolean isSupported = false;
        List<String> supported = null;
        switch (settingId) { 
        case SettingConstants.ROW_SETTING_HDR:
            supported = getParametersSupportedValues(parameters, key);
            break;
        default:
            break;
        }
        
        if (supported != null && supported.contains(value)) {
            isSupported = true;
        }
        
        return isSupported;
    }
    
    /**
     * Get supported string from parameter.
     * 
     * @param parameters
     * @param key
     *            constant from SettingConstants class
     * @return supported string list
     */
    public static List<String> getParametersSupportedValues(Parameters parameters, String key) {
        int settingId = SettingConstants.getSettingId(key);
        List<String> supportedList = null;
        Log.d(TAG, "[getSupportedList]settingId = " + settingId);
        switch (settingId) {
        case SettingConstants.ROW_SETTING_FLASH:
            supportedList = parameters.getSupportedFlashModes();
            break;
        
        case SettingConstants.ROW_SETTING_SCENCE_MODE:
            supportedList = parameters.getSupportedSceneModes();
            break;
        
        case SettingConstants.ROW_SETTING_WHITE_BALANCE:// common
            supportedList = parameters.getSupportedWhiteBalance();
            break;
        
        case SettingConstants.ROW_SETTING_SHARPNESS:// common
            supportedList = parameters.getSupportedEdgeMode();
            break;
        
        case SettingConstants.ROW_SETTING_HUE:// common
            supportedList = parameters.getSupportedHueMode();
            break;
        
        case SettingConstants.ROW_SETTING_SATURATION:// common
            supportedList = parameters.getSupportedSaturationMode();
            break;
        
        case SettingConstants.ROW_SETTING_BRIGHTNESS:// common
            supportedList = parameters.getSupportedBrightnessMode();
            break;
        
        case SettingConstants.ROW_SETTING_CONTRAST:// common
            supportedList = parameters.getSupportedContrastMode();
            break;
        
        case SettingConstants.ROW_SETTING_COLOR_EFFECT:// common
            supportedList = parameters.getSupportedColorEffects();
            break;
        
        case SettingConstants.ROW_SETTING_ANTI_FLICKER:// common
            supportedList = parameters.getSupportedAntibanding();
            break;
        
        case SettingConstants.ROW_SETTING_ZSD:// camera
            supportedList = parameters.getSupportedZSDMode();
            break;
        
        case SettingConstants.ROW_SETTING_ISO:// camera
            supportedList = parameters.getSupportedISOSpeed();
            break;
        
        case SettingConstants.ROW_SETTING_CAPTURE_MODE:
            supportedList = parameters.getSupportedCaptureMode();
            break;
        
        case SettingConstants.ROW_SETTING_AIS:
            supportedList = getSupportedValues(parameters, KEY_MFB_AIS);
            break;
        
        case SettingConstants.ROW_SETTING_SLOW_MOTION:
            supportedList = getSupportedValues(parameters, KEY_SLOW_MOTION);
            break;
        
        case SettingConstants.ROW_SETTING_HDR:
            supportedList = getSupportedValues(parameters, KEY_VIDEO_HDR);
            break;
        
        case SettingConstants.ROW_SETTING_3DNR:
            supportedList = getSupportedValues(parameters, KEY_3DNR_MODE);
            break;
        
        default:
            Log.e(TAG, "key value is wrong, key:" + key);
            break;
        }
        
        return supportedList;
    }
    
    public static boolean isCfbSupported(Parameters parameters) {
        if (parameters != null) {
            List<String> supported = parameters.getSupportedCaptureMode();
            boolean isSupport = supported.indexOf(Parameters.CAPTURE_MODE_FB) >= 0
                    && isSupporteFBProperties(parameters, KEY_FACEBEAUTY_SMOOTH);
            Log.d(TAG, "[isCfbSupported] isSupport = " + isSupport);
            return isSupport;
        } else {
            throw new RuntimeException("(ParametersHelper)why parameters is null?");
        }
    }
    
    public static void setFbPropertiesParameters(Parameters parameters, String key, String value) {
        parameters.set(key, value);
    }
    
    public static int getCurrentValue(Parameters parameters, String key) {
        return getInt(parameters, key);
    }
    
    public static boolean isSupporteFBProperties(Parameters parameters, String key) {
        int max = getMaxLevel(parameters, key);
        int min = getMinLevel(parameters, key);
        Log.d(TAG, "[isSupporteFBProperties]max = " + max +",min = " + min);
        return max != 0 && min != 0;
    }
    
    

    public static boolean isDepthAfSupported(Parameters parameters) {
        if (parameters == null) {
            return false;
        }
        String str = parameters.get(KEY_DEPTH_AF_SUPPORTED);
        Log.i(TAG, "isDepthAfSupported " + str);
        if ("off".equals(str) || null == str) {
            return false;
        } else {
            return true;
        }
    }
    
    public static boolean isDistanceInfoSuppported(Parameters parameters) {
        if (parameters == null) {
            return false;
        }
        String str = parameters.get(KEY_DISTANCE_INFO_SUPPORTED);
        Log.i(TAG, "isDistanceInfoSuppported " + str);
        if ("off".equals(str) || null == str) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean isGestureShotSupported(Parameters parameters) {
        if (parameters == null) {
            Log.e(TAG, "[isGestureShotSupported], parameters is null");
            return false;
        }
        
/* Vanzo:zhongjunyu on: Sat, 07 Mar 2015 17:29:11 +0800
 * add gy v GestureShot
 */
        if (FeatureSwitcher.isSupportGYVGestureShot()) {
            return true;
        }
// End of Vanzo:songlixin
        String str = parameters.get(KEY_GESTURE_SHOT_SUPPORTED);
        boolean isSupported = Boolean.parseBoolean(str);
        Log.i(TAG, "[isGestureShotSupported], isSupported:" + isSupported);
        return isSupported;
    }
    
    public static boolean isHeartbeatMonitorSupported(Parameters parameters) {
        if (parameters == null) {
            return false;
        }
        
        String str = parameters.get("mtk-heartbeat-monitor-supported");
        boolean isSupported = false;
        if (str != null && Boolean.valueOf(str)) {
            isSupported = true;
        } 
        Log.i(TAG, "[isHeartbeatMonitorSupported], isSupported:" + isSupported);
        return isSupported;
    }
    
    
    public static int getMaxLevel(Parameters parameters, String key) {
        return getInt(parameters, key + MAX_SUFFIX);
    }
    
    public static int getMinLevel(Parameters parameters, String key) {
        return getInt(parameters, key + MIN_SUFFIX);
    }
    
    // Returns the value of a integer parameter.
    private static int getInt(Parameters parameters, String key) {
        int defaultValue = 0;
        if (parameters != null) {
            try {
                defaultValue = Integer.parseInt(parameters.get(key));
            } catch (NumberFormatException ex) {
                
            }
        } 
        Log.i(TAG, "[getInt]key = " + key +",defaultValue = " + defaultValue);
        return defaultValue;
    }
    
    // Copied from android.hardware.Camera
    // Splits a comma delimited string to an ArrayList of String.
    // Return null if the passing string is null or the size is 0.
    public static ArrayList<String> split(String str) {
        ArrayList<String> substrings = null;
        if (str != null) {
            TextUtils.StringSplitter splitter = new TextUtils.SimpleStringSplitter(',');
            splitter.setString(str);
            substrings = new ArrayList<String>();
            for (String s : splitter) {
                substrings.add(s);
            }
        }
        
        return substrings;
    }
    
    private static List<String> getSupportedValues(Parameters parameters, String key) {
        List<String> supportedList = null;
        if (parameters != null) {
            String str = parameters.get(key + SUPPORTED_VALUES_SUFFIX);
            supportedList = split(str);
        }
        
        return supportedList;
    }
}
