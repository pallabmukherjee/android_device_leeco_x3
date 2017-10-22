


################################################################################
#
################################################################################
MTK_PATH_CUSTOM_PLATFORM := device/leeco/x3/vendor/mediatek/proprietary/custom/$(shell echo $(MTK_PLATFORM) | tr '[A-Z]' '[a-z]')


#########

LOCAL_SHARED_LIBRARIES := \
					libcameracustom.camera \
					libcameracustom.imgsensor \
					libmmsdk.client.effect \
					libmmsdk.client.gesture \
					libmmsdk.client.heartrate \
					libmmsdk.client.imageTransform \
					libmmsdkservice.feature \
					mmsdktest \
					libgralloc_extra \
					libgui_ext \
					libmtk_mmutils \
					libacdk_entry_mdk \
					libcam.exif \
					libcam.metadata \
					libcam.metadata.conversion \
					libcam.common.metadata \
					libcam_mmp \
					camera.default.devicemgrbase \
					camera.default.module \
					libcam_utils \
					libcam.utils.cpuctrl \
					libcam_utils.common.imagebuffer \
					camtest_imagebuffer \
					libcam.utils.sensorlistener \
					libcam.client.camclient.generic \
					libcam.client.camclient.common \
					libcam.client.camclient.previewcallback \
					libcam.client.camclient.previewfeature \
					libcam.client.camclient.featurebase.commav \
					libcam.client.camclient.featurebase.commotiontrack \
					libcam.client.camclient.featurebase.companorama \
					libcam.client.camclient.record.common \
					libcam.client.displayclient \
					libcam.sdkclient \
					libcam.sdkclient.gesture \
					libcam.utils.common \
					libcam1_utils \
					libcam.paramsmgr.feature \
					libcam.paramsmgr.feature.custom \
					libcam.paramsmgr.common \
					libcam.device1.common \
					camtest \
					libcam3_app \
					libcam.device3.common \
					libcam3_pipeline \
					libcam3_pipeline_DefaultPipelineModel \
					libcam3_utils \
					libhwsensorhub \
					libm4u \
					m4u_ut \
					mmsdk.default \
					mmsdkhaltest \
					libacdk \
					libcct \
					acdk_camshottest \
					libcam.camnode \
					libtsfacebeautify \
					libcam.camnode.featurepipe \
					camnodetest \
					libcam.camshot \
					camshottest \
					libcamdrv \
					libcamdrv_imem \
					libcamdrv_isp \
					libcamdrv_res_mgr \
					libcamdrv_resmanager \
					libcamdrv_twin \
					libfeatureio \
					libfeatureiodrv \
					libcam.featureio.pipe.3DFeature \
					libfeatureiopipe_aaa \
					libfeatureio.aaa.custom \
					libfeatureiopipe \
					libfeatureiopipe_asd \
					libcam.featureio.pipe.panorama \
					libcam.featureio.pipe.capturenr \
					libfeatureiopipe_eis \
					libcam.featureio.pipe.facebeauty \
					libfeatureiopipe_fdft \
					libfeatureiopipe_flk \
					libcam.featureio.pipe.gestureshot \
					libfeatureiopipe_hdr \
					libcam.featureio.pipe.hrd \
					libfeatureiopipe_mfll \
					libcam.featureio.pipe.motiontrack \
					libfeatureiopipe_ot \
					libfeatureiopipe_pip \
					libcam.featureio.pipe.stereo \
					libcam.featureio.pipe.stereodepth \
					libcam.featureio.pipe.utility \
					libfeatureiopipe_vfb \
					libfeatureiopipe_vhdr \
					libimageio \
					libimageio_plat_drv \
					libimageio_plat_pipe \
					libcam.iopipe \
					libcam.iopipe.camio \
					libcam.iopipe.postproc \
					libcam.iopipe.simager \
					simagertest \
					iopipetest \
					libcam.jni.lomohaljni \
					libcam_platform \
					libcam_platform.cam1device \
					libcam_platform.halmemoryadapter \
					libcam.halsensor \
					libcam.halsensor.custom \
					libcam_hwutils \
					libcam.metadataprovider \
					libcam.metadataprovider_static \
					libcam.metadataprovider.custom \
					libcam.metadataprovider_request \
					libcam.templaterequest.custom \
					libcam.camadapter \
					libcam.camadapter.callback \
					libcam.camadapter.camnode \
					libcam.camadapter.mtkdefault \
					libcam.camadapter.mtkdefault.state \
					libcam.camadapter.mtkeng \
					libcam.camadapter.mtkeng.state \
					libcam.camadapter.mtkstereo \
					libcam.camadapter.mtkstereo.state \
					libcam.camadapter.scenario \
					libcam.camadapter.scenario.shot \
					libcam.camadapter.scenario.shot.capbufshot \
					libcam.camadapter.scenario.shot.continuousshot \
					libcam.camadapter.scenario.shot.engshot \
					libcam.camadapter.scenario.shot.facebeautyshot \
					fbsdktest \
					libcam.camadapter.scenario.shot.hdrshot \
					shottest \
					libcam.camadapter.scenario.shot.normalshot \
					libcam.camadapter.scenario.shot.stereoshot \
					libcam.camadapter.scenario.shot.testshot \
					libcam.camadapter.scenario.shot.tsbeautyshot \
					libcam.camadapter.thermalmonitor \
					libcam.client \
					libcam.client.camclient.fd \
					libcam.client.camclient.asd \
					libcam.client.camclient.ot \
					libcam.client.camclient.record.platform \
					libcam.utils \
					libcam.utils.platform \
					libcam.paramsmgr \
					libcam.paramsmgr.platform \
					libcam.device1 \
					testAdapter \
					testCtrlNode \
					libc_aeabi \
					libdl \
					linker \
					libjpeg_static \
					libjpeg \
					pngtest \
					libperfservicenative \
					libz \
					libsync \
					sync-unit-tests
