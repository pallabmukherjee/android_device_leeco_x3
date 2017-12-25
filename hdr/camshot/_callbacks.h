#ifndef _MTK_CAMERA_INC_CAMSHOT_CALLBACKS_H_
#define _MTK_CAMERA_INC_CAMSHOT_CALLBACKS_H_

#include "../common.h"
using namespace NSCam;

/*******************************************************************************
*
********************************************************************************/
namespace NSCamShot {
////////////////////////////////////////////////////////////////////////////////


/**  
 * @struct CamShotNotifyInfo
 * @brief This structure is the camShot notify info 
 *
 */
struct CamShotNotifyInfo
{
    /**
      * @var msgType 
      * The notify message type of the camshot 
      */ 
    MUINT32     msgType;    
    /**
      * @var ext1 
      * The extended parameter 1.
      */     
    MUINT32     ext1;      
    /**
      * @var ext2 
      * The extended parameter 2.
      */     
    MUINT32     ext2;       
    //
    CamShotNotifyInfo(
        MUINT32 const _msgType = 0, 
        MUINT32 const _ext1 = 0, 
        MUINT32 const _ext2 = 0
    )
        : msgType(_msgType)
        , ext1(_ext1)
        , ext2(_ext2)
    {}
};

/**  
 * @typedef  CamShotNotifyCallback_t
 * @brief this is the prototype of camshot notify callback function pointer. 
 *
 */
typedef MBOOL   (*CamShotNotifyCallback_t)(MVOID* user, CamShotNotifyInfo const msg);


/**  
 * @struct CamShotDataInfo
 * @brief This structure is the camShot data info 
 *
 */
struct CamShotDataInfo
{
    /**
      * @var msgType 
      * The data message type of the camshot 
      */     
    MUINT32     msgType;    
    /**
      * @var ext1 
      * The extended parameter 1.
      */     
    MUINTPTR    ext1;       
    /**
      * @var ext2 
      * The extended parameter 2.
      */      
    MUINTPTR    ext2;       
    /**
      * @var pBuffer 
      * Pointer to the callback data.
      */      
    IImageBuffer*  pBuffer;    
    //
    CamShotDataInfo(
        MUINT32 const _msgType     = 0,
        MUINTPTR const _ext1       = 0,
        MUINTPTR const _ext2       = 0,
        IImageBuffer* const _pData = NULL
    )
        : msgType(_msgType)
        , ext1(_ext1)
        , ext2(_ext2)
        , pBuffer(_pData)
    {
    }
};

/**  
 * @typedef  CamShotDataCallback_t
 * @brief this is the prototype of camshot data callback function pointer. 
 *
 */
typedef MBOOL   (*CamShotDataCallback_t)(MVOID* user, CamShotDataInfo const msg);


/**  
 * @struct SImagerNotifyInfo
 * @brief This structure is the SImage notify info 
 *
 */
struct SImagerNotifyInfo
{
    /**
      * @var msgType 
      * The data message type of the SImager 
      */  
    MUINT32     msgType;  
    /**
      * @var ext1 
      * The extended parameter 1.
      */      
    MUINT32     ext1;     
    /**
      * @var ext2 
      * The extended parameter 2.
      */          
    MUINT32     ext2;    
    //
    SImagerNotifyInfo(
        MUINT32 const _msgType = 0, 
        MUINT32 const _ext1 = 0, 
        MUINT32 const _ext2 = 0
    )
        : msgType(_msgType)
        , ext1(_ext1)
        , ext2(_ext2)
    {}
};


/**  
 * @typedef  SImagerNotifyCallback_t
 * @brief this is the prototype of SImager notify callback function pointer. 
 *
 */
typedef MBOOL   (*SImagerNotifyCallback_t)(MVOID* user, SImagerNotifyInfo const msg);

////////////////////////////////////////////////////////////////////////////////
};  //namespace NSCamShot
#endif  //  _MTK_CAMERA_INC_CAMSHOT_CALLBACKS_H_