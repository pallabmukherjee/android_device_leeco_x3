#ifndef _MTK_HARDWARE_INCLUDE_MTKCAM_UTILS_MISC_H_
#define _MTK_HARDWARE_INCLUDE_MTKCAM_UTILS_MISC_H_
//
/******************************************************************************
 *
 ******************************************************************************/
namespace NSCam {
namespace Utils {


/******************************************************************************
 * @brief dump call stack
 ******************************************************************************/
void
dumpCallStack(char const* prefix = 0);


/******************************************************************************
 * @brief make all directories in path.
 *
 * @details
 * @note
 *
 * @param[in] path: a specified path to create.
 * @param[in] mode: the argument specifies the permissions to use, like 0777
 *                 (the same to that in mkdir).
 *
 * @return
 * -    true indicates success
 * -    false indicates failure
 *****************************************************************************/
bool
makePath(
    char const*const path, 
    uint_t const mode
);


/******************************************************************************
 * @brief save the buffer to the file
 *
 * @details
 * 
 * @note
 * 
 * @param[in] fname: The file name
 * @param[in] buf: The buffer to save
 * @param[in] size: The size in bytes to save
 *
 * @return
 * -    true indicates success
 * -    false indicates failure
 ******************************************************************************/
bool
saveBufToFile(
    char const*const    fname,
    unsigned char*const buf,
    unsigned int const  size
);


/******************************************************************************
 * @brief load the file to the buffer
 *
 * @details
 * 
 * @note
 * 
 * @param[in] fname: The file name
 * @param[out] buf: The output buffer
 * @param[in] capacity: The buffer capacity in bytes
 *
 * @return
 * -   The loaded size in bytes.
 ******************************************************************************/
unsigned int
loadFileToBuf(
    char const*const    fname,
    unsigned char*const buf,
    unsigned int const  capacity
);


/******************************************************************************
 * @brief set the thread policy & priority
 *
 * @details
 *
 * @note
 *
 * @param[in] policy: The policy of the thread
 * @param[in] priority: The priority of the thread
 *
 * @return
 * -    true indicates success
 * -    false indicates failure
 ******************************************************************************/
bool
setThreadPriority(
    int policy,
    int priority
);


/******************************************************************************
 * @brief get the thread policy & priority
 *
 * @details
 *
 * @note
 *
 * @param[out] policy: The policy of the thread
 * @param[out] priority: The priority of the thread
 *
 * @return
 * -    true indicates success
 * -    false indicates failure
 ******************************************************************************/
bool
getThreadPriority(
    int& policy,
    int& priority
);


/******************************************************************************
 *
*******************************************************************************/
};  // namespace Utils
};  // namespace NSCam
#endif  //_MTK_HARDWARE_INCLUDE_MTKCAM_UTILS_MISC_H_