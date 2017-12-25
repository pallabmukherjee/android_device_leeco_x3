#ifndef _MTK_CAMERA_INC_CAMSHOT_IBURSTSHOT_H_
#define _MTK_CAMERA_INC_CAMPIPE_IBURSTSHOT_H_

#include "../common.h"

#include "../featureio/aaa_hal_common.h"

/*******************************************************************************
*
********************************************************************************/
namespace NSCamShot {

/******************************************************************************
 * 
 ******************************************************************************/

/**  
 * @class IBurstShot
 * @brief Interface of BurstShot
 */
class IBurstShot : public ICamShot
{
public:

public:     ////    Instantiation.
    /**
     * @brief create the IBurstShot instance  
     *
     * @details 
     * 
     * @note 
     * 
     * @param[in] eShotMode: the shot mode of the caller 
     * @param[in] pszCamShotName: the shot name of the caller           
     *
     * @return
     * - The IBurstShot instance 
     */ 
    static IBurstShot* createInstance(EShotMode const eShotMode, char const* const pszCamShotName);

    /**
     * @brief set capture 3A params
     *
     * @details
     *
     * @note
     *
     * @param[in] pCapParams: the capture params array for 3A
     * @param[in] length: the length of array pCapParams
     *
     * @reutn boolean
     * - true/false
     */
    virtual MBOOL   registerCap3AParam(NS3A::CaptureParam_T* pCapParams, MUINT32 const length);
    
    /**
     * @brief set IspProfile
     *
     * @details
     *
     * @note
     *
     * @param[in] profile: IspProfile
     *
     * @reutn boolean
     * - true/false
     */
    virtual MBOOL   setIspProfile(NS3A::EIspProfile_T const profile);
}; 

}; //namespace NSCamShot
#endif  //  _MTK_CAMERA_INC_CAMSHOT_IBURSTSHOT_H_