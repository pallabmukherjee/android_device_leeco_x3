

#ifndef _MTK_HARDWARE_INCLUDE_MTKCAM_UTILS_BASEIMAGEBUFFERHEAP_H_
#define _MTK_HARDWARE_INCLUDE_MTKCAM_UTILS_BASEIMAGEBUFFERHEAP_H_
//
#include <utils/RefBase.h>
#include <utils/Mutex.h>
#include <utils/Vector.h>
#include <utils/String8.h>
#include "../../isp/IImageBuffer.h"


/******************************************************************************
 *
 ******************************************************************************/
namespace NSCam {
class IHalMemory;
namespace NSImageBufferHeap {
using namespace android;


/******************************************************************************
 *  Image Buffer Heap (Base).
 ******************************************************************************/
class BaseImageBufferHeap : public virtual IImageBufferHeap, protected virtual RefBase
{
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  IImageBufferHeap Interface.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
public:     ////                    Reference Counting.
    virtual MVOID                   incStrong(MVOID const* id)          const   { RefBase::incStrong(id); }
    virtual MVOID                   decStrong(MVOID const* id)          const   { RefBase::decStrong(id); }
    virtual MINT32                  getStrongCount()                    const   { return RefBase::getStrongCount(); }

public:     ////                    Image Attributes.
    virtual MINT                    getImgFormat()                      const   { return mImgFormat; }
    virtual MSize const&            getImgSize()                        const   { return mImgSize; }
    virtual size_t                  getImgBitsPerPixel()                const;
    virtual size_t                  getPlaneBitsPerPixel(size_t index)  const;
    virtual size_t                  getPlaneCount()                     const   { return mPlaneCount; }
    virtual size_t                  getBitstreamSize()                  const   { return mBitstreamSize; }

public:     ////                    Buffer Attributes.
    virtual MBOOL                   getLogCond()                        const   { return mEnableLog; }
    virtual char const*             getMagicName()                      const   { return impGetMagicName(); }
    virtual MINT32                  getHeapID(size_t index)             const;
    virtual size_t                  getHeapIDCount()                    const;
    virtual MINTPTR                 getBufPA(size_t index)              const;
    virtual MINTPTR                 getBufVA(size_t index)              const;
    virtual size_t                  getBufSizeInBytes(size_t index)     const;
    virtual size_t                  getBufStridesInBytes(size_t index)  const;
    virtual void*                   getGraphicBuffer()                  const    { return NULL; };

public:     ////                    Buffer Operations.
    virtual MBOOL                   lockBuf(
                                        char const* szCallerName,
                                        MINT usage
                                    );
    virtual MBOOL                   unlockBuf(
                                        char const* szCallerName
                                    );
    virtual MBOOL                   syncCache(eCacheCtrl const ctrl);

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  IImageBuffer Operations.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
public:     ////

    /**
     * Create an IImageBuffer instance with its ROI equal to the image full
     * resolution of this heap.
     */
    virtual IImageBuffer*           createImageBuffer();

    /**
     * This call is legal only if the heap format is blob.
     *
     * From the given blob heap, create an IImageBuffer instance with a specified
     * offset and size, and its format equal to blob.
     */
    virtual IImageBuffer*           createImageBuffer_FromBlobHeap(
                                        size_t      offsetInBytes,
                                        size_t      sizeInBytes
                                    );

    /**
     * This call is legal only if the heap format is blob.
     *
     * From the given blob heap, create an IImageBuffer instance with a specified
     * offset, image format, image size in pixels, and buffer strides in pixels.
     */
    virtual IImageBuffer*           createImageBuffer_FromBlobHeap(
                                        size_t      offsetInBytes,
                                        MINT32      imgFormat,
                                        MSize const&imgSize,
                                        size_t const bufStridesInBytes[3]
                                    );

    /**
     * Create an IImageBuffer instance indicating the left-side or right-side
     * buffer within a side-by-side image.
     *
     * Left side if isRightSide = 0; otherwise right side.
     */
    virtual IImageBuffer*           createImageBuffer_SideBySide(
                                        MBOOL       isRightSide
                                    );


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Definitions.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
protected:  ////                    Heap Info.
                                    struct HeapInfo : public LightRefBase<HeapInfo>
                                    {
                                    MINT32      heapID;             // heap ID.
                                                //
                                                HeapInfo()
                                                    : heapID(-1)
                                                {
                                                }
                                    };
    typedef Vector<sp<HeapInfo> >   HeapInfoVect_t;

public:  ////                    Buffer Info.
                                    struct BufInfo : public LightRefBase<BufInfo>
                                    {
                                    MINTPTR     pa;                 // (plane) physical address
                                    MINTPTR     va;                 // (plane) virtual address
                                    size_t      stridesInBytes;     // (plane) strides in bytes
                                    size_t      sizeInBytes;        // (plane) size in bytes
                                                //
                                                BufInfo(
                                                    MINTPTR         _pa = 0,
                                                    MINTPTR         _va = 0,
                                                    size_t          _stridesInBytes = 0,
                                                    size_t          _sizeInBytes = 0
                                                )
                                                    : pa(_pa)
                                                    , va(_va)
                                                    , stridesInBytes(_stridesInBytes)
                                                    , sizeInBytes(_sizeInBytes)
                                                {
                                                }
                                    };
    typedef Vector<sp<BufInfo> >    BufInfoVect_t;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Template-Method Pattern. Subclass must implement them.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
protected:  ////
    /**
     * Return a pointer to a null-terminated string to indicate a magic name of
     * buffer type.
     */
    virtual char const*             impGetMagicName()                   const   = 0;

    /**
     * This call is valid after calling impLockBuf();
     * invalid after impUnlockBuf().
     */
    virtual HeapInfoVect_t const&   impGetHeapInfo()                    const   = 0;

    /**
     * onCreate() must be invoked by a subclass when its instance is created to
     * inform this base class of a creating event.
     * The call impInit(), implemented by a subclass, will be invoked by this
     * base class during onCreate() for initialization.
     * As to buffer information (i.e. BufInfoVect_t), buffer strides in pixels
     * and buffer size in bytes of each plane as well as the vector size MUST be
     * legal, at least, after impInit() return success.
     *
     * onLastStrongRef() will be invoked to indicate the last one reference to
     * this instance before it is freed.
     * The call impUninit(), implemented by a subclass, will be invoked by this
     * base class during onLastStrongRef() for uninitialization.
     */
    virtual MBOOL                   impInit(BufInfoVect_t const& rvBufInfo)     = 0;
    virtual MBOOL                   impUninit(BufInfoVect_t const& rvBufInfo)   = 0;

public:     ////
    /**
     * As to buffer information (i.e. BufInfoVect_t), buffer strides in bytes
     * and buffer size in bytes of each plane as well as the vector size MUST be
     * always legal.
     *
     * After calling impLockBuf() successfully, the heap information from
     * impGetHeapInfo() must be legal; virtual address and physical address of
     * each plane must be legal if any SW usage and any HW usage are specified,
     * respectively.
     */
    virtual MBOOL                   impLockBuf(
                                        char const* szCallerName,
                                        MINT usage,
                                        BufInfoVect_t const& rvBufInfo
                                    )                                           = 0;
    virtual MBOOL                   impUnlockBuf(
                                        char const* szCallerName,
                                        MINT usage,
                                        BufInfoVect_t const& rvBufInfo
                                    )                                           = 0;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Helper Functions.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
protected:  ////                    Helper Params.
                                    struct HelperParamMapPA
                                    {
                                    MINTPTR     phyAddr;        // physicall address; in/out
                                    MINTPTR     virAddr;        // virtual address
                                    MINT32      ionFd;          // ION file descriptor
                                    size_t      size;
                                    MINT32      security;
                                    MINT32      coherence;
                                    };

                                    struct HelperParamFlushCache
                                    {
                                    MINTPTR     phyAddr;        // physical address
                                    MINTPTR     virAddr;        // virtual address
                                    MINT32      ionFd;          // ION file descriptor
                                    size_t      size;
                                    };

protected:  ////                    Helper Functions.
    virtual MBOOL                   helpMapPhyAddr(
                                        char const* szCallerName,
                                        HelperParamMapPA& rParam
                                    );

    virtual MBOOL                   helpUnmapPhyAddr(
                                        char const* szCallerName,
                                        HelperParamMapPA const& rParam
                                    );

    virtual MBOOL                   helpFlushCache(
                                        eCacheCtrl const ctrl,
                                        HelperParamFlushCache const* paParam,
                                        size_t const num
                                    );

    virtual MBOOL                   helpCheckBufStrides(
                                        size_t const planeIndex,
                                        size_t const planeBufStridesInBytes
                                    ) const;

    virtual size_t                  helpQueryBufSizeInBytes(
                                        size_t const planeIndex,
                                        size_t const planeStridesInBytes
                                    ) const;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Implementations.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
private:    ////                    Called inside lock.
    virtual MBOOL                   initLocked();
    virtual MBOOL                   uninitLocked();
    virtual MBOOL                   lockBufLocked(char const* szCallerName, MINT usage);
    virtual MBOOL                   unlockBufLocked(char const* szCallerName);

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Instantiation.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
protected:  ////                    Destructor/Constructors.
    /**
     * Disallowed to directly delete a raw pointer.
     */
    virtual                         ~BaseImageBufferHeap();
                                    BaseImageBufferHeap(char const* szCallerName);

protected:  ////                    Callback (LastStrongRef@RefBase)
    virtual void                    onLastStrongRef(const void* id);

protected:  ////                    Callback (Create)
    virtual MBOOL                   onCreate(
                                        MSize const& imgSize,
                                        MINT const imgFormat = eImgFmt_BLOB,
                                        size_t const bitstreamSize = 0,
                                        MBOOL const enableLog = MTRUE
                                    );

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Data Members.
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
private:    ////                    Heap Info.
    IHalMemory*                     mpHalMemory;
    mutable Mutex                   mInitMtx;
    mutable Mutex                   mLockMtx;
    MINT32 volatile                 mLockCount;
    MINT32                          mLockUsage;
    BufInfoVect_t                   mvBufInfo;

private:    ////                    Image Attributes.
    String8                         mCallerName;
    MSize                           mImgSize;
    MINT                            mImgFormat;
    size_t                          mPlaneCount;
    size_t                          mBitstreamSize; // in bytes
    MBOOL                           mEnableLog;

};


/******************************************************************************
 *
 ******************************************************************************/
};  // namespace NSImageBufferHeap
};  // namespace NSCam
#endif  //_MTK_HARDWARE_INCLUDE_MTKCAM_UTILS_BASEIMAGEBUFFERHEAP_H_