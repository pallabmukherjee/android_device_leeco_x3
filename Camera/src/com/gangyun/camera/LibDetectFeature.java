package com.gangyun.camera;

/* Vanzo:zhongjunyu on: Mon, 15 Sep 2014 20:00:33 +0800
 *  add for V gesture
 */
// End of Vanzo:zhongjunyu
public class LibDetectFeature {
    static {
        System.loadLibrary("DetectFeature");
    }

    public static native boolean DetectVGesture(int width, int height,
            byte[] yuv, int back_front, int degree, int face_flag);

    public static native int InitDetectCascadeFile(String CascadeFilePath);

}
