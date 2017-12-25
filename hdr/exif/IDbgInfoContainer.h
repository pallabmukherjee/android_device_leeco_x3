#ifndef _MTK_CAMERA_INCLUDE_COMMON_IDEBUGINFOCONTAINER_H_
#define _MTK_CAMERA_INCLUDE_COMMON_IDEBUGINFOCONTAINER_H_

/*******************************************************************************
*
********************************************************************************/
class IBaseCamExif;
/*******************************************************************************
*
********************************************************************************/
class IDbgInfoContainer
{
    public:

        static IDbgInfoContainer* createInstance();
        MVOID                     destroyInstance();

    protected:

        IDbgInfoContainer();
        virtual ~IDbgInfoContainer();

    public: //operations

        /* for user to query memory for a block */
        virtual MVOID*  queryMemory(MUINT32 const key, size_t const size, MBOOL clean = MTRUE) = 0;

        /* copy all blocks to the exif */
        virtual MBOOL   setToExif(IBaseCamExif* pExif) const                                   = 0;

        /* copy all blocks to another container */
        virtual MBOOL   copyTo(IDbgInfoContainer* pDbg) const                                  = 0;
    private:

};


/*******************************************************************************
*
********************************************************************************/

#endif  //_MTK_CAMERA_INCLUDE_COMMON_IDEBUGINFOCONTAINER_H_