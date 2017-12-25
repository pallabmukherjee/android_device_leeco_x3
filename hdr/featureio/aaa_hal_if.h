#ifndef _AAA_HAL_IF_H_
#define _AAA_HAL_IF_H_

#include "../common.h"
#include "aaa_hal_common.h"
#include "../exif/IDbgInfoContainer.h"

#include <utils/threads.h>
#include <utils/List.h>

using namespace NSCam;
using namespace android;

class IBaseCamExif;

namespace NS3A
{
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class Hal3AIf {

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
protected:  //    Ctor/Dtor.
    Hal3AIf() {}
    virtual ~Hal3AIf() {}

private: // disable copy constructor and copy assignment operator
    Hal3AIf(const Hal3AIf&);
    Hal3AIf& operator=(const Hal3AIf&);

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Interfaces.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
public:
    //
    static Hal3AIf* createInstance(MINT32 const i4SensorOpenIndex);
    virtual MVOID destroyInstance() {}
    virtual MBOOL sendCommand(ECmd_T const eCmd, MINTPTR const i4Arg = 0) {return MTRUE;}
    virtual MINT32 getErrorCode() const {return 0;}
    virtual MBOOL getParams(Param_T &rParam) const {return MTRUE;}
    virtual MBOOL setParams(Param_T const &rNewParam) {return MTRUE;}
    virtual MINT32 getResult(MUINT32 u4FrmId, Result_T& rResult) const {return 0;}
    virtual MBOOL getSupportedParams(FeatureParam_T &rFeatureParam) {return MTRUE;}
    virtual MBOOL isReadyToCapture() const {return MTRUE;}
    virtual MBOOL autoFocus() {return MTRUE;}
    virtual MBOOL cancelAutoFocus() {return MTRUE;}
    virtual MBOOL setZoom(MUINT32 u4ZoomRatio_x100, MUINT32 u4XOffset, MUINT32 u4YOffset, MUINT32 u4Width, MUINT32 u4Height) {return MTRUE;}
    virtual MBOOL set3AEXIFInfo(IBaseCamExif *pIBaseCamExif) const {return MTRUE;}
    virtual MBOOL setDebugInfo(IDbgInfoContainer* pDbgInfoCtnr, MBOOL const fgReadFromHW) const {return MTRUE;}
    virtual MINT32 getDelayFrame(EQueryType_T const eQueryType) const {return 0;}
    /**
     * @brief add callbacks for 3A HAL, return number of cb in 3A HAL
     */
    virtual MINT32 addCallbacks(I3ACallBack* cb) {return 0;}
    /**
     * @brief remove callbacks in 3A HAL, return number of cb in 3A HAL
     */
    virtual MINT32 removeCallbacks(I3ACallBack* cb) {return 0;}

    virtual MBOOL setIspProfile(const ParamIspProfile_T& rParamIspProfile, IDbgInfoContainer* pDbgInfoCtnr) {return MTRUE;}
    virtual MINT32 getExposureInfo(ExpSettingParam_T &strHDRInputSetting) {return 0;}
    virtual MINT32 getCaptureParams(CaptureParam_T &a_rCaptureInfo) {return 0;}
    virtual MINT32 updateCaptureParams(CaptureParam_T &a_rCaptureInfo) {return 0;}
    virtual MINT32 getHDRCapInfo(Hal3A_HDROutputParam_T &a_strHDROutputInfo) {return 0;}
    virtual MBOOL setFDInfo(MVOID* a_sFaces) {return MTRUE;}
    virtual MBOOL setOTInfo(MVOID* a_sOT) {return MTRUE;}
    virtual MINT32 getRTParams(FrameOutputParam_T &a_strFrameOutputInfo) {return 0;}
    virtual MINT32 isNeedFiringFlash(MBOOL bEnCal) {return 0;}
    virtual MBOOL getASDInfo(ASDInfo_T &a_rASDInfo) {return MTRUE;}
    virtual MINT32 modifyPlineTableLimitation(MBOOL bEnable, MBOOL bEquivalent, MUINT32 u4IncreaseISO_x100, MUINT32 u4IncreaseShutter_x100) {return 0;}
    virtual MBOOL getLCEInfo(LCEInfo_T &a_rLCEInfo) {return MTRUE;}
    virtual MVOID endContinuousShotJobs() {}
    virtual MVOID enterCaptureProcess() {}
    virtual MVOID exitCaptureProcess() {}
    virtual MUINT32 queryFramesPerCycle(MUINT32 fps) {return 1;}
    virtual MINT32 enableAELimiterControl(MBOOL  bIsAELimiter) {return 0;}
    virtual MVOID setFDEnable(MBOOL bEnable) {}
    virtual MVOID setSensorMode(MINT32 i4SensorMode) {}
    virtual MVOID set3APreviewMode(E3APreviewMode_T PvMode) {}
    virtual MINT32 SetAETargetMode(MUINT32 AeTargetMode) { return 0; }
    virtual MVOID setFrameId(MINT32 i4FrmId) {}
    MINT32 getFrameId() const {return 0;}

    virtual MINT32 send3ACtrl(E3ACtrl_T e3ACtrl, MINTPTR iArg1, MINTPTR iArg2) {return 0;}
};

class CallBackSet : public I3ACallBack
{
public:
    CallBackSet();
    virtual             ~CallBackSet();

    virtual void        doNotifyCb (
                           int32_t _msgType,
                           int32_t _ext1,
                           int32_t _ext2,
                           int32_t _ext3
                        );

    virtual void        doDataCb (
                           int32_t _msgType,
                           void*   _data,
                           uint32_t _size
                        );

    virtual MINT32      addCallback(I3ACallBack* cb);
    virtual MINT32      removeCallback(I3ACallBack* cb);
private:
    List<I3ACallBack*>  m_CallBacks;
    Mutex               m_Mutex;
};

}; // namespace NS3A

#endif