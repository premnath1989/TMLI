/*==============================================================*
 * SOFTPRO SignWare                                             *
 * ADSV developer Toolkit                                       *
 * Module: SPSignWare.h                                         *
 * Created by: uko                                              *
 *                                                              *
 * @(#)SPSignWare.h                            1.00 02/06/04    *
 *                                                              *
 * Copyright SOFTPRO GmbH                                       *
 * Wilhelmstrasse 34, D-71034 Boeblingen                        *
 * All rights reserved.                                         *
 *                                                              *
 * This software is the confidential and proprietary            *
 * information of SOFTPRO ("Confidential Information"). You     *
 * shall not disclose such Confidential Information and shall   *
 * use it only in accordance with the terms of the license      *
 * agreement you entered into with SOFTPRO.                     *
 *==============================================================*/
/**
 * @file SPSignWare.h
 * @author uko
 *
 * @brief SignWare Dynamic Development toolkit
 *
 * This header contains global definitions for SignWare.
 */
/**
 * @section sw_capi_copyright Copyright
 * Copyright &copy; SOFTPRO GmbH
 * <br>Wilhelmstrasse 34, D-71034 Boeblingen
 * <br>All rights reserved.
 *
 */
/**
 * @mainpage C-API Documentation
 * <br>This software is the confidential and proprietary
 * information of SOFTPRO ("Confidential Information"). You
 * shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license
 * agreement you entered into with SOFTPRO (see \ref sw_contract "License Agreement").
 *
 * @section sw_capi_introduction SignWare C-API [Core]
 * The API documentation is structured in object modules. Each module
 * describes the accessible types, variables, and functions for the
 * corresponding object. Major headers are
 *   - SPAcquire.h declares functions for capturing dynamic signatures
 *       without GUI (SPAcquire object). Please see SPGuiAcqu.h to
 *       capture signatures with GUI.
 *   - SPBackgroundObjects.h declares a container for tablet background descriptors.
 *   - SPBitmap.h declares functions for converting objects such as signatures,
 *       references, and templates to a standard image format (SPBitmap object).
 *   - SPCleanParameter.h defines a parameter container for cleaning
 *       static images (SPCleanParameter object).
 *   - SPCompare.h defines a signature comparison object (SPCompare).
 *   - SPFlatFile.h declares functions for serializing objects.
 *       Serialized objects (SPFlatFile objects) can be saved in a
 *       file or in a database.
 *   - SPGuiAcqu.h declares functions for capturing dynamic signatures
 *       with GUI (SPGuiAcqu object). Please see SPAcquire.h to capture 
 *       signatures without GUI.
 *   - SPGuiContainer.h declares funtions or capturing signatures with GUI
 *       from one or more tablets at the same time.
 *   - SPGuiDisp.h declares functions for visualizing signatures (SPGuiDisp
 *       object).
 *   - SPGuiDyn.h declares functions for visualizing dynamic features of
 *       signatures (SPGuiDyn object).
 *   - SPImage.h declares functions for processing images containing
 *       static signatures (SPImage object).
 *   - SPLicenseClient.h declares functions to load a license from a
 *     SOFTPRO license service using a registration code (deprecated)
 *   - SPPropertyMap.h implements a property container.
 *   - SPReference.h declares functions related to references (SPReference
 *       object, comprising several dynamic signatures).
 *   - SPScanner.h declares functions for accessing scanners, including
 *       enumerating scanner devices and querying scanner properties
 *   - SPSmartcard.h defines an interface to smart cards, based on
 *       ISO 7816 (SPSmartcard object).
 *   - SPSmartcardDriver.h defines an interface to CT-API-compliant
 *       smart card readers (SPSmartcardDriver object).
 *   - SPSignature.h declares functions for processing a single dynamic
 *       signature (SPSignature object, comprising tablet vectors (samples)
 *       and other properties of a dynamic signature).
 *   - SPSignWare.h contains global definitions such as return codes
 *      and type definitions.
 *   - SPTablet.h declares functions related to the SPTablet object used
 *      for capturing signatures from a tablet.
 *   - SPTabletEnum.h declares functions related to the SPTabletEnum object used
 *      to enumerate installed and connected tablets on the computer.
 *   - SPTeller.h defines an interface to SignBase&reg; (SPTeller and
 *      SPTellerImage objects).
 *   - SPTicket.h declares functions for handling license tickets
 *     (SPTicket object, deprecated).
 *   - SPTemplate.h declares functions related to signature templates
 *      (SPTemplate object). A template is a special type of a signature
 *      reference optimized for minimum storage requirements.
 *   .
 * If you are new to SignWare, begin reading at SPSignWare.h.
 *
 * @section sw_capi_ErrHandling Error handling and debugging
 * All SignWare functions return an error code as described in the function
 * description.  The lists of error codes need not be comprehensive.
 * <ul>
 * <li>Call \ref SPSignwareGetErrorString to convert an error code
 * to an English text.
 * <li>More detailed information about errors is written into
 * a log file if the environment variable <b>SPDEBUG</b> is set to a value
 * in the range 1 through 5. The bigger the value, the more information will
 * be logged.
 * <li>The location of the log file is defined by the environment variable
 * <b>SPDEBUGDIR</b>. If the value of <b>SPDEBUGDIR</b> is the pathname
 * of an existing directory, the log file will be named logfile.log in
 * that directory. Otherwise, the value of <b>SPDEBUGDIR</b> is taken
 * as filename of the log file.
 * <li>If <b>SPDEBUGDIR</b> is not set, the log file will be named logfile.log
 * in the directory specified by the environment variable <b>TEMP</b>.
 * If <b>TEMP</b> is not set, <b>TMP</b> will be used.
 * If both environment variables are not set, the current working directory
 * will be used.
 * <li> No log information is written if the log file cannot be created, e.g.,
 * if the specified path does not exist or if access is denied.
 * <li> If the log file already exists, new information will be appended.
 * If the log file does not exist, it will be created.
 * <li> Always include a log file with <b>SPDEBUG</b> set to 5 when sending
 * an incident (bug) report to the \ref sw_contact "SignWare contact" address.
 *  </ul>
 *
 * @section sw_capi_faqs FAQs: Frequently Asked Questions
 * What databases are supported by SignWare?
 * <br> <em> SignWare does not access any database directly. SignWare converts
 * (serializes) some objects such as signatures, references, and templates to a binary flat file
 * format that may be inserted into any database as a blob.
 * </em> <br> <br>
 * How can I check if a tablet is installed and connected?
 * <br> <em> Create an SPTablet object, then check the device.
 * A Tablet is connected if the driver is not @ref SP_UNKNOWN_DRV and
 * the resolution is non-zero.
 * Please note that there is a limitation on Wacom tablets: the driver returns
 * a valid tablet ID and resolution even if no tablet is connected to the
 * system.
 * </em> <br> <br>
 * Are there any restrictions on the size and resolution of static images?
 * <br> <em> The static compare engine rejects images with a width smaller
 * than 20 pixels or a height smaller than 10 pixels.  Moreover, the
 * width must not exceed 2560 pixels and the height must not exceed
 * 1920 pixels.
 * The minimum resolution of static images is 150 DPI, resolutions
 * 200 DPI through 300 DPI are recommended.
 * </em> <br> <br>
 * How can I determine if a static image is empty?
 * <br> <em> Query the signature region (@ref SPImageGetSignatureRegion)
 * and check if the resulting rectangle is smaller than 5mm by 5mm.
 * <br> You may want to clean the image first to remove any dirt by
 * calling @ref SPImageCleanSignature.
 * </em> <br> <br>
 * How can I determine if a dynamic signature is empty?
 * <br> <em> Check if the number of vectors in the signature
 * (see @ref SPSignatureGetNrVectors) is greater than 5.
 * <br> This check might include vectors having a pressure level of 0.
 * Alternatively, you may check the size of the signature image
 * (see @ref SPSignatureGetImageSize), but this is more expensive in
 * terms of CPU time.
 * <br> The above checking is implemented in a single call to @ref SPSignatureCheck
 * or @ref SPReferenceCheck with @ref SP_SIGNATURE_MIN_VECTORS or @ref SP_SIGNATURE_MIN_WIDTH
 * and @ref SP_SIGNATURE_MIN_HEIGHT set accordingly.
 * </em> <br> <br>
 * How can I read the background image of a tablet for audit purposes?
 * <br> <em> Query the background image (@ref SPGuiAcquGetBackgroundImage).
 * <br> The returned Image equals the image as it was sent to the tablet (or 
 * PC screen) without signature strokes.
 * </em> <br> <br>
 *
 * @section sw_capi_versions Versions
 * @subsection swversion SignWare version history
 *
 * Please see ReleaseNotes.html for details on the version history.
 */

#ifndef SPSIGNWARE_H__
#define SPSIGNWARE_H__

#if defined (__WINDOWS__) || defined(_WIN32)
#include <windows.h>
#endif

#if defined (SP_TARGET_POSIX)
#include <stdint.h>
#endif

/*==============================================================*
 * Constant definitions                                         *
 *==============================================================*/
/**
 * Signware Core Major Version
 */
#define SP_SIGNWARE_MAJOR 3
/**
 * Signware Core Minor Version
 */
#define SP_SIGNWARE_MINOR 2
/**
 * Signware Core Revision Version
 */
#define SP_SIGNWARE_REVISION 7
/**
 * Signware Core Build Version
 */
#define SP_SIGNWARE_BUILD 1

/* Compiler specific linkage definition */
#if defined (__IBMC__) || defined (__IBMCPP__)
/* IBM VisualAge C-Compiler */

#  ifndef SPEXPORT
#     define SPEXPORT(__iRet) __iRet _Export
#  endif
#  ifndef SPEXTERN
#     define SPEXTERN extern
#  endif
#  ifndef SPLINK
#     define SPLINK __cdecl
#  endif
#  ifndef SPCALLBACK
#     define SPCALLBACK __cdecl
#  endif
#  ifndef SPXIMPORT
#     define SPXIMPORT extern
#  endif
#  ifndef SPXEXPORT
#     define SPXEXPORT _Export
#  endif
#  ifndef INLINE
#     define INLINE static
#  endif

#elif defined (_MSC_VER)
/* Microsoft Visual Studio C-Compiler */

#  if defined(_WIN32)
#     ifndef SPEXPORT
#        define SPEXPORT(__iRet) __declspec (dllexport) __iRet
#     endif
#     ifndef SPXIMPORT
#        define SPXIMPORT __declspec(dllimport)
#     endif
#     ifndef SPXEXPORT
#        define SPXEXPORT __declspec(dllexport)
#     endif
#     if defined SPXXPORT
#        define SPEXTERN __declspec (dllexport)
#     endif
#  else
#    ifndef SPEXPORT
#      define SPEXPORT(__iRet) __export __iRet
#    endif
#    ifndef SPXIMPORT
#      define SPXIMPORT extern
#    endif
#    ifndef SPXEXPORT
#      define SPXEXPORT __export
#    endif
#  endif
#  ifndef SPLINK
#     define SPLINK __cdecl
#  endif
#  ifndef SPEXTERN
#     define SPEXTERN extern
#  endif
#  ifndef SPCALLBACK
#     define SPCALLBACK _cdecl
#  endif
#  ifdef __cplusplus
#     ifndef INLINE
#        define INLINE inline
#     endif
#  else
#     ifndef INLINE
#        define INLINE __inline
#     endif
#  endif
#if defined (_MSC_VER)
#  ifndef snprintf
#     define snprintf _snprintf
#  endif
#endif

#elif defined(__BORLANDC__)
/* Borland C-Compiler */

#  if defined(_WIN32)
#     ifndef SPEXPORT
#        define SPEXPORT(__iRet) __export __iRet
#     endif
#     ifndef SPLINK
#        define SPLINK
#     endif
#   else
#     ifndef SPEXPORT
#        define SPEXPORT(__iRet) _export __iRet
#     endif
#     ifndef SPLINK
#        define SPLINK   _cdecl
#     endif
#   endif
#   ifndef SPXIMPORT
#     define SPXIMPORT extern
#   endif
#   ifndef SPXEXPORT
#     define SPXEXPORT __export
#   endif
#   ifndef SPEXTERN
#     define SPEXTERN extern
#   endif
#   ifndef SPCALLBACK
#     define SPCALLBACK _cdecl
#   endif
#     ifndef INLINE
#        define INLINE static
#     endif

#elif defined (__GNUC__)
/* GNU GCC */

#   ifndef SPEXPORT
#     define SPEXPORT(__iRet) __iRet
#   endif
#   ifndef SPEXTERN
#     define SPEXTERN extern
#   endif
#   ifndef SPLINK
#     ifdef __I386__
#       define SPLINK __attribute__((__cdecl__))
#     else
#       define SPLINK
#     endif
#   endif
#   ifndef SPCALLBACK
#     ifdef __I386__
#       define SPCALLBACK __attribute__((__cdecl__))
#     else
#       define SPCALLBACK
#     endif
#   endif
#   ifndef SPXIMPORT
#     define SPXIMPORT extern
#   endif
#   ifndef SPXEXPORT
#     define SPXEXPORT
#   endif
#     ifndef INLINE
#        define INLINE inline
#     endif

#else
#error "Unsupported compiler"
#endif

#if !defined (__WINDOWS__) && !defined(_WIN32)
/**
 * @brief define HRESULT on non Windows operating systems
 */
#  ifndef HRESULT
#    define HRESULT int
#  endif
#  ifndef PURE
#    define PURE  = 0
#  endif
#endif

#ifdef __cplusplus
/**
 * @brief define STDMETHOD, STDMETHOD_, STDMETHODIMP and STDMETHODIMP_  macros on non Windows operating systems
*/
#  ifndef STDMETHOD
#    define STDMETHOD(__fct) virtual HRESULT __fct
#  endif
#  ifndef _STDMETHOD
#    define _STDMETHOD(__ret, __fct) virtual __ret __fct
#  endif
#  ifndef STDMETHODIMP
#    define STDMETHODIMP HRESULT
#  endif
#  ifndef _STDMETHODIMP
#    define _STDMETHODIMP(__ret) __ret
#  endif
#  ifndef interface
#    define interface struct
#  endif

#else    /* __cplusplus */

#endif      /* __cplusplus */

/**
 * @brief Tablet driver ID: unknown.
 *
 * Identifier for an unknown tablet driver.
 *
 * @see SPTabletCreate
 */
#define SP_UNKNOWN_DRV     0

/**
 * @brief Tablet driver ID: Wintab driver.
 *
 * Identifier for a Wintab driver.
 *
 * @see SPTabletCreate
 */
#define SP_WINTAB_DRV       1

/**
 * @brief Tablet driver ID: MobiNetix driver
 *
 * Identifier for a MobiNetix driver.
 *
 * @see SPTabletCreate
 */
#define SP_PADCOM_DRV      2

/**
 * @brief Tablet driver ID: SOFTPRO native driver.
 *
 * Identifier for a SOFTPRO native driver.
 *
 * @see SPTabletCreate
 */
#define SP_NATIVE_DRV      3

/**
 * @brief Tablet driver ID: SOFTPRO remote driver.
 *
 * Identifier for a SOFTPRO remote driver.
 *
 * @see SPTabletCreate
 */
#define SP_TCP_DRV         4

/**
 * @brief Tablet driver ID: SOFTPRO TabletServer driver.
 *
 * Identifier for a SOFTPRO TabletServer driver.
 *
 * @see SPTabletCreate
 */
#define SP_TABLETSERVER_DRV 5

/**
 * @brief Tablet driver ID: SOFTPRO RemoteTablet driver.
 *
 * Identifier for a SOFTPRO RemoteTablet driver.
 *
 * @see SPTabletCreate
 */
#define SP_REMOTETABLET_DRV 6

/**
 * @brief Tablet driver ID: SOFTPRO Generic access module.
 *
 * Identifier for a SOFTPRO Generic access module.
 *
 * @see SPTabletCreate
 */
#define SP_GENERIC_DRV 7

/**
 * @brief Tablet device ID: Unknown tablet device.
 *
 * Identifier for an unknown tablet device.
 *
 * @see SPTabletGetDevice
 */
#define SP_UNKNOWN_DEV     0

/**
 * @brief Tablet device ID: Wacom Intuos.
 *
 * Identifier for a Wacom Intuos tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_INTUOS_DEV      1

/**
 * @brief Tablet device ID: MobiNetix.
 *
 * Identifier for a MobiNetix tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_MOBINETIX_DEV   2

/**
 * @brief Tablet device ID: Wacom Graphire.
 *
 * Identifier for a Wacom Graphire tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_GRAPHIRE_DEV    3

/**
 * @brief Tablet device ID: BS Hesy.
 *
 * Identifier for a BS Hesy tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_HESY_DEV        4

/**
 * @brief Tablet device ID: Wacom PL400.
 *
 * Identifier for a Wacom PL400 or Wacom Cintiq tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_PL400_DEV       5

/**
 * @brief Tablet device ID: Interlink ePad POS.
 *
 * Identifier for an Interlink ePad Point Of Sales tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_EPOS_DEV        6

/**
 * @brief Tablet device ID: Interlink ePad E-Signature.
 *
 * Identifier for an Interlink ePad Electronic Signature tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_ESIG_DEV        7

/**
 * @brief Tablet device ID: Interlink ePad-ink.
 *
 * Identifier for an Interlink ePad-ink E-Signature tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_EINK_DEV        8

/**
 * @brief Tablet device ID: Wacom PenPartner.
 *
 * Identifier for a Wacom PenPartner tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_PENPARTNER_DEV  9

/**
 * @brief Tablet device ID: Tablet PC.
 *
 * Identifier for a Tablet PC (capture device integrated).
 *
 * @see SPTabletGetDevice
 */
#define SP_TABLETPC_DEV   10

/**
 * @brief Tablet device ID: StepOver.
 *
 * Identifier for a StepOver tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_STEPOVER_DEV   11

/**
 * @brief Tablet device ID: Interlink EPad-ID.
 *
 * Identifier for an Interlink EPad-ID tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_EID_DEV        12

/**
 * @brief Tablet device ID: MotionTouch LegaPad LCD.
 *
 * Identifier for a Motiontouch LegaPad LCD tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_MTLCD_DEV        13

/**
 * @brief Tablet device ID: MotionTouch LegaPad.
 *
 * Identifier for a Motiontouch LegaPad tablet without LCD.
 *
 * @see SPTabletGetDevice
 */
#define SP_MTLPD_DEV        14

/**
 * @brief Tablet device ID: Interlink ePad II.
 *
 * Identifier for a Interlink ePad II tablet without LCD.
 *
 * @see SPTabletGetDevice
 */
#define SP_EPAD2_DEV        15

/**
 * @brief Tablet device ID: Stepover blueM - II.
 *
 * Identifier for a stepover blueM II Tablet without LCD.
 *
 * @see SPTabletGetDevice
 */
#define SP_BLUEM_DEV        16

/**
 * @brief Tablet device ID: Stepover blueM - II.
 *
 * Identifier for a stepover blueM II tablet with LCD.
 *
 * @see SPTabletGetDevice
 */
#define SP_BLUEMLCD_DEV     17

/**
 * @brief Tablet device ID: Topaz tablet with LCD (and pressure).
 *
 * Identifier for a Topaz tablet with LCD (and pressure).
 *
 * @see SPTabletGetDevice
 */
#define SP_TZSE_DEV         18  /* Topaz LCD SE devices */

/**
 * @brief Tablet device ID: Interlink EPad-LS.
 *
 * Identifier for an Interlink EPad-LS tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_EPADLS_DEV       19

/**
 * @brief Tablet device ID: Interlink EPad-Ink Pro.
 *
 * Identifier for an Interlink EPad-Ink Pro tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_EINK2_DEV        20

/**
 * @brief Tablet device ID: Interlink EPad-ID Pro.
 *
 * Identifier for an Interlink EPad-ID Pro tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_EID2_DEV         21

/**
 * @brief Tablet device ID: Wacom SignPad.
 *
 * Identifier for a Wacom SignPad tablet with LCD.
 *
 * @see SPTabletGetDevice
 */
#define SP_SIGNPAD_DEV      22

/**
 * @brief Tablet device ID: Wacom Bamboo.
 *
 * Identifier for a Wacom Bamboo tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_BAMBOO_DEV       23

/**
 * @brief Tablet device ID: Verifone MX 800 series.
 *
 * Identifier for a Verifone MX tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_VERIFONE_MX_DEV  24

/**
 * @brief Tablet device ID: Ingenico iSC350.
 *
 * Identifier for a Ingenico iSC350 tablet.
 *
 * @see SPTabletGetDevice
 */
#define SP_INGENICO_SC350_DEV  25

/*==========================================================================*
 * Mobile Devices                                                           *
 *==========================================================================*/
/**
 * @brief Tablet device ID: iPad.
 *
 * Identifier for a iPad device.
 *
 * @see SPTabletGetDevice
 */
#define SP_IPAD_DEV        501

/**
 * @brief Tablet device ID: iPhone.
 *
 * Identifier for a iPhone device.
 *
 * @see SPTabletGetDevice
 */
#define SP_IPHONE_DEV      502

/**
 * @brief Tablet device ID: iPod.
 *
 * Identifier for a iPod device.
 *
 * @see SPTabletGetDevice
 */
#define SP_IPOD_DEV      503

/**
 * @brief Tablet device ID: Olivetti graphos zPad-B8001.
 *
 * Identifier for a Olivetti Graphos zPad-B8001 device.
 *
 * @see SPTabletGetDevice
 */
#define SP_OLIVETTI_ZPAD_B8001_DEV    510

/**
 * @brief Tablet device ID: Samsung GT-N7000.
 *
 * Identifier for a Samsung GT-N7000 device.
 *
 * @see SPTabletGetDevice
 */
#define SP_SAMSUNG_GT_N7000_DEV  511

/**
 * @brief Tablet device ID: HTC Flyer P510e.
 *
 * Identifier for a HTC Flyer P510e device.
 *
 * @see SPTabletGetDevice
 */
#define SP_HTC_P510E_DEV 512

/**
 * @brief Tablet device ID: mobilephone touch.
 *
 * Identifier for an android touch device.
 *
 * @see SPTabletGetDevice
 */
#define SP_ANDROID_TOUCH_DEV 513

/**
 * @brief Signature captured through HTML5 capture client
 *
 * @see SPTabletGetDevice
 */
#define SP_HTML5_CAPTURE_DEV 514

/* Range 10000 ... 11000 is for free use */

/**
 * @brief Tablet device ID: Euronovate ENSign10
 * 
 * Identifier for an ENSign10 device.
 *
 * @see SPTabletGetDevice
 */
#define SP_ENSIGN10_PAD 1001

/**
 * @brief Tablet device ID: VPSign
 * 
 * Identifier for an VPSign device.
 *
 * @see SPTabletGetDevice
 */
#define SP_VPSIGN_PAD 1002
/*==========================================================================*
 * Background Image activation                                              *
 *==========================================================================*/
/**
 * @brief Image destination on the tablet: active image.
 *
 * The active image is displayed while capturing a signature.
 *
 * @see SPTabletSetBackgroundImage2
 */
#define SP_ACTIVE_IMAGE     0

/**
 * @brief Image destination on the tablet: idle image.
 *
 * The idle image is displayed after disconnecting a device.
 * @note Currently, only the Wacom SignPad supports an idle image.
 *
 * @see SPTabletSetBackgroundImage2
 */
#define SP_IDLE_IMAGE       1

/**
 * @brief Image destination on the tablet: display image immediately.
 *
 * The immediate image is displayed immediately.
 * @note Currently, only the Wacom SignPad supports an immediate image.
 *
 * @see SPTabletSetBackgroundImage2
 */
#define SP_IMMEDIATE_IMAGE  2

/**
 * @brief SPTablet display type of the connected tablet, the tablet has no
 * display, e.g. Wacom Intuos
 * @see SPTabletSetDisplayType, SPTabletGetDisplayType
 */
#define SP_TABLET_NO_DISPLAY 0

/**
 * @brief SPTablet display type of the connected tablet, the tablet has an integrated
 * LCD display, e.g. Wacom Signpad (STU-500)
 * @see SPTabletSetDisplayType, SPTabletGetDisplayType
 */
#define SP_TABLET_LCD_DISPLAY 1

/**
 * @brief SPTablet display type of the connected tablet, the tablet is integrated
 * into the PC's display, e.g. TabletPC
 * @see SPTabletSetDisplayType, SPTabletGetDisplayType
 */
#define SP_TABLET_PC_DISPLAY 2

/**
 * @brief The connected tablet cannot send signature strokes (vectors) in real time
 * but rather sends all vectors in a block at the end of the capture process
 * 
 * @see SPTabletGetTabletType
 */
#define SP_TABLET_NO_REALTIME_VECTORS 1

/**
 * @brief The connected tablet has builtin virtual buttons. A click on a virtual
 * button is passed as a hardware button notification. 
 * 
 * @see SPTabletGetTabletType, pSPTABLETBUTTON_T
 */
#define SP_TABLET_HARDWARE_AS_VIRTUAL_BUTTONS 2

/**
 * @brief Request a physical tablet property 
 *  
 * @see SPTabletGetResolution2, SPTabletGetSampleRate2 
 */
#define SP_TABLET_PHYSICAL 1

/**
 * @brief Request a logical tablet property 
 *  
 * @see SPTabletGetResolution2, SPTabletGetSampleRate2 
 */
#define SP_TABLET_LOGICAL 2
/*==============================================================*
 * SPGuiAcqu capture results                                    *
 *==============================================================*/

/**
 * @brief SPGuiAcqu capture result: OK button.
 *
 * @see SPGuiAcquAcquireDone
 */
#define SP_IDOK 1

/**
 * @brief SPGuiAcqu capture result: Cancel button.
 *
 * @see SPGuiAcquAcquireDone
 */
#define SP_IDCANCEL 2

/*==============================================================*
 * SPGui Draw Modes                                             *
 *==============================================================*/
/**
 * @brief Draw mode flag: draw a border around tablet area in GUI objects.
 *
 * @see SPGuiAcquSetDrawMode, SPGuiDispSetDrawMode
 */
#define SP_DRAW_TABLET_BORDER 1

/**
 * @brief Draw mode flag: draw a border around the window in GUI objects.
 *
 * @see SPGuiAcquSetDrawMode, SPGuiDispSetDrawMode, SPGuiDynSetDrawMode
 */
#define SP_DRAW_HWND_BORDER 2


/**
 * @brief Draw mode flag: stop acquiry mode when loosing focus in
 *        SPGUIAcqu object.
 *
 * @see SPGuiAcquSetDrawMode
 */
#define SP_RELEASE_FOCUS 4

/**
 * @brief Draw mode flag: let SignWare be responsible for erasing the
 *        background of the signature capturing window.
 *
 * @see SPGuiAcquSetDrawMode
 */
#define SP_ERASE_BACKGROUND 8

/**
 * @brief Draw mode flag: draw the pen position using an emulated cursor.
 *
 * @see SPGuiAcquSetDrawMode
 */
#define SP_EMULATE_PEN_CURSOR 0x10

/**
 * @brief Draw mode flag: do not draw a pen position; no caret,
 *        no emulated cursor.
 *
 * @see SPGuiAcquSetDrawMode
 */
#define SP_DISABLE_CURSOR 0x20

/**
 * @brief Draw mode flag: display the background image.
 *
 * If this flag is set, the background image will be displayed in the
 * SPGuiAcqu window and on the tablet. If this flag is not set, the
 * background image is displayed on the tablet only.
 *
 * @ref SP_DRAW_ON_SCREEN and SP_DRAW_BACKGROUND_IMAGE are mutually exclusive.
 * Buttons will always be displayed in the window if SP_DRAW_BACKGROUND_IMAGE
 * is set.
 *
 * This flag is ignored if no background image is set.
 *
 * @see SPGuiAcquSetDrawMode, SP_DRAW_ON_SCREEN
 */
#define SP_DRAW_BACKGROUND_IMAGE 0x40

/**
 * @brief Draw mode flag: virtual button mode.
 *
 * In virtual button mode, strokes are neither displayed nor processed,
 * except for clicks on virtual buttons (events will be sent for clicks
 * on virtual buttons).
 *
 * @note Most tablets with LCD screen will echo strokes to the integrated
 * LCD even when this flag is set. SOFTPRO is in contact with the tablet
 * manufacturers to add supporting this feature in future versions.
 * Please contact SOFTPRO to check if this feature is supported by your
 * tablet device.
 *
 * @see SPGuiAcquSetDrawMode
 */
#define SP_VIRTUAL_BUTTON_MODE 0x80

/**
 * @brief Draw mode flag: draw the tablet image in the acquiry window.
 *
 * A copy of the image, that was sent to the tablet,
 * will be rendered in the acquiry window, if this fflag is set.
 *
 * @note This flag should normally not be set because it looks nicer if
 * text is directly rendered into the window. It may however be useful to
 * see the tablet's display on the PC for debugging purposes.
 *
 * @see SPGuiAcquSetDrawMode
 */
#define SP_DRAW_TABLET_IMAGE_IN_WINDOW 0x100

/**
 * @brief Draw mode flag: virtual button click mode.
 *
 * if this flag is set then virtual buttons are clicked when the pen is pressed and released in 
 * the virtual button region.
 * <br> if this flag is not set then virtual buttons are clicked when the pen is
 * pressed in the virtual button region 
 *
 * @see SPGuiAcquSetDrawMode
 */
#define SP_VIRTUAL_BUTTON_CLICK 0x200

/**
 * @brief Mirror the tablet
 * 
 * Set this flag if the tablet is used upside down, or more precise rotated by 180 degrees.
 * The flag will rotate the background image for the tablet LCD (if applicable) 
 * and rotate all vectors received from the tablet.
 * 
 * @note This flag is ignored on full screen devices such as TabletPCs.
 */
#define SP_DRAW_MIRROR_TABLET 0x400

/**
 * @brief Draw Images with double buffering
 * 
 * Set this flag to reduce flickering.
 */
#define SP_DRAW_BUFFERED 0x800
/*==============================================================*
 * SPGuiAcqu Rect Flags                                         *
 *==============================================================*/
/**
 * @brief Rectangle flag: coordinates are specified in parts per
 *        thousand of tablet coordinates.
 *
 * @see SPGuiAcquRegisterRect
 */
#define SP_TABLET_COORDINATE 0x00000001

/**
 * @brief Rectangle flag: draw the rectangle on the tablet device.
 *
 * This flag only applies to tablets with integrated LCD.
 *
 * @see SPGuiAcquRegisterRect
 */
#define SP_DRAW_ON_EXT_LCD  0x00000002

/**
 * @brief Rectangle flag: draw the rectangle in the acquiry window.
 *
 * @ref SP_DRAW_ON_SCREEN and SP_DRAW_BACKGROUND_IMAGE are mutually exclusive.
 *
 * @see SPGuiAcquRegisterRect, SP_DRAW_BACKGROUND_IMAGE
 */
#define SP_DRAW_ON_SCREEN   0x00000004

/**
 * @brief Rectangle flag: ignore the rectangle if the tablet does not have
 *        an LCD.
 *
 * This flag does not apply to PC displays with integrated capture
 * device (such as Tablet PC).
 *
 * @see SPGuiAcquRegisterRect
 */
#define SP_ONLY_FOR_EXT_LCD 0x00000008

/*==============================================================*
 * Flags for SPGuiAcquCreateWithoutWindow                       *
 *==============================================================*/
/* see also SP_GUIACQU_CREATED */
/**
 * @brief Flag for SPAcquireCreate: use events
 *
 * @see SPAcquireCreate
 */
#define SP_GAWW_EVENTS      0x00000001

/*==============================================================*
 * Image formats supported by SPImage                           *
 *==============================================================*/
/**
 * @brief Image format: Windows Bitmap.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage, SPImageSaveInBitmap
 */
#define SP_IMAGE_BMP_WIN 1

/**
 * @brief Image format: JPEG.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage, SPImageSaveInBitmap
 */
#define SP_IMAGE_JPEG    3

/**
 * @brief Image format: GIF.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage, SPImageSaveInBitmap
 */
#define SP_IMAGE_GIF     4

/**
 * @brief Image format: CCITT4.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage, SPImageSaveInBitmap
 */
#define SP_IMAGE_CCITT4  5

/**
 * @brief Image format: TIFF.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage, SPImageSaveInBitmap
 */
#define SP_IMAGE_TIFF    6

/**
 * @brief Image format: compressed TIFF.
 *
 * This format can be used  for black/white images only.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage, SPImageSaveInBitmap
 */
#define SP_IMAGE_TIFF_LZW 7

/**
 * @brief Image format: PNG.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage, SPImageSaveInBitmap
 */
#define SP_IMAGE_PNG     8


/**
 * @brief Image format flag: create a black/white image having
 *        8 bits per pixel.
 *
 * If both SP_IMAGE_BLACKWHITE and @ref SP_IMAGE_BLACKWHITE_1BPP are
 * specified, SP_IMAGE_BLACKWHITE_1BPP takes precedence.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage, SPImageSaveInBitmap
 */
#define SP_IMAGE_BLACKWHITE     0x010000

/**
 * @brief Image format flag: draw a cross over the image.
 *
 * @see SPBitmapCreateFromFlatFile, SPBitmapCreateFromReference, SPBitmapCreateFromSignature, SPBitmapCreateFromTemplate, SPSignatureGetImage
 */
#define SP_IMAGE_CROSSED        0x020000

/** @cond UNUSED */
/**
 * @brief Image format flag: anti-alias the image.
 *
 * This flag is ignored if @ref SP_IMAGE_BLACKWHITE
 * or @ref SP_IMAGE_BLACKWHITE_1BPP or @ref SP_DONT_RENDER_METAFONT is set. 
 *  
 *  
 *
 * @see SPBitmapCreateFromReference, SPBitmapCreateFromSignature, SPBitmapCreateFromTemplate, SPSignatureGetImage
 */
#define SP_IMAGE_ANTIALIAS      0x040000
/** @endcond */

/**
 * @brief Image format flag: don't use the METAFONT renderer.
 *
 * If this flag is set, the METAFONT renderer won't be used for
 * rendering a dynamic signature to an image.
 *
 * @see SPSignatureGetImage, SP_DONT_RENDER_DIRECT
 */
#define SP_DONT_RENDER_METAFONT 0x080000

/**
 * @brief Image format flag: don't use the direct renderer.
 *
 * If this flag is set, the direct (simple) renderer won't be used for
 * rendering a dynamic signature to an image.
 *
 * @see SPSignatureGetImage, SP_DONT_RENDER_METAFONT
 */
#define SP_DONT_RENDER_DIRECT   0x100000

/**
 * @brief Image format flag: create a black/white image having
 *        1 bit per pixel.
 *
 * If both @ref SP_IMAGE_BLACKWHITE and SP_IMAGE_BLACKWHITE_1BPP are
 * specified, SP_IMAGE_BLACKWHITE_1BPP takes precedence.
 *
 * @see SPBitmapCreateFromFlatFile, SPSignatureGetImage
 */
#define SP_IMAGE_BLACKWHITE_1BPP 0x200000

/**
 * @brief Imaage format flag: create a color image having 24 bit per pixel
 * 
 * @note This bit is used internally, don't set this bit.
 */
#define SP_IMAGE_COLOR           0x400000

/**
 * @brief Template option data type: string.
 *
 * Strings are null-terminated, any encoding can be used.
 * The length (excluding null termination) must not exceed 32762.
 *
 * @see SPTemplateAddOption, SPTemplateGetOption
 */
#define SP_TEMPLATE_OPTION_STR   1

/**
 * @brief Template option data type: signed 32-bit integer.
 *
 * @see SPTemplateAddOption, SPTemplateGetOption
 */
#define SP_TEMPLATE_OPTION_INT   2

/**
 * @brief Template option data type: signed 8-bit integer.
 *
 * The range of a signed 8-bit integer is -128 through 127.
 *
 * @see SPTemplateAddOption, SPTemplateGetOption
 */
#define SP_TEMPLATE_OPTION_BYTE  3

/**
 * @brief Template option data type: signed 16-bit integer.
 *
 * @see SPTemplateAddOption, SPTemplateGetOption
 */
#define SP_TEMPLATE_OPTION_SHORT 4

/*==============================================================*
 * Types of tablet IDs                                           *
 *==============================================================*/
/**
 * @brief Use custom settable device ID if available, the factory set ID otherwise
 */
#define SP_TABLET_SERIAL_TYPE_DEFAULT 0

/**
 * @brief Use custom settable device ID
 */
#define SP_TABLET_SERIAL_TYPE_CUSTOM 1

/**
 * @brief Use factory set device ID
 */
#define SP_TABLET_SERIAL_TYPE_FACTORY 2

/*==============================================================*
 * External Libraries                                           *
 *==============================================================*/
/**
 * @brief Library status flag: SignWare library loaded.
 *
 * @see SPSignwareStatus
 */
#define SP_SDK_LOADED     1

/**
 * @brief Library status flag: external library DavLib loaded.
 *
 * @note DavLib is no longer used.
 *
 * @see SPSignwareStatus
 */
#define SP_DAVLIB_LOADED     2

/**
 * @brief Library status flag: external library SPDSV_DLL loaded.
 *
 * SPDSV_DLL contains the dynamic compare engine.
 *
 * @see SPSignwareStatus
 */
#define SP_DYNAMIC_LOADED  4

/**
 * @brief Library status flag: external library FSXTK loaded.
 *
 * FSXTK contains the static compare engine.
 *
 * @see SPSignwareStatus
 */
#define SP_STATIC_LOADED 8

/**
 * @brief Library status flag: external library LTKRN loaded.
 *
 * LTKRN contains an image processing library.
 *
 * @see SPSignwareStatus
 * @deprecated Use @ref SP_GRAPHICLIB_LOADED instead of SP_LEAD_LOADED
 */
#define SP_LEAD_LOADED 0x10

/**
 * @brief Library status flag: external library SPMagick loaded.
 *
 * SPMagick contains an image processing library.
 *
 * @see SPSignwareStatus
 * @deprecated Use @ref SP_GRAPHICLIB_LOADED instead of SP_MAGICK_LOADED
 */
#define SP_MAGICK_LOADED 0x10

/**
 * @brief Library status flag: external image processing library loaded.
 *
 * Either Lead Tools or SPMagick or SPFreeImage has been loaded.
 *
 * @see SPSignwareStatus
 */
#define SP_GRAPHICLIB_LOADED 0x10

/**
 * @brief Library status flag: external library SP_ImgRen loaded.
 *
 * SP_ImgRen contains the METAFONT signature renderer.
 *
 * @see SPSignwareStatus
 */
#define SP_RENDERER_LOADED 0x20

/**
 * @brief Library status flag: external library jawt loaded.
 *
 * @see SPSignwareStatus
 */
#define SP_AWT_LOADED 0x40

/**
 * @brief Library status flag: external library dstat loaded.
 *  
 * The dstat module implements the statistic compare engine 
 *  
 * @see SPSignwareStatus
 */
#define SP_DSTAT_LOADED 0x80

/**
 * @brief SignWare module: SignWare proper.
 *
 * @see SPSignwareGetVersionStrEx
 */
#define SP_SDK_MODULE       0

/**
 * @brief SignWare module: DavLib.
 *
 * @note DavLib is no longer used.
 *
 * @see SPSignwareGetVersionStrEx
 */
#define SP_DAVLIB_MODULE    1

/**
 * @brief SignWare module: dynamic compare engine (ADSV).
 *
 * @see SPSignwareGetVersionStrEx
 */
#define SP_DYNAMIC_MODULE   2

/**
 * @brief SignWare module: static compare and cleaning engine (SIVAL).
 *
 * @see SPSignwareGetVersionStrEx
 */
#define SP_STATIC_MODULE    3

/**
 * @brief SignWare module: Graphics engine (Lead Tools).
 *
 * @see SPSignwareGetVersionStrEx, SP_GRAPHICLIB_MODULE
 * @deprecated Use @ref SP_GRAPHICLIB_MODULE instead of SP_LEAD_MODULE
 */
#define SP_LEAD_MODULE      4

/**
 * @brief SignWare module: Graphics engine.
 *
 * @see SPSignwareGetVersionStrEx, SP_LEAD_MODULE, SP_MAGICK_MODULE
 */
#define SP_GRAPHICLIB_MODULE 4

/**
 * @brief SignWare module: Graphics engine (SPMagick).
 *
 * @see SPSignwareGetVersionStrEx, SP_GRAPHICLIB_MODULE
 * @deprecated Use @ref SP_GRAPHICLIB_MODULE instead of SP_MAGICK_MODULE
 */
#define SP_MAGICK_MODULE    4

/**
 * @brief SignWare module: dynamic signature renderer.
 *
 * @see SPSignwareGetVersionStrEx
 */
#define SP_RENDER_MODULE    5

/**
 * @brief SignWare module: java awt library.
 *
 * @see SPSignwareGetVersionStrEx
 */
#define SP_JAWT_MODULE      6

/**
 * @brief SignWare module: statistic engine.
 *
 * @see SPSignwareGetVersionStrEx
 */
#define SP_DSTAT_MODULE     7

/*==============================================================*
 * SPSmartcard                                                  *
 *==============================================================*/
/**
 * SPSmartcardGetInput: echo input as asteriks.
 *
 * @see SPSmartcardGetInput
 */
#define SP_SUPRESS_INPUT 1

/**
 * APDU command specifier: no field Lc, and no field Le.
 *
 * @see SPSmartcardAPDU
 */
#define SC_APDU_CASE_NONE          0

/**
 * @brief APDU command specifier: field Lc = 0, Le = 0.
 *
 * @see SPSmartcardAPDU
 */
#define SC_APDU_CASE_1             1

/**
 * @brief APDU command specifier: field Lc = 0, Le <= 256.
 *
 * @see SPSmartcardAPDU
 */
#define SC_APDU_CASE_2_SHORT       2

/**
 * @brief APDU command specifier: field Lc <= 255, Le = 0.
 *
 * @see SPSmartcardAPDU
 */
#define SC_APDU_CASE_3_SHORT       3

/**
 * @brief APDU command specifier: field Lc <= 255, Le <= 256.
 *
 * @see SPSmartcardAPDU
 */
#define SC_APDU_CASE_4_SHORT       4

/**
 * @brief APDU command specifier: field Lc = 0, Le <= 65536.
 *
 * @note Extended data fields are not supported by all smart cards,
 * it is preferred to call the command several times with a result
 * length of 256 bytes.
 *
 * @see SPSmartcardAPDU
 */
#define SC_APDU_CASE_2_EXT         5

/**
 * @brief APDU command specifier: field Lc <= 65535, Le = 0.
 *
 * @note Extended data fields are not supported by all smart cards,
 * it is preferred to call the command several times with a command
 * length of 255 bytes.
 *
 * @see SPSmartcardAPDU
 */
#define SC_APDU_CASE_3_EXT         6

/**
 * @brief APDU command specifier, field Lc <= 65535, Le <= 65536.
 *
 * @note Extended data fields are not supported by all smart cards,
 * it is preferred to call the command several times with a command
 * length of 255 and a result length of 256 bytes.
 *
 * @see SPSmartcardAPDU
 */
#define SC_APDU_CASE_4_EXT         7

/*==============================================================*
 * Tickets                                                      *
 *==============================================================*/
/**
 * @brief Ticket will be used for loading SignWare.
 *
 * @see SPSignwareSetTicket
 */
#define SP_TICKET_LOAD_SIGNWARE         1

/**
 * @brief Ticket will be used for loading the static engine.
 *
 * @see SPSignwareSetTicket
 */
#define SP_TICKET_LOAD_STATIC           2

/**
 * @brief Ticket will be used for loading the dynamic engine.
 *
 * @see SPSignwareSetTicket
 */
#define SP_TICKET_LOAD_DYNAMIC          3

/**
 * @brief Ticket will be used for loading the application.
 *
 * Use SP_TICKET_LOAD_SELF only if you have a personalized license ID.
 *
 * @see SPSignwareSetTicket, SPSignwareSetLM2
 */
#define SP_TICKET_LOAD_SELF             4

/**
 * @brief Ticket will be used for comparing signatures with the static engine.
 *
 * @see SPSignwareSetTicket
 */
#define SP_TICKET_COMPARE_STATIC        5

/**
 * @brief Ticket will be used for comparing signatures with the dynamic engine.
 *
 * @see SPSignwareSetTicket
 */
#define SP_TICKET_COMPARE_DYNAMIC       6

/**
 * @brief Ticket will be used for cleaning images using the static engine.
 *
 * @see SPSignwareSetTicket, SPImageCleanBatch, SPImageCleanLines, SPImageCleanFrames
 */
#define SP_TICKET_CLEAN                 7

/**
 * @brief Ticket will be used for capturing signatures.
 *
 * @see SPSignwareSetTicket, SPGuiAcquSetTicket, SPTabletSetTicket
 */
#define SP_TICKET_CAPTURE               9

/**
 * @brief Ticket will be used for rendering a signature.
 *
 * @see SPSignatureSetTicket, SPSignatureGetImage
 */
#define SP_TICKET_RENDER               10

/**
 * @cond INTERNAL
 */
/**
 * @brief First unused index.
 */
#define SP_TICKET_FIRST_UNUSED          11
/**
 * @endcond
 */

/*==============================================================*
 * Error codes                                                  *
 *==============================================================*/
/**
 * @brief Error code: No error.
 *
 * The function returned successfully.
 */
#define SP_NOERR     0

/**
 * @brief Error code: Parameter error.
 *
 * An invalid parameter was passed, for instance:
 *  - a NULL pointer was passed where a NULL pointer is not allowed
 *  - a numeric argument is out of range
 *  - a pointer does not point to an objects of the correct type
 *  - an object is in a state not supporting the requested operation
 *  - a buffer length is too small
 *  - a specified file cannot be opened
 *  .
 */
#define SP_PARAMERR (-1)

/**
 * @brief Error code: Java class error.
 *
 * A java class is not accessible.
 */
#define SP_CLASSERR (-2)

/**
 * @brief Error code: Java method error.
 *
 * A java method is not accessible.
 */
#define SP_METHODERR (-3)

/**
 * @brief Error code: Java field error.
 *
 * A java field is not accessible.
 */
#define SP_FIELDERR (-4)

/**
 * @brief Error code: Unsupported device or state.
 *
 * The operation could not access the requested device or an object is
 * in a state not supporting the requested operation.
 */
#define SP_UNSUPPORTEDERR   (-5)

/**
 * @brief Error code: Out of memory.
 *
 * The operation could not obtain the required amount of memory.
 */
#define SP_MEMERR   (-6)

/**
 * @brief Error code: error in static engine.
 *
 * The static engine returned an error.
 * See the log file for details.
 */
#define SP_STATICERR (-7)

/**
 * @brief Error code: Internal error.
 *
 * An unspecified internal error (such as an unexpected exception)
 * has occurred.
 */
#define SP_INTERR (-8)

/**
 * @brief Error code: Error in graphic subsystem.
 *
 * An error occured in the graphics subsystem (LeadTools).
 */
#define SP_LEADERR (-10)

/**
 * @brief Error code: Encryption or decryption failed.
 *
 * A flat file could not be encrypted or decrypted.
 */
#define SP_CRYPTERR (-11)

/**
 * @brief Error code: provided buffer is too small.
 *
 * The buffer is too small to pass the data.
 */
#define SP_BUFFERERR   (-14)

/**
 * @brief Error code: Provided data is corrupted.
 *
 * The data is corrupted, e.g. header and body do not match.
 */
#define SP_CORRUPTEDDATAERR   (-15)

/**
 * @brief Error code: Wrong Version.
 *
 * A library was found, but it does not have the correct version.
 */
#define SP_VERSIONERR   (-16)

/**
 * @brief Error code: Cannot open a file.
 *
 * A file does not exist or is not accessible.
 */
#define SP_OPENERR   (-17)

/**
 * @brief Error code: Cannot create a file.
 *
 * A file could not be created. Usually due to lack of disk space
 * or missing access rights.
 */
#define SP_CREATEERR   (-18)

/**
 * @brief Error code: cannot process a bitmap file
 *
 * A DIB (device independant bitmap) operation failed
 */
#define SP_DIBERR   (-20)

/**
 * @brief Error code: Cannot setup communication.
 *
 * Cannot setup a communication to a server.
 */
#define SP_COMMERR   (-21)

/**
 * @brief Error code: An error occured while processing a scanner request
 *
 * Cannot process a scanner capture request.
 */
#define SP_TWAINERR   (-22)

/**
 * @brief Error code: Aborted / cancelled by user.
 *
 * The requested action was aborted or cancelled by user.
 */
#define SP_CANCELERR    (-23)

/**
 * @brief Error code: Application error.
 *
 * The application may not call the function at this time.
 */
#define SP_APPLERR    (-24)

/**
 * @brief Error code: Busy error.
 *
 * The requested resource or device is currently busy.
 */
#define SP_BUSYERR (-25)

/**
 * @brief Error code: Unspecified file I/O error.
 *
 * A file I/O operation failed.  See the log file for details.
 */
#define SP_FILEERR   (-26)

/**
 * @brief Error code: Error in dynamic engine.
 *
 * The dynamic engine returned an error.
 * See the log file for details.
 */
#define SP_DYNAMICERR (-27)

/**
 * @brief Error code: Tablet not accessible.
 *
 * The tablet not connected, not installed, or not accessible.
 */
#define SP_NOPADERR (-28)

/**
 * @brief Error code: Library error.
 *
 * Cannot load a library.
 */
#define SP_LINKLIBRARYERR   (-29)

/**
 * @brief Error code: a device is offline.
 */
#define SP_OFFLINEERR   (-31)

/**
 * @brief Error code: Smart card driver error.
 *
 * Error when calling the smart card driver.
 */
#define SP_SMARTCARDERR   (-32)

/**
 * @brief Error code: Smart card checksum error.
 *
 * Error during smart card verify pin commands.
 */
#define  SP_CHECKSUMERR   (-33)

/**
 * @brief Error code: License error.
 *
 * Missing license for a license-restricted operation.
 * The license is missing, the allowed quota has been exceeded,
 * a ticket has not been set (for the ticket license model),
 * the license has expired, the license cannot be used on this
 * machine, or there is a problem with license setup.
 */
#define SP_LICENSEERR   (-34)

/**
 * @brief Error code: Invalid value or operation.
 */
#define SP_INVALIDERR   (-35)

/**
 * @brief Error code: Attempt to compare identical signatures.
 */
#define SP_IDENTICERR (-38)

/**
 * @brief Error code: Error in graphics engine.
 *
 * An error occured in the graphics subsystem.
 * See the log file for details.
 */
#define SP_GRAPHICERR (-39)

/**
 * @brief Error code: Error in graphics engine.
 *
 * An error occured in the graphics subsystem.
 * See the log file for details.
 * @deprecated Use @ref SP_GRAPHICERR instead of SP_MAGICKERR
 */
#define SP_MAGICKERR (-39)

/**
 * @brief Error code: a timeout occured.
 */
#define SP_TIMEOUTERR (-40)

/*==============================================================*
 * Structures and type definitions                              *
 *==============================================================*/
/**
 * @brief Pointer to an SPAcquire object.
 *
 * SPAcquire objects capture signature(s) on a tablet without Gui. 
 * SPGuiAcqu is similar to SPAcquire but adds a user interface.
 *
 * @see SPAcquire.h, SPAcquireCreate, SPAcquireFree
 */
typedef struct SDKACQUIRE_S * pSPACQUIRE_T;


/**
 * @brief Pointer to an SPBackgroundObjects container.
 *
 * A SPBackgroundObjects contains:
 *  - name of the referencing device
 *  - a set of background objects to compose the entire background image
 *  .
 * 
 * @see SPBackgroundObjects.h, SPBackgroundObjectsCreateFromFile, SPBackgroundObjectsCreateFromXML, SPBackgroundObjectsFree
 */
typedef struct SDKBACKGROUNDOBJECTS_S * pSPBACKGROUNDOBJECTS_T;

/**
 * @brief Pointer to an SPCompare object.
 *
 * A SPCompare object contains:
 *  - parameters for comparing signatures and reference
 *  - the result of the comparison
 *  - the match level achieved by the comparison.
 *  .
 * Use the appropriate SPCompareSet and SPCompareGet functions to
 * access the parameters and results.
 *
 * @see SPCompare.h, SPCompareCreate, SPCompareFree
 */
typedef struct SDKCOMPARE_S * pSPCOMPARE_T;

/**
 * @brief Pointer to an SPGuiAcqu object.
 *
 * SPGuiAcqu objects implement the graphical user interface for capturing
 * signatures on a tablet.
 *
 * @see SPGuiAcqu.h, SPGuiAcquCreate, SPGuiAcquFree
 */
typedef struct SDKGUIACQU_S * pSPGUIACQU_T;

/**
 * @brief Pointer to an SPGuiContainer object.
 *
 * SPGuiContainer objects capture signatures.
 *
 * @see SPGuiContainer.h, SPGuiContainerCreate, SPGuiContainerFree
 */
typedef struct SDKGUICONTAINER_S * pSPGUICONTAINER_T;

/**
 * @brief Pointer to an SPGuiDisp object.
 *
 * SPGuiDisp objects display signatures and their static features.
 *
 * @see SPGuiDisp.h, SPGuiDispCreate, SPGuiDispFree
 */
typedef struct SDKGUIDISP_S * pSPGUIDISP_T;

/**
 * @brief Pointer to an SPGuiDyn object.
 *
 * SPGuiDyn objects display the dynamic features of dynamic signatures.
 *
 * @see SPGuiDyn.h, SPGuiDynCreate, SPGuiDynFree
 */
typedef struct SDKGUIDYN_S * pSPGUIDYN_T;

/**
 * @brief Pointer to an SPImage object.
 *
 * A SPImage object contains a static image.  SPImage objects are used
 * for cleaning static signatures.
 *
 * @see SPImage.h, SPImageCreate, SPImageFree
 */
typedef struct SDKIMAGE_S * pSPIMAGE_T;

/**
 * @brief Pointer to an SPReference object.
 *
 * A SPReference object is a collection of signature objects forming
 * a signature reference.
 *
 * Use the appropriate SPReferenceGet functions to
 * access the contents of the object.
 *
 * @see SPReference.h, SPReferenceCreate, SPReferenceCreateFromFlatFile, SPReferenceFree
 */
typedef struct SDKREFERENCE_S * pSPREFERENCE_T;

/**
 * @brief Pointer to an SPSignature object.
 *
 * A SPSignature object contains a dynamic signature, ie, biometric data
 * and information about the tablet used for capturing the signature.
 *
 * Use the appropriate SPSignatureSet and SPSignatureGet functions to
 * access the contents of the object.
 *
 * @see SPSignature.h, SPSignatureCreate, SPSignatureFree
 */
typedef struct SDKSIGNATURE_S * pSPSIGNATURE_T;

/**
 * @brief Pointer to an SPSmartCard object.
 *
 * A SPSmartcard object contains the identifier of the smart card driver
 * and the smart card device.
 *
 * Use the appropriate SPSmartcardGet functions to
 * access the contents of the object.
 *
 * @see SPSmartcard.h, SPSmartcardCreate, SPSmartcardFree
 */
typedef struct SDKSMARTCARD_S * pSPSMARTCARD_T;

/**
 * @brief Pointer to an SPSmartcardDriver object.
 *
 * A SPSmartcardDriver object contains the identifier of a
 * smart card driver.
 *
 * @see SPSmartcardDriver.h, SPSmartcardDriverCreateByIndex, SPSmartcardDriverFree
 */
typedef struct SDKSMARTCARDDRIVER_S * pSPSMARTCARDDRIVER_T;

/**
 * @brief Pointer to an SPTablet object.
 *
 * A SPTablet object conains the identifier of the tablet, the size and
 * resolution of the tablet, and any registered listeners.
 *
 * Use the appropriate SPTabletSet and SPTabletGet functions to
 * access the contents of the object.
 *
 * @see SPTablet.h, SPTabletCreate, SPTabletFree
 */
typedef struct SDKTABLET_S * pSPTABLET_T;

/**
 * @brief Pointer to an SPTabletEnum object.
 *
 * A SPTabletEnum object conains the descriptors to all devices 
 * for a specific tablet class.
 *
 * @see SPTablet.h, SPTabletEnumCreate, SPTabletEnumFree
 */
typedef struct SDKTABLETENUM_S * pSPTABLETENUM_T;

/**
 * @brief Pointer to an SPTeller object.
 *
 * A SPTeller object interfaces with SignBase&reg;.
 *
 * @see SPTeller.h, SPTellerCreate, SPTellerFree
 */
typedef struct SDKTELLER_S * pSPTELLER_T;

/**
 * @brief Pointer to an SPTemplate object.
 *
 * A SPTemplate object is a compressed representation of a signature
 * reference. It is optimized for minimum storage space.
 *
 * Use the appropriate SPTemplateGet functions to
 * access the contents of the object.
 *
 * @see SPTemplate.h, SPTemplateCreateFromReference, SPTemplateFree
 */
typedef struct SDKTEMPLATE_S * pSPTEMPLATE_T;

/**
 * @brief Pointer to an SPTicket object.
 *
 * SPTickets objects are used in a network license environment. The
 * application must 'buy' tickets from the license server, and pass
 * them to the ticket consumer. The ticket consumer uses the ticket to
 * ask the License Manager if a certain action can be executed with
 * the provided ticket.
 *
 * @deprecated Please use a license key.
 *
 * @see SPTicket.h, SPTicketCreate, SPTicketFree, SP_LICENSEERR
 */
typedef struct SDKTICKET_S * pSPTICKET_T;

/**
 * @brief Opaque type for SPTellerImage objects.
 *
 * The structure is defined in SpSigInt.h.
 */
struct SP_IMAGEDATA_S;

/**
 * @brief Pointer to a an SPTellerImage object.
 *
 * SPTellerImage objects are used to pass images from SignWare to SignBase
 * using the Teller interface.
 *
 * @see SPTeller.h, SPTellerImageCreateFromSignature, SPTellerImageFree
 */
typedef struct SP_IMAGEDATA_S* pSPTELLERIMAGE_T;

/**
 * @brief Pointer to an SPCleanParameter object.
 *
 * An SPCleanParameter object contains parameters used for cleaning
 * static signatures.
 *
 * @see SPCleanParameter.h, SPCleanParameterCreate, SPCleanParameterFree
 */
typedef struct SDKCLEANPARAMETER_S *pSPCLEANPARAMETER_T;

/**
 * @brief Pointer to a PropertyMap object.
 */
typedef struct SDKPROPERTYMAP_S *pSPPROPERTYMAP_T;

/**
 * @brief Pointer to a Scanner object.
 */
typedef struct SDKSCANNER_S *pSPSCANNER_T;

/**
 * @brief Pointer to a ScannerEnum object.
 */
typedef struct SDKSCANNERENUM_S *pSPSCANNERENUM_T;

/**
 * @brief Pointer to a LicenseClient object.
 *
 * @deprecated Please use a license key.
 */
typedef struct SDKLICENSECLIENT_S * pSPLICENSECLIENT_T;

/**
 * @brief SPDOUBLE is an IEEE 754 double-precision floating-point number.
 */
typedef double SPDOUBLE;

/**
 * @brief SPFLOAT is an IEEE 754 single-precision floating-point number.
 */
typedef float SPFLOAT;

/**
 * @brief SPBOOL is a boolean.
 */
typedef int SPBOOL;

/**
 * @brief SPINT32 is a 32-bit signed integer.
 */
typedef int SPINT32;

/**
 * @brief SPUINT32 is a 32-bit unsigned integer.
 */
typedef unsigned int SPUINT32;

/**
 * @brief SPUCHAR is an unsigned 8-bit character (byte).
 */
typedef unsigned char SPUCHAR;

/**
 * @brief SPCHAR is an 8-bit character.
 */
typedef char SPCHAR;

/**
 * @brief SPWCHAR is a wide character (16 bits for Windows, 32 bits for Linux).
 */
typedef wchar_t SPWCHAR;

/**
 * @brief SPVPTR is a void pointer
 *
 * The size of a pointer depends on the operating system:
 *      - 32 Bit operating system: a Pointer is a 32 bit unsigned value
 *      - 64 Bit operating system: a Pointer is a 64 bit unsigned value
 *      .
 */
typedef void *SPVPTR;

/**
 * @cond INTERNAL
 *
 * Internal use only
 */
/**
 * @brief Compatibility with older versions
 */
/* typedef SPVPTR SPVOIDPTR; */
/**
 * @brief SPJLONG is a Java long value, a 64 bit signed value
 */
#if defined (__WINDOWS__) || defined (_WIN32)
typedef __int64 SPJLONG;
#elif defined (SP_TARGET_POSIX)
typedef int64_t SPJLONG;
#endif
/**
 * @endcond
 */
/**
 * @brief SPHWND is a window handle.
 */
#if defined (__WINDOWS__) || defined (_WIN32)
typedef HWND SPHWND;
#elif defined (SP_TARGET_POSIX)
typedef void * SPHWND;
#endif


/**
 * @brief SPINSTANCE is a DLL instance handle.
 */
#if defined (__WINDOWS__) || defined (_WIN32)
typedef HINSTANCE SPINSTANCE;
#elif defined (SP_TARGET_POSIX)
typedef void * SPINSTANCE;
#endif

/**
 * @brief SPMODULE is a DLL handle (shared library handle).
 */
#if defined (__WINDOWS__) || defined (_WIN32)
typedef HMODULE SPMODULE;
#elif defined (SP_TARGET_POSIX)
typedef void * SPMODULE;
#endif

/**
 * @brief A rectangle bounding a set of pixels.
 *
 * The coordinates are absolute screen or image coordinates.
 *
 * @see SPGuiAcquRegisterRect, SPImageRegion, SPImageMaskImage etc
 * @todo Define inclusive/exclusive.
 */
typedef struct SPRECT_S
{
    /**
     * @brief Left coordinate of the rectangle.
     */
    int left;

    /**
     * @brief Top coordinate of a the rectangle.
     */
    int top;

    /**
     * @brief Right coordinate of the rectangle.
     */
    int right;

    /**
     * @brief Bottom coordinate of the rectangle.
     */
    int bottom;
} SPRECT_T, *pSPRECT_T;

/**
 * @brief A weighted frame.
 *
 * Weighted frames are used to clean static images. The image is analyzed and
 * broken into smaller rectangles, each rectangle is assigned a weight in the
 * range 0 .. 1.0, a higher weights indicates a probability that the contents
 * of the rectangle belong to a signature stroke.
 *
 * @see SPGuiDispSetWeightedFrames, SPImageGetFrames
 */
typedef struct SP_WEIGHTED_FRAME_S
{
    /**
     * @brief Rectangle for this frame.
     */
    SPRECT_T rcl;
    /**
     * @brief Weight for this frame.
     */
    SPDOUBLE dWeight;
} SP_WEIGHTED_FRAME_T, *pSP_WEIGHTED_FRAME_T;

/*==============================================================*
 * Function declarations                                        *
 *==============================================================*/
#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

/**
 * @brief Get the SignWare version as a string.
 *
 * @param pszVersion [o]
 *      pointer to a buffer that will be filled with the version
 *      number of SignWare as a string.
 * @param iLen [i]
 *      size (in bytes) of the buffer pointed to by @a pszVersion,
 *      must be at least 12.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      @a pszVersion is NULL or @a iLen is too small
 *   .
 * @see SPSignwareGetVersionInt, SPSignwareGetVersionStrEx
 */
SPEXTERN SPINT32 SPLINK SPSignwareGetVersionStr(SPCHAR *pszVersion, SPINT32 iLen);

/**
 * @brief Get the SignWare version as an integer.
 *
 * The components of the version number can be extracted this way
 * from the returned value @a iValue:
 * - major version number:   ((iVersion >> 28) & 0xf
 * - minor version number:   ((iVersion >> 20) & 0xff
 * - release version number: ((iVersion >>  0) & 0xfff
 * .
 *
 * @param piVersion [o]
 *      pointer to a variable that will be filled with the version number
 *      of SignWare.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      @a piVersion is NULL
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPSignwareGetVersionStr, SPSignwareGetVersionStrEx
 */
SPEXTERN SPINT32 SPLINK SPSignwareGetVersionInt(SPINT32 *piVersion);

/**
 * @brief Get the version of a SignWare module as a string.
 *
 * @param iModule [i]
 *      identify the module whose  version number is requested:
 *      - SP_SDK_MODULE         get version number of SignWare
 *      - SP_DYNAMIC_MODULE     get version number of the dynamic engine
 *      - SP_STATIC_MODULE      get version number of the static engine
 *      - SP_LEAD_MODULE        get version number of Lead Tools
 *      - SP_GRAPHLIB_MODULE    get version number of SPFreeImage
 *      .
 * @param pszVersion [o]
 *      pointer to a buffer that will be filled with the version
 *      number as a string.
 * @param iLen [i]
 *      size (in bytes) of the buffer pointed to by @a pszVersion,
 *      must be at least 12.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      @a iModule is invalid, @a pszVersion is NULL, or @a iLen is too small
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPSignwareGetVersionStr, SPSignwareGetVersionInt
 */
SPEXTERN SPINT32 SPLINK SPSignwareGetVersionStrEx(SPINT32 iModule, SPCHAR *pszVersion, SPINT32 iLen);

/**
 * @brief Check if a SignWare object is an SPCleanParameter object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPCleanParameter object
 *  - 1: the object is an SPCleanParameter object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 * @see SPCleanParameter.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsCleanParameter (SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPCompare object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPCompare object
 *  - 1: the object is an SPCompare object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 * @see SPCompare.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsCompare(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPGuiAcqu object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPGuiAcqu object
 *  - 1: the object is an SPGuiAcqu object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPGuiAcqu.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsGuiAcqu(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPGuiContainer object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPGuiContainer object
 *  - 1: the object is an SPGuiContainer object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPGuiContainer.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsGuiContainer(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPGuiDisp object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPGuiDisp object
 *  - 1: the object is an SPGuiDisp object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPGuiDisp.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsGuiDisp(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPGuiDyn object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPGuiDyn object
 *  - 1: the object is an SPGuiDyn object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPGuiDyn.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsGuiDyn(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPImage object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPImage object
 *  - 1: the object is an SPImage object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPImage.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsImage(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPLicenseClient object.
 *
 * @deprecated Please use a license key.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPLicenseClient object
 *  - 1: the object is an SPLicenseClient object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 * @see SPLicenseClient.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsLicenseClient(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPReference object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPReference object
 *  - 1: the object is an SPReference object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPReference.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsReference(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPScanner object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPScanner object
 *  - 1: the object is an SPScanner object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPScanner.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsScanner(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPScannerEnum object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPScannerEnum object
 *  - 1: the object is an SPScanner object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPScanner.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsScannerEnum(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPSignature object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPSignature object
 *  - 1: the object is an SPSignature object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPSignature.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsSignature(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPSmartcard object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPSmartcard object
 *  - 1: the object is an SPSmartcard object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPSmartcard.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsSmartcard(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPSmartcardDriver object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPSmartcardDriver object
 *  - 1: the object is an SPSmartcardDriver object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPSmartcardDriver.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsSmartcardDriver(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPTablet object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPTablet object
 *  - 1: the object is an SPTablet object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTablet.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsTablet(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPTabletEnum object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPTabletEnum object
 *  - 1: the object is an SPTabletEnum object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTablet.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsTabletEnum(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPTeller object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPTeller object
 *  - 1: the object is an SPTeller object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTeller.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsTeller(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPTemplate object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPTemplate object
 *  - 1: the object is an SPTemplate object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPTemplate.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsTemplate(SPVPTR pPtr);

/**
 * @brief Check if a SignWare object is an SPTicket object.
 *
 * @deprecated Please use a license key.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPTicket object
 *  - 1: the object is an SPTicket object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 * @see SPTicket.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsTicket(SPVPTR pPtr);

/**
 * @cond INTERNAL
 */
/**
 * @brief Check if a SignWare object is an SPCompare object.
 *
 * @param pPtr [i] pointer to a SignWare object.
 * @return
 *  - 0: the object is not an SPCompare object
 *  - 1: the object is an SPCompare object
 *  - @ref SP_INTERR "": an error occurred (the object is not a SignWare object)
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPCompare.h
 */
SPEXTERN SPINT32 SPLINK SPSignwareIsPropertyMap(SPVPTR pPtr);
/**
 * @endcond
 */

/**
 * @brief Get the status of the SignWare SDK.
 *
 * @param piStatus [o]
 *      pointer to a variable that will be filled with an integer
 *      containing one bit per external library.  A bit is set if
 *      the corresponding library is loaded.
 * @return @ref SP_NOERR if successful, else error code:
 *    - @ref SP_PARAMERR   invalid parameter
 *    .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SP_DYNAMIC_LOADED, SP_STATIC_LOADED, SP_GRAPHICLIB_LOADED, SP_RENDERER_LOADED
 */
SPEXTERN SPINT32 SPLINK SPSignwareStatus(SPINT32 *piStatus);

/**
 * @brief Convert a SignWare error code to an English text.
 *
 * This function is used within SOFTPRO, but is not generally available
 * as the returned message is always in English and will not be translated.
 *
 * The returned string must not be modified.  The returned pointer
 *  is valid until SPSignwareGetErrorString is called again.
 *
 * @param iErrCode [i]
 *      an error code that was returned by a SignWare function.
 * @return pointer to a string containing the error message in English.
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @todo Make the return value a const pointer.
 */
SPEXTERN const SPCHAR * SPLINK SPSignwareGetErrorString(SPINT32 iErrCode);

/**
 * @brief Get the current time as a signature timestamp.
 *
 * @param piTime [o]
 *      pointer to a variable that will be filled with the
 *      current time in seconds since 1970-01-01 00:00:00 UTC.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPSignatureGetTimeStamp, SPSignatureSetTimeStamp
 */
SPEXTERN SPINT32 SPLINK SPSignwareGetCurrentTime(SPUINT32 *piTime);

/**
 * @brief Get the current time as a signature timestamp.
 *
 * @param piTime [o]
 *      pointer to a variable that will be filled with the
 *      current time in seconds since 1970-01-01 00:00:00 UTC.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @deprecated Replaced by @ref SPSignwareGetCurrentTime.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPSignwareGetCurrentTime, SPSignatureGetTimeStamp, SPSignatureSetTimeStamp
 */
SPEXTERN SPINT32 SPLINK SPSignwareGetActualTime(SPUINT32 *piTime);

/**
 * @brief Pass a license ticket.
 *
 * When using ticket license, you must pass a ticket before you can create
 * any SignWare object (except for SPTicket).
 * This function copies the SPTicket object.
 *
 * The ticket must be charged for one of these actions:
 *      - @ref SP_TICKET_LOAD_SIGNWARE
 *      - @ref SP_TICKET_LOAD_STATIC
 *      - @ref SP_TICKET_LOAD_DYNAMIC
 *      - @ref SP_TICKET_LOAD_SELF
 *      - @ref SP_TICKET_CLEAN
 *      - @ref SP_TICKET_RENDER
 *      - @ref SP_TICKET_CAPTURE
 *      .
 * @deprecated Please use a license key.
 *
 * @param pTicket [i]
 *      pointer to an SPTicket object that has been charged for the
 *      desired action.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 * @see SPTicketCreate, SPTicketCharge, SPCompareSetTicket
 */
SPEXTERN SPINT32 SPLINK SPSignwareSetTicket(pSPTICKET_T pTicket);

/**
 * @brief Display a dialog box showing license information.
 *
 * @param hwndParent [i] parent window handle.
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_LICENSEERR  license not found or setup problem
 *   .
 * @deprecated Replaced by @ref SPSignwareViewLM2, call SPSignwareViewLM2(hwndParent, NULL).
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPSignwareViewLM2
 */
SPEXTERN SPINT32 SPLINK SPSignwareViewLM(SPHWND hwndParent);

/**
 * @brief Display a dialog box showing license information.
 *
 * The License Viewer is based on Qt. Mixing different Qt versions within
 * the same process can cause problems. Passing the Qt version will
 * cause SignWare to check for compatible Qt versions and disable the
 * dialog box when conflicting versions are encountered.
 *
 * @param hwndParent [i]
 *      parent window handle.
 * @param pszOptions [i]
 *      a set of additional string parameters, separated by ';' characters:
 *      - <b>option1</b> the language identifier for the dialog:
 *          - de german
 *          - en US english (default)
 *          - uk UK english
 *          .
 *      - <b>option2</b> the Qt version or empty if this is not a
 *        Qt application. You can obtain the Qt version by calling qVersion().
 *        <br> Example: '4.5.3'
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_LICENSEERR  license not found or setup problem
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPSignwareViewLM2(SPHWND hwndParent, const char *pszOptions);

/**
 * @brief Get the number of days left until the license expires.
 *
 * @param piNumDays [o]
 *      pointer to a variable that will be filled with the number of days
 *      left until the license expires. Special vales are:
 *      - -1 license has already expired
 *      - 0 license will expire today
 *      - 1 license will expire tomorrow
 *      - 0x7FFFFFFF license is unlimited (more than 4 years)
 *      .
 * @return @ref SP_NOERR for success, else error code.
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 */
SPEXTERN SPINT32 SPLINK SPSignwareDaysLM(SPINT32 *piNumDays);

/**
 * @cond INTERNAL
 */
/**
 * @brief Set the license ID.
 *
 * This function is reserved for SOFTPRO internal use and
 * will not be available in future versions of SignWare.
 *
 * @param iLm2Id [i] license ID.
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_PARAMERR     license ID already set
 *   - @ref SP_LICENSEERR   invalid license ID or license setup problem
 *   .
 * @deprecated Replaced by @ref SPSignwareSetLM2 and @ref SPSignwareSetLicenseKey.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 * @see SPSignwareSetLM2, SPSignwareSetLicenseKey
 */
SPEXTERN SPINT32 SPLINK SPSignwareSetLM(SPINT32 iLm2Id);
/**
 * @endcond
 */

/**
 * @brief Set the license ID.
 *
 * The license ID tells the License Manager which license file to choose,
 * and to read the allowed licensed actions from that file. SOFTPRO may generate
 * custom license ID's on request. Please contact your SOFTPRO sales representative.
 *  
 * @note The standard SignWare license ID is (809213154, 373825325) 
 * @note The Signware Capture license ID is  (1782290325, 766889438). The application must 
 * initialize the license manager if it wants to use a SignwareCapture-License. 
 *
 * @deprecated Please use Spsignwaresetlicensekey().
 *
 * @param iLm2Id_1 [i] first part of license ID.
 * @param iLm2Id_2 [i] second part of license ID.
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_PARAMERR     license ID already set
 *   - @ref SP_LICENSEERR   invalid license ID or license setup problem
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 * @see SPSignwareSetLicenseKey
 */
SPEXTERN SPINT32 SPLINK SPSignwareSetLM2(SPINT32 iLm2Id_1, SPINT32 iLm2Id_2);

/**
 * @brief Set the license key.
 *
 * A license key tells the License Manager which actions are allowed.
 * Please contact your SOFTPRO sales representative.
 *
 * @param pKey [i] pointer to the first character of the license key.
 * @param iKey [i] the size (in bytes) of the license key.
 * @param pszProduct [i] Must be NULL.
 * @param pszVersion [i] Must be NULL.
 * @param pToken [i] NULL or pointer to the first octet of the token.
 *                   Should be NULL.
 * @param iToken [i] the size (in bytes) of the token. Must be 0 if
 *                   @a pToken is NULL.
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_PARAMERR     license key already set
 *   - @ref SP_LICENSEERR   invalid license key
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 */
SPEXTERN SPINT32 SPLINK SPSignwareSetLicenseKey(const void *pKey, SPINT32 iKey,
                                                const char *pszProduct, const char *pszVersion,
                                                const void *pToken, SPINT32 iToken);

/**
 * @brief Check if a license is available for a certain action.
 *
 * If the ticket license model is used, you must create and pass
 * a ticket charged for the action to SignWare (see @ref SPSignwareSetTicket)
 * before calling this function.
 *
 * @param iAction [i]
 *      the license action to check:
 *      - @ref SP_TICKET_LOAD_SELF
 *      .
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_LICENSEERR no license is available
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPSignwareSetTicket
 */
SPEXTERN SPINT32 SPLINK SPSignwareCheckLM(SPINT32 iAction);

/**
 * @brief Query the installation code
 *
 * @param pchInstallationCode [io] pointer to a buffer with a length of at least 25 characters
 * that will be filled with the installation code (zero terminated string)
 * @param iLen [i] length of the provided buffer [in bytes]
 * @return int
 *      - @ref SP_NOERR success
 *      - @ref SP_MEMERR buffer too small
 *      - @ref SP_LICENSEERR no license available
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPSignwareGetInstallationCode(SPCHAR *pchInstallationCode, SPINT32 iLen);

/**
 * @brief Inform the License Manager about a new session.
 *
 * This function is reserved for SOFTPRO internal use.
 *
 * @deprecated Please use a license key.
 *
 * @param iAction [i]
 *      license action (@ref SP_TICKET_LOAD_SIGNWARE etc.).
 * @param pszSession [i]
 *      session identifier, subsequent calls to @ref SPTicketCharge must
 *      use the same session identifier. A session identifier is an
 *      arbitrary UTF-8-encoded string identifying uniquely a session.
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 */
SPEXTERN SPINT32 SPLINK SPSignwareOpenSession(SPINT32 iAction, const SPCHAR *pszSession);

/**
 * @brief Inform the License Manager about termination of a session.
 *
 * This function is reserved for SOFTPRO internal use.
 *
 * @deprecated Please use a license key.
 *
 * @param iAction [i]
 *      license action (@ref SP_TICKET_LOAD_SIGNWARE etc.).
 * @param pszSession [i]
 *      session identifier, subsequent calls to @ref SPTicketCharge must
 *      use the same session identifier. A session identifier is an
 *      arbitrary UTF-8-encoded string identifying uniquely a session.
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 */
SPEXTERN SPINT32 SPLINK SPSignwareCloseSession(SPINT32 iAction, const SPCHAR *pszSession);

/**
 * @brief Check if tickets are required for the current license model.
 *
 * Do not call this funcction before you have set the license ID
 * (unless you want to use the default license ID).
 *
 * @deprecated Please use a license key.
 *
 * @param piNeeded [o]
 *      pointer to a variable that will be set to 0 if tickets are
 *      not used or to 1 if tickets are required.
 * @return @ref SP_NOERR for success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a)
 */
SPEXTERN SPINT32 SPLINK SPSignwareNeedTicket(SPINT32 *piNeeded);

/**
 * @brief Convert a Unicode string to an UTF-8 string.
 *
 * @param pUnicode [i]
 *      the null-terminated Unicode string to be converted.
 * @param ppszUtf8 [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of characters containing the null-terminated
 *      UTF-8 encoding of the string pointed to by @a pUnicode.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in bytes) of the UTF-8 string on success, a negative
 *   value on error
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPUnicodeToAnsi, SPUtf8ToUnicode
 */
SPEXTERN SPINT32 SPLINK SPUnicodeToUtf8(const SPWCHAR *pUnicode, SPCHAR** ppszUtf8);

/**
 * @brief Convert a UTF-8 string to a Unicode string.
 *
 * @param pszUtf8 [i]
 *      the null-terminated UTF-8 string to be converted.
 * @param ppUnicode [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of wide characters containing the null-terminated
 *      Unicode encoding of the string pointed to by @a pszUtf8.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in wide characters) of the Unicode string on success,
 *   a negative value on error
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPUnicodeToUtf8, SPUtf8ToAnsi
 */
SPEXTERN SPINT32 SPLINK SPUtf8ToUnicode(const SPCHAR *pszUtf8, SPWCHAR **ppUnicode);

/**
 * @brief Convert a Unicode string to an ANSI string.
 *
 * This function converts to the current system Windows ANSI codepage.
 *
 * @param pUnicode [i]
 *      the null-terminated Unicode string to be converted.
 * @param ppszAnsi [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of characters containing the null-terminated
 *      ANSI encoding of the string pointed to by @a pUnicode.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in bytes) of the ANSI string on success,
*          a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPAnsiToUnicode, SPUnicodeToUtf8
 */
SPEXTERN SPINT32 SPLINK SPUnicodeToAnsi(const SPWCHAR *pUnicode, SPCHAR **ppszAnsi);

/**
 * @brief Convert an ANSI string to a Unicode string.
 *
 * This function converts from the current system Windows ANSI
 * codepage.
 *
 * @param pszAnsi [i]
 *      the null-terminated ANSI string to be converted.
 * @param ppUnicode [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of wide characters containing the null-terminated
 *      Unicode encoding of the string pointed to by @a pszAnsi.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in wide characters) of the Unicode string on success,
 *         a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPUnicodeToAnsi, SPAnsiToUtf8
 */
SPEXTERN SPINT32 SPLINK SPAnsiToUnicode(const SPCHAR *pszAnsi, SPWCHAR **ppUnicode);

/**
 * @brief Convert an ANSI string to a UTF-8 string.
 *
 * This function converts from the current system Windows ANSI
 * codepage.
 *
 * @param pszAnsi [i]
 *      the null-terminated ANSI string to be converted.
 * @param ppszUtf8 [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of characters containing the null-terminated
 *      UTF-8 encoding of the string pointed to by @a pszAnsi.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in bytes) of the UTF-8 string on success,
 *         a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPAnsiToUnicode, SPUtf8ToAnsi
 */
SPEXTERN SPINT32 SPLINK SPAnsiToUtf8(const SPCHAR *pszAnsi, SPCHAR **ppszUtf8);

/**
 * @brief Convert a UTF-8 string to an ANSI string.
 *
 * This function converts to the current system Windows ANSI codepage.
 *
 * @param pszUtf8 [i]
 *      the null-terminated UTF-8 string to be converted.
 * @param ppszAnsi [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of characters containing the null-terminated
 *      ANSI encoding of the string pointed to by @a pszUtf8.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in bytes) of the ANSI string on success,
 *         a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPAnsiToUtf8, SPUtf8ToUnicode
 */
SPEXTERN SPINT32 SPLINK SPUtf8ToAnsi(const SPCHAR *pszUtf8, SPCHAR **ppszAnsi);

/**
 * @brief Convert binary data to a Base64-encoded string.
 *
 * @param pbData [i]
 *      pointer to the data to be converted.
 * @param iDataLen [i]
 *      the length (in bytes) of the data to be converted.
 * @param ppszBase64 [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of characters containing the null-terminated
 *      Base64 encoding of the @a iDataLen bytes pointed to by @a pbData.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in bytes) of the Base64 string on success,
 *         a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPBase64Decode
 */
SPEXTERN SPINT32 SPLINK SPBase64Encode(const SPCHAR *pbData, int iDataLen, SPCHAR **ppszBase64);

/**
 * @brief Decode a Base64-encoded string.
 *
 * @param pszBase64 [i]
 *      pointer to the null-terminated string containing Base64-encoded
 *      data.
 * @param ppbData [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of bytes containing the decoded data.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @param piDataLen [o]
 *      pointer to a variable that will be filled with the length (in bytes)
 *      of the decoded data.
 * @return the length (in bytes) of the decoded data on success,
 *         a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPBase64Encode
 */
SPEXTERN SPINT32 SPLINK SPBase64Decode(const SPCHAR *pszBase64, SPCHAR **ppbData, int *piDataLen);

/**
 * @brief Deallocate a string or an array of bytes.
 *
 * The string or array of bytes must have been allocated by
 * @ref SPAnsiToUnicode, @ref SPAnsiToUtf8, @ref SPBase64Decode,
 * @ref SPBase64Encode, @ref SPCleanParameterGetEnableFlag,
 * @ref SPCleanParameterGetString, @ref SPCompress, @ref SPDecompress,
 * @ref SPTicketGetSession, @ref SPUnicodeToAnsi, @ref SPUnicodeToUtf8,
 * @ref SPUtf8ToAnsi, or @ref SPUtf8ToUnicode.
 *
 * @param ppData [io]
 *      pointer to a variable containing a pointer to a string
 *      or array of bytes.
 *      The variable will be set to NULL if this function succeeds.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 */
SPEXTERN SPINT32 SPLINK SPFreeString(SPCHAR **ppData);

/**
 * @brief Deallocate an array of frames or split positions.
 *
 * The array must have been allocated by @ref SPImageGetFrames
 * or @ref SPImageGetSplitPositions.
 *
 * @param ppMemory [io]
 *      pointer to a variable containing a pointer to the array.
 *      The variable will be set to NULL if this function succeeds.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 */
SPEXTERN SPINT32 SPLINK SPFreeMemory(SPUCHAR **ppMemory);

/**
 * @brief Compress data.
 *
 * This function uses ZLIB to compress data.
 *
 * @param pSrc [i]
 *      pointer to the data to be compressed.
 * @param iSrcLen [i]
 *      length (in bytes) of the data to be compressed.
 * @param ppDest [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of bytes containing the compressed data.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @param piDestLen [o]
 *      pointer to a variable that will be filled with the length (in bytes)
 *      of the compressed data.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPDecompress
 */
SPEXTERN SPINT32 SPLINK SPCompress(const SPCHAR *pSrc, SPINT32 iSrcLen, SPCHAR **ppDest, SPINT32 *piDestLen);

/**
 * @brief Decompress data.
 *
 * This function uses ZLIB to decompress data.
 *
 * @param pSrc [i]
 *      pointer to the data to be decompressed.
 * @param iSrcLen [i]
 *      length (in bytes) of the data to be decompressed.
 * @param ppDest [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of bytes containing the decompressed data.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @param piDestLen [o]
 *      pointer to a variable that will be filled with the length (in bytes)
 *      of the compressed data.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPCompress
 */
SPEXTERN SPINT32 SPLINK SPDecompress(const SPCHAR *pSrc, SPINT32 iSrcLen, SPCHAR **ppDest, SPINT32 *piDestLen);

/**
 * @brief Convert a Unicode string to an ANSI string.
 *
 * Despite its name, this function converts to the current system Windows
 * ANSI codepage.
 *
 * @param pUnicode [i]
 *      the null-terminated Unicode string to be converted.
 * @param ppszAnsi [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of characters containing the null-terminated
 *      ANSI encoding of the string pointed to by @a pUnicode.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in bytes) of the ANSI string on success,
*          a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @deprecated This function has been replaced by @ref SPUnicodeToAnsi.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPAnsiToUnicode, SPUnicodeToAnsi, SPUnicodeToUtf8
 */
SPEXTERN SPINT32 SPLINK SPUnicodeToAscii(const SPWCHAR *pUnicode, SPCHAR **ppszAnsi);

/**
 * @brief Convert an ANSI string to a Unicode string.
 *
 * Despite its name, this function converts from the current system Windows
 * ANSI codepage.
 *
 * @param pszAnsi [i]
 *      the null-terminated ANSI string to be converted.
 * @param ppUnicode [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of wide characters containing the null-terminated
 *      Unicode encoding of the string pointed to by @a pszAnsi.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in wide characters) of the Unicode string on success,
 *         a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @deprecated This function has been replaced by @ref SPAnsiToUnicode.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPAnsiToUnicode, SPUnicodeToAnsi, SPAnsiToUtf8
 */
SPEXTERN SPINT32 SPLINK SPAsciiToUnicode(const SPCHAR *pszAnsi, SPWCHAR **ppUnicode);

/**
 * @brief Convert an ANSI string to a UTF-8 string.
 *
 * Despite its name, this function converts from the current system Windows
 * ANSI codepage.
 *
 * @param pszAnsi [i]
 *      the null-terminated ANSI string to be converted.
 * @param ppszUtf8 [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of characters containing the null-terminated
 *      UTF-8 encoding of the string pointed to by @a pszAnsi.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in bytes) of the UTF-8 string on success,
 *         a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @deprecated This function has been replaced by @ref SPAnsiToUtf8.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPAnsiToUnicode, SPAnsiToUTf8, SPUtf8ToAnsi
 */
SPEXTERN SPINT32 SPLINK SPAsciiToUtf8(const SPCHAR *pszAnsi, SPCHAR **ppszUtf8);

/**
 * @brief Convert a UTF-8 string to an ANSI string.
 *
 * Despite its name, this function converts to the current system Windows
 * ANSI codepage.
 *
 * @param pszUtf8 [i]
 *      the null-terminated UTF-8 string to be converted.
 * @param ppszAnsi [o]
 *      pointer to a variable that will be filled with the address of an
 *      array of characters containing the null-terminated
 *      ANSI encoding of the string pointed to by @a pszUtf8.
 *      The caller is responsible for deallocating the array of characters
 *      by calling @ref SPFreeString.
 * @return the length (in bytes) of the ANSI string on success,
 *         a negative value on error:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @deprecated This function has been replaced by @ref SPUtf8ToAnsi.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString, SPAnsiToUtf8, SPUtf8ToAnsi, SPUtf8ToUnicode
 */
SPEXTERN SPINT32 SPLINK SPUtf8ToAscii(const SPCHAR *pszUtf8, SPCHAR **ppszAnsi);

/**
 * @brief Create a Browser ticket
 * 
 * Use SPFreeString to free the allocated ppszTicket if you no longer need the ticket.
 *
 * @note The SOFTPRO capture plugin will request a local license if the parameter Auth is omitted.
 * The plugins will return an error if the parameter Auth is passed but does not contain a valid 
 * ticket. The created ticket is valid for the specified request URL only.
 * @param pszRequestUrl [i] the URL that will also be passed to the Browserplugin in
 * the parameter sendTo
 * @param pTicket [i] optional license ticket, required if ticket licenses are used,
 * else you may pass NULL. The ticket must be charged with action SP_TICKET_CAPTURE
 * @param ppszTicket [io] a pointer to a string that will be filled with the valid 
 * ticket. Pass the result to the browser plugin in the Auth parameter
 * @return int SP_NOERR on success, else error code
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   - @ref SP_LICENSEERR    no License
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM), Android (ARMv7a), Darwin (x86_64)
 * @see SPFreeString
 */
SPEXTERN SPINT32 SPLINK SPSignwareGetBrowserTicket(const SPCHAR *pszRequestUrl, pSPTICKET_T pTicket, SPCHAR **ppszTicket);

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif  /* SPSIGNWARE_H__ */
