#ifndef _MTK_CAMERA_INC_COMMON_CAMEXIF_IBASECAMEXIF_H_
#define _MTK_CAMERA_INC_COMMON_CAMEXIF_IBASECAMEXIF_H_

#include "BuiltinTypes.h"

/*******************************************************************************
*
********************************************************************************/
#define DBG_EXIF_SIZE       (0xFFFF * 4)
#define REFOCUS_EXIF_SIZE   (0xFFFF * 5)    // for Image Refocus jpeg
#define STEREO_EXIF_SIZE    (0xFFFF * 8)    // for JPS

/*******************************************************************************
* Camera EXIF Command
********************************************************************************/
typedef enum DEBUG_EXIF_CMD_S {

    CMD_REGISTER            = 0x1001,
    CMD_SET_DBG_EXIF

} DEBUG_EXIF_CMD_E;


/*******************************************************************************
* 3A EXIF Information
********************************************************************************/
struct EXIF_INFO_T
{
public:     ////    Data member.
    MUINT32 u4FNumber;          // Format: F2.8 = 28
    MUINT32 u4FocalLength;      // Format: FL 3.5 = 350
    MUINT32 u4SceneMode;        // Scene mode   (SCENE_MODE_XXX)
    MUINT32 u4AWBMode;          // White balance mode   (AWB_NODE_XXX)
    MUINT32 u4FlashLightTimeus; // Strobe on/off
    MUINT32 u4AEMeterMode;      // Exposure metering mode   (AE_METERING_MODE_XXX)
    MINT32  i4AEExpBias;        // Exposure index*10
    MUINT32 u4CapExposureTime;  // 
    MUINT32 u4AEISOSpeed;       //
    MUINT32 u4RealISOValue;     //

public:     ////    Operations.
    EXIF_INFO_T()  { ::memset(this, 0, sizeof(EXIF_INFO_T)); }

};


/*******************************************************************************
* (Basic) Camera Exif
********************************************************************************/
class IBaseCamExif
{
public:     ////    Interfaces.

    IBaseCamExif() {}; 
    virtual ~IBaseCamExif() {}; 

//=============================================================
//  Interfaces.
//=============================================================

    /*******************************************************************************
    *  set 3A-related EXIF values for CamExif
    *******************************************************************************/
    virtual
    MBOOL
    set3AEXIFInfo(EXIF_INFO_T* p3AEXIFInfo)   = 0;

    /*******************************************************************************
    *  sendCommand
    *******************************************************************************/
    virtual
    MBOOL sendCommand(
                MINT32      cmd,
                MINT32      arg1 = 0,
                MUINTPTR    arg2 = 0,
                MINT32      arg3 = 0)   = 0;


};


#endif  //  _MTK_CAMERA_INC_COMMON_CAMEXIF_IBASECAMEXIF_H_