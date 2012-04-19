@ECHO OFF
CLS

:: This script is Copyright (c) ermo 2011-2012 and is distributed under the
:: Creative Commons Attribution-NonCommercial-ShareAlike unported v3.0 license,
:: which can be read in full at http://creativecommons.org/licenses/by-nc-sa/3.0/
::
:: Authors: ermo@NoGripRacing (S2U Unofficial Community Patch maintainer)
::          tulib202@NoGripRacing (S2U Career Mod author)
::
:: With special thanks to JDougNY@NoGripRacing for his work on unpacking and
:: dummying out files, and matt2380@NoGripRacing for kicking off the S2U UCP project
:: and suggesting that I figure out a way to make mods drop-in compatible with it.
::
:: Any remixes of this script shall include the above notices.

:: Automate the injection of relevant S2U BFF assets for the UCP.

:: Let's not pollute the system variable namespace...

SETLOCAL EnableDelayedExpansion

@ECHO.
@ECHO NFS SHIFT 2: Unleashed -- Unofficial Community Patch unpacking script
@ECHO =====================================================================
@ECHO.


:check

:: get the folder from which this batch file was run
:: and save it for future reference.
:: d = drive letter, p = folder path, 0 = references this file

SET _CWD="%~dp0"

:: This is necessary when the script is run as administrator
:: cd /d also switches drive as appropriate

IF "%CD%"=="%windir%\system32" (
  @ECHO + Looks like we were run as administrator ...
  @ECHO.
  CD /D %_CWD%
)

:: Now we should definitely be in the correct folder, 
:: but we're going to check that assumption anyway, just
:: to be on the safe side.

IF "%CD%"=="%windir%\system32" (
  @ECHO - Current working folder is:
  @ECHO  "%CD%"
  @ECHO - It is supposed to be:
  @ECHO  %_CWD%

  SET _MSG=- Aborting install because this script can't find the S2U install dir. Sorry.

  GOTO die
)

@ECHO + Working folder is:
@ECHO %_CWD% -- good.
@ECHO.

:: ensure the S2U install folder was specified as the first argument
:: OR that we were run from the S2U install folder.

:: To begin with, be opportunistic and assume that we are run
:: from the S2U install folder

SET _S2U_DIR=%_CWD%

:: If a parameter was supplied to the script, use that instead

IF NOT [%1]==[] (
  SET _S2U_DIR="%1"
)

IF NOT EXIST %_S2U_DIR%\SHIFT2U.exe (
  SET _MSG=- No SHIFT2U.exe file found in %_S2U_DIR% !
  GOTO die
)

@ECHO + Found SHIFT2U.exe in:
@ECHO %_S2U_DIR% -- good.
@ECHO.

:: check for the unpacking tool before we start

IF NOT EXIST %_CWD%quickbms.exe (
  SET _MSG=- No quickbms.exe S2U unpack tool found in %_CWD% -- aborting!
  GOTO die
)

IF NOT EXIST %_CWD%nfsshift.bms (
  SET _MSG=- No nfsshift.bms S2U BMS script found in %_CWD% -- aborting!
  GOTO die
)

@ECHO + quickbms tool found in:
@ECHO %_CWD% -- good.
@ECHO.
@ECHO During this process, around 1000 SHIFT 2: Unleashed BFF files are going
@ECHO to be unpacked, which will take a while and take up approximately 6 GB
@ECHO of storage space on your harddrive.
@ECHO.
@ECHO                                              (Press CTRL+C to quit now)
@ECHO.

:: Set up commands

SET LIST=quickbms.exe -l nfsshift.bms
SET UNPACK=quickbms.exe -o nfsshift.bms
SET DUMMYOUT=COPY /V /Y dummy.bff

:: Set up paths

SET _VER=S2U_Unpacked_version
SET _INSTALL_DIR=MODS\%_VER%
SET _TARGET=%_CWD%%_INSTALL_DIR%
SET _OUTPUTLOG=unpack_log.txt


:unpack
pause
@ECHO.

SET _UNPACK_START=%TIME%
SET _BFFCOUNT=0

SET _MSG=+ Began unpacking at %_UNPACK_START% (log in %_OUTPUTLOG%)
@ECHO %_MSG% > %_OUTPUTLOG% || GOTO die

REM goto prune

:: Ensure that the output folder exists

IF NOT EXIST %_TARGET% (
  SET _MSG=- Could not create folder %_TARGET% -- aborting!
  MKDIR %_TARGET% || GOTO die
)

:: Ensure that BFF_index folders exist 
:: MKDIR will create folders as necessary

FOR %%I IN ( Dir Drivers Tracks\Organisers Vehicles ) DO (

  IF NOT EXIST %_CWD%BFF_index\Pakfiles\%%I (
    SET _MSG=- Could not create folder %_CWD%BFF_index\Pakfiles\%%I -- aborting!
    MKDIR %_CWD%BFF_index\Pakfiles\%%I || GOTO die
  )
)

:: Huge list of files here ...

:: Pakfiles\AUDIOMOVIES.bff
:: Pakfiles\BOOTTEXTDB.bff
:: Pakfiles\BOOTUPAUDIO.bff
:: Pakfiles\BOOTUPAUDIO2.bff
:: Pakfiles\GUIBADGES.bff
:: Pakfiles\GUIBRANCHPOSTERS.bff
:: Pakfiles\GUICAREERPOSTERS.bff
:: Pakfiles\GUICARRENDERS.bff
:: Pakfiles\GUICONTROLLERIMAGES.bff
:: Pakfiles\GUIGAMEMODEBANNERS.bff
:: Pakfiles\GUIINSIGNIA.bff
:: Pakfiles\GUILOADINGTEXTURES.bff
:: Pakfiles\GUIMANUFACTURERLOGO_BIG.bff
:: Pakfiles\GUIMANUFACTURERLOGOS.bff
:: Pakfiles\GUIREGIONALFLAGS.bff
:: Pakfiles\GUIREWARDCARS.bff
:: Pakfiles\GUIRIVALINSIGNIA.bff
:: Pakfiles\GUITRACKIMAGESLOADING.bff
:: Pakfiles\GUITRACKIMAGESSELECTING.bff
:: Pakfiles\GUITRACKLOGOS.bff
:: Pakfiles\GUITRACKMAPS.bff
:: Pakfiles\GUITRACKMAPS_SMALL.bff
:: Pakfiles\GUIVIDEOTHUMBNAILS.bff
:: Pakfiles\GUIVINYLS.bff
:: Pakfiles\GUIWHEELRIMS.bff
:: Pakfiles\IGPHASEAICHARS.bff
:: Pakfiles\IGPHASECROWDS.bff
:: Pakfiles\IGPHASEFX.bff
:: Pakfiles\IGPHASELEVELSOUNDS.bff
:: Pakfiles\IGPHASEVEHICLEAUDIO.bff
:: Pakfiles\IGPHASEVEHICLEUPGRADES.bff
:: Pakfiles\Menu_Background.bff
:: Pakfiles\videomenu_background.bff


FOR %%G IN (
Pakfiles\BOOTFLOW.bff
Pakfiles\BOOTPERSISTENT.bff
Pakfiles\BOOTPSA.bff
Pakfiles\BOOTSPLASH.bff
Pakfiles\CommonVehicleTextures.bff
Pakfiles\IGPHASEACTIVATE.bff
Pakfiles\IGPHASEHUD.bff
Pakfiles\IGPHASETEMP.bff
Pakfiles\IGPHASEUSERLIVERIES.bff
Pakfiles\MenuSetup.bff
Pakfiles\MenuTextures.bff
Pakfiles\PaintShop.bff
Pakfiles\PHYSICSBOOTFLOW.bff
Pakfiles\PHYSICSMENU.bff
Pakfiles\PHYSICSPERSISTENT.bff
Pakfiles\Shaders.bff
Pakfiles\TRACKPARTICLETEXTURES.bff
Pakfiles\VEHICLECATALOGUES.bff
Pakfiles\VehicleHRLiveries.bff
Pakfiles\VEHICLEMASKS.bff
Pakfiles\WEATHERTEXTURES.bff
Pakfiles\VEHICLEUPGRADES.bff
Pakfiles\Dir\AI.bff
Pakfiles\Dir\ANIMATION.bff
Pakfiles\Dir\AUDIO.bff
Pakfiles\Dir\CAMERAS.bff
Pakfiles\Dir\CAMPAIGN.bff
Pakfiles\Dir\CHARACTERS.bff
Pakfiles\Dir\EFFECTS.bff
Pakfiles\Dir\EVENTINFO.bff
Pakfiles\Dir\GUI.bff
Pakfiles\Dir\REPLAY.bff
Pakfiles\Dir\SCRIPTS.bff
Pakfiles\Dir\TEXT.bff
Pakfiles\Drivers\Driver02_BIG_e3_m.bff
Pakfiles\Drivers\Driver02_LEGENDS_e3_m.bff
Pakfiles\Tracks\TracksGlobal.bff
Pakfiles\Tracks\Organisers\Org01.bff
Pakfiles\Tracks\Organisers\Org02.bff
Pakfiles\Tracks\Organisers\Org11.bff
Pakfiles\Vehicles\vehiclespersistent.bff
Pakfiles\Vehicles\Acura_NSX.bff
Pakfiles\Vehicles\AC_Cobra_427.bff
Pakfiles\Vehicles\Alfa_Romeo_8C.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Spider.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta.bff
Pakfiles\Vehicles\Alfa_Romeo_GTA_1600.bff
Pakfiles\Vehicles\Alpina_B6_GT3.bff
Pakfiles\Vehicles\Aston_Martin_DB9.bff
Pakfiles\Vehicles\Aston_Martin_DBR9.bff
Pakfiles\Vehicles\Aston_Martin_DBRS9.bff
Pakfiles\Vehicles\Aston_Martin_DBS_Volante.bff
Pakfiles\Vehicles\Aston_Martin_V8_Vantage_N400.bff
Pakfiles\Vehicles\AUDI_R8.bff
Pakfiles\Vehicles\AUDI_R8_LMS.bff
Pakfiles\Vehicles\Audi_R8_Spyder.bff
Pakfiles\Vehicles\AUDI_RS4.bff
Pakfiles\Vehicles\Audi_S3.bff
Pakfiles\Vehicles\Audi_S4.bff
Pakfiles\Vehicles\AUDI_TT.bff
Pakfiles\Vehicles\Austin_Mini_Cooper.bff
Pakfiles\Vehicles\Bentley_Continental.bff
Pakfiles\Vehicles\BMW_135.bff
Pakfiles\Vehicles\BMW_135_Livery.bff
Pakfiles\Vehicles\BMW_CSL_Gr4.bff
Pakfiles\Vehicles\BMW_M1.bff
Pakfiles\Vehicles\BMW_M3_E30.bff
Pakfiles\Vehicles\BMW_M3_E36.bff
Pakfiles\Vehicles\BMW_M3_E46.bff
Pakfiles\Vehicles\BMW_M3_E92.bff
Pakfiles\Vehicles\BMW_M3_GT2.bff
Pakfiles\Vehicles\BMW_M6.bff
Pakfiles\Vehicles\BMW_Z4_2010.bff
Pakfiles\Vehicles\BMW_Z4_GT3.bff
Pakfiles\Vehicles\BMW_Z4_M.bff
Pakfiles\Vehicles\bugatti_veyron.bff
Pakfiles\Vehicles\CAMARO_DP.bff
Pakfiles\Vehicles\CAMARO.bff
Pakfiles\Vehicles\Caterham_R500.bff
Pakfiles\Vehicles\CCX.bff
Pakfiles\Vehicles\CHEVROLET_C6Z06.bff
Pakfiles\Vehicles\CHEVROLET_COBALT.bff
Pakfiles\Vehicles\Chevrolet_Corvette_1967.bff
Pakfiles\Vehicles\Chevrolet_Corvette_C6R_GT1.bff
Pakfiles\Vehicles\Chevrolet_Corvette_GT3.bff
Pakfiles\Vehicles\Dodge_Challenger_RT_1971.bff
Pakfiles\Vehicles\Dodge_Challenger_SH.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8.bff
Pakfiles\Vehicles\DODGE_CHARGER_RT_69.bff
Pakfiles\Vehicles\dodge_vipersrt10.bff
Pakfiles\Vehicles\dodge_viper_twinsturbo.bff
Pakfiles\Vehicles\Ford_Capri_RS3100.bff
Pakfiles\Vehicles\Ford_Escort_Mk1.bff
Pakfiles\Vehicles\ford_escort_rs.bff
Pakfiles\Vehicles\ford_focusst.bff
Pakfiles\Vehicles\ford_focus_rs.bff
Pakfiles\Vehicles\Ford_GT40.bff
Pakfiles\Vehicles\ford_gt.bff
Pakfiles\Vehicles\Ford_GT_GT1.bff
Pakfiles\Vehicles\Ford_GT_GT3.bff
Pakfiles\Vehicles\Ford_Mustang_2010.bff
Pakfiles\Vehicles\Ford_Mustang_RTRX.bff
Pakfiles\Vehicles\Ford_Mustang_FALKEN.bff
Pakfiles\Vehicles\Gumpert_apollo.bff
Pakfiles\Vehicles\Honda_Civic_SI.bff
Pakfiles\Vehicles\Honda_S2000.bff
Pakfiles\Vehicles\Infiniti_G35.bff
Pakfiles\Vehicles\Jaguar_E_LW.bff
Pakfiles\Vehicles\Jaguar_XKR.bff
Pakfiles\Vehicles\Koenigsegg_Agera.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_GT3.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_LP560-4.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_LP640.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_R-SV_GT1.bff
Pakfiles\Vehicles\Lamborghini_Reventon_Cop.bff
Pakfiles\Vehicles\Lamborghini_Reventon.bff
Pakfiles\Vehicles\Lancia_Delta.bff
Pakfiles\Vehicles\LEXUS_IS-F.bff
Pakfiles\Vehicles\Lexus_LFA.bff
Pakfiles\Vehicles\Lotus_Cortina.bff
Pakfiles\Vehicles\lotus_elise.bff
Pakfiles\Vehicles\lotus_exige.bff
Pakfiles\Vehicles\Maserati_GT_S.bff
Pakfiles\Vehicles\Maserati_MC12.bff
Pakfiles\Vehicles\Mazda_MX5.bff
Pakfiles\Vehicles\Mazda_RX7_FC.bff
Pakfiles\Vehicles\Mazda_RX7_FC_Rival.bff
Pakfiles\Vehicles\Mazda_RX7_FC_SH.bff
Pakfiles\Vehicles\Mazda_RX8.bff
Pakfiles\Vehicles\Mazda_RX8_MadMike.bff
Pakfiles\Vehicles\McLaren_F1.bff
Pakfiles\Vehicles\mclaren_mp4-12c.bff
Pakfiles\Vehicles\mclaren_mp4-12c_sh.bff
Pakfiles\Vehicles\Mercedes_190E_Evo2.bff
Pakfiles\Vehicles\Mercedes_190E_SH.bff
Pakfiles\Vehicles\Mercedes_SL65.bff
Pakfiles\Vehicles\Mercedes_SLR722.bff
Pakfiles\Vehicles\MERCEDES_SLR_MOSS.bff
Pakfiles\Vehicles\Mercedes_SLS.bff
Pakfiles\Vehicles\Mercedes_SLS_SH.bff
Pakfiles\Vehicles\mitsubishi_evoix.bff
Pakfiles\Vehicles\Mitsubishi_EvoIX_SH.bff
Pakfiles\Vehicles\mitsubishi_evox.bff
Pakfiles\Vehicles\Nissan_240sx_Drift.bff
Pakfiles\Vehicles\Nissan_240sx.bff
Pakfiles\Vehicles\Nissan_240ZG.bff
Pakfiles\Vehicles\Nissan_240ZG_SH.bff
Pakfiles\Vehicles\Nissan_350Z.bff
Pakfiles\Vehicles\Nissan_370Z.bff
Pakfiles\Vehicles\Nissan_GT-R_GT1.bff
Pakfiles\Vehicles\Nissan_GTR_Dday.bff
Pakfiles\Vehicles\Nissan_GTR.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_Rival.bff
Pakfiles\Vehicles\Nissan_S14A.bff
Pakfiles\Vehicles\Nissan_S15.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_SH.bff
Pakfiles\Vehicles\Nissan_Skyline_R32.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_SH.bff
Pakfiles\Vehicles\Pagani_C9.bff
Pakfiles\Vehicles\Pagani_C9_Rival.bff
Pakfiles\Vehicles\Pagani_Cinque_Roadster.bff
Pakfiles\Vehicles\Pagani_Cinque_Roadster_HP.bff
Pakfiles\Vehicles\Pagani_Zonda.bff
Pakfiles\Vehicles\Pagani_Zonda_R.bff
Pakfiles\Vehicles\Porsche_911RSR74.bff
Pakfiles\Vehicles\Porsche_911RSR74_Rival.bff
Pakfiles\Vehicles\Porsche_914.bff
Pakfiles\Vehicles\Porsche_918.bff
Pakfiles\Vehicles\PORSCHE_997GT2.bff
Pakfiles\Vehicles\PORSCHE_997GT3AB.bff
Pakfiles\Vehicles\PORSCHE_997GT3RSR_Falken.bff
Pakfiles\Vehicles\PORSCHE_997GT3RSR.bff
Pakfiles\Vehicles\PORSCHE_997GT3RS.bff
Pakfiles\Vehicles\Porsche_997_CupR.bff
Pakfiles\Vehicles\PORSCHE_CARRERA_GT.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S.bff
Pakfiles\Vehicles\Radical_SR3.bff
Pakfiles\Vehicles\Renault_Megane.bff
Pakfiles\Vehicles\RX7.bff
Pakfiles\Vehicles\Scion_tC_Drag.bff
Pakfiles\Vehicles\Scion_tC.bff
Pakfiles\Vehicles\Scion_tC_TeamNFS.bff
Pakfiles\Vehicles\Seat_Leon_Cupra.bff
Pakfiles\Vehicles\Shelby_Daytona.bff
Pakfiles\Vehicles\SHELBY_GT500_67.bff
Pakfiles\Vehicles\SHELBY_TERLINGUA.bff
Pakfiles\Vehicles\Subaru_Impreza_STi.bff
Pakfiles\Vehicles\TOYOTA_corolla_ae86_dmac.bff
Pakfiles\Vehicles\TOYOTA_corolla.bff
Pakfiles\Vehicles\TOYOTA_SUPRA.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_SH.bff
Pakfiles\Vehicles\vw_golf_gti.bff
Pakfiles\Vehicles\VW_Golf_Mk1.bff
Pakfiles\Vehicles\VW_Scirocco.bff
Pakfiles\Vehicles\Acura_NSX_Cockpit.bff
Pakfiles\Vehicles\Acura_NSX_KC02.bff
Pakfiles\Vehicles\Acura_NSX_KC03.bff
Pakfiles\Vehicles\Acura_NSX_KC04.bff
Pakfiles\Vehicles\Acura_NSX_KIT02.bff
Pakfiles\Vehicles\Acura_NSX_KIT03.bff
Pakfiles\Vehicles\Acura_NSX_KIT04.bff
Pakfiles\Vehicles\Acura_NSX_Livery.bff
Pakfiles\Vehicles\AC_Cobra_427_Cockpit.bff
Pakfiles\Vehicles\AC_Cobra_427_Livery.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Livery.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Cockpit.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_KC03.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_KC04.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_KIT03.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_KIT04.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Livery.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Spider.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Spider_Cockpit.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Spider_KC03.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Spider_KC04.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Spider_KIT03.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Spider_KIT04.bff
Pakfiles\Vehicles\Alfa_Romeo_8C_Spider_Livery.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta_Livery.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta_Cockpit.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta_KC02.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta_KC03.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta_KC04.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta_KIT02.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta_KIT03.bff
Pakfiles\Vehicles\Alfa_Romeo_Giulietta_KIT04.bff
Pakfiles\Vehicles\Alfa_Romeo_GTA_1600_Livery.bff
Pakfiles\Vehicles\Alpina_B6_GT3_Livery.bff
Pakfiles\Vehicles\Alpina_B6_GT3_Cockpit.bff
Pakfiles\Vehicles\Aston_Martin_DB9_Cockpit.bff
Pakfiles\Vehicles\Aston_Martin_DB9_KC03.bff
Pakfiles\Vehicles\Aston_Martin_DB9_KC04.bff
Pakfiles\Vehicles\Aston_Martin_DB9_KIT03.bff
Pakfiles\Vehicles\Aston_Martin_DB9_KIT04.bff
Pakfiles\Vehicles\Aston_Martin_DB9_Livery.bff
Pakfiles\Vehicles\Aston_Martin_DBR9_Livery.bff
Pakfiles\Vehicles\Aston_Martin_DBR9_Cockpit.bff
Pakfiles\Vehicles\Aston_Martin_DBRS9_Livery.bff
Pakfiles\Vehicles\Aston_Martin_DBRS9_Cockpit.bff
Pakfiles\Vehicles\Aston_Martin_DBS_Volante_Livery.bff
Pakfiles\Vehicles\Aston_Martin_DBS_Volante_Cockpit.bff
Pakfiles\Vehicles\Aston_Martin_DBS_Volante_KC03.bff
Pakfiles\Vehicles\Aston_Martin_DBS_Volante_KC04.bff
Pakfiles\Vehicles\Aston_Martin_DBS_Volante_KIT03.bff
Pakfiles\Vehicles\Aston_Martin_DBS_Volante_KIT04.bff
Pakfiles\Vehicles\Aston_Martin_DBS_Volante_Livery.bff
Pakfiles\Vehicles\Aston_Martin_V8_Vantage_N400_Cockpit.bff
Pakfiles\Vehicles\Aston_Martin_V8_Vantage_N400_Livery.bff
Pakfiles\Vehicles\Aston_Martin_V8_Vantage_N400_KC03.bff
Pakfiles\Vehicles\Aston_Martin_V8_Vantage_N400_KC04.bff
Pakfiles\Vehicles\Aston_Martin_V8_Vantage_N400_KIT03.bff
Pakfiles\Vehicles\Aston_Martin_V8_Vantage_N400_KIT04.bff
Pakfiles\Vehicles\AUDI_R8_Cockpit.bff
Pakfiles\Vehicles\AUDI_R8_Livery.bff
Pakfiles\Vehicles\AUDI_R8_KC03.bff
Pakfiles\Vehicles\AUDI_R8_KC04.bff
Pakfiles\Vehicles\AUDI_R8_KIT03.bff
Pakfiles\Vehicles\AUDI_R8_KIT04.bff
Pakfiles\Vehicles\AUDI_R8_LMS_Cockpit.bff
Pakfiles\Vehicles\AUDI_R8_LMS_Livery.bff
Pakfiles\Vehicles\Audi_R8_Spyder_Livery.bff
Pakfiles\Vehicles\Audi_R8_Spyder_Cockpit.bff
Pakfiles\Vehicles\Audi_R8_Spyder_KC03.bff
Pakfiles\Vehicles\Audi_R8_Spyder_KC04.bff
Pakfiles\Vehicles\Audi_R8_Spyder_KIT03.bff
Pakfiles\Vehicles\Audi_R8_Spyder_KIT04.bff
Pakfiles\Vehicles\AUDI_RS4_Cockpit.bff
Pakfiles\Vehicles\AUDI_RS4_Livery.bff
Pakfiles\Vehicles\AUDI_RS4_KC01.bff
Pakfiles\Vehicles\AUDI_RS4_KC02.bff
Pakfiles\Vehicles\AUDI_RS4_KC03.bff
Pakfiles\Vehicles\AUDI_RS4_KC04.bff
Pakfiles\Vehicles\AUDI_RS4_KIT01.bff
Pakfiles\Vehicles\AUDI_RS4_KIT02.bff
Pakfiles\Vehicles\AUDI_RS4_KIT03.bff
Pakfiles\Vehicles\AUDI_RS4_KIT04.bff
Pakfiles\Vehicles\Audi_S3_Cockpit.bff
Pakfiles\Vehicles\Audi_S3_Livery.bff
Pakfiles\Vehicles\Audi_S3_KC01.bff
Pakfiles\Vehicles\Audi_S3_KC02.bff
Pakfiles\Vehicles\Audi_S3_KC03.bff
Pakfiles\Vehicles\Audi_S3_KC04.bff
Pakfiles\Vehicles\Audi_S3_KIT01.bff
Pakfiles\Vehicles\Audi_S3_KIT02.bff
Pakfiles\Vehicles\Audi_S3_KIT03.bff
Pakfiles\Vehicles\Audi_S3_KIT04.bff
Pakfiles\Vehicles\Audi_S4_Cockpit.bff
Pakfiles\Vehicles\Audi_S4_Livery.bff
Pakfiles\Vehicles\Audi_S4_KC01.bff
Pakfiles\Vehicles\Audi_S4_KC02.bff
Pakfiles\Vehicles\Audi_S4_KC03.bff
Pakfiles\Vehicles\Audi_S4_KC04.bff
Pakfiles\Vehicles\Audi_S4_KIT01.bff
Pakfiles\Vehicles\Audi_S4_KIT02.bff
Pakfiles\Vehicles\Audi_S4_KIT03.bff
Pakfiles\Vehicles\Audi_S4_KIT04.bff
Pakfiles\Vehicles\AUDI_TT_Cockpit.bff
Pakfiles\Vehicles\AUDI_TT_Livery.bff
Pakfiles\Vehicles\AUDI_TT_KC01.bff
Pakfiles\Vehicles\AUDI_TT_KC02.bff
Pakfiles\Vehicles\AUDI_TT_KC03.bff
Pakfiles\Vehicles\AUDI_TT_KC04.bff
Pakfiles\Vehicles\AUDI_TT_KIT01.bff
Pakfiles\Vehicles\AUDI_TT_KIT02.bff
Pakfiles\Vehicles\AUDI_TT_KIT03.bff
Pakfiles\Vehicles\AUDI_TT_KIT04.bff
Pakfiles\Vehicles\Austin_Mini_Cooper_Livery.bff
Pakfiles\Vehicles\Austin_Mini_Cooper_Cockpit.bff
Pakfiles\Vehicles\Bentley_Continental_Livery.bff
Pakfiles\Vehicles\Bentley_Continental_Cockpit.bff
Pakfiles\Vehicles\Bentley_Continental_KC03.bff
Pakfiles\Vehicles\Bentley_Continental_KC04.bff
Pakfiles\Vehicles\Bentley_Continental_KIT03.bff
Pakfiles\Vehicles\Bentley_Continental_KIT04.bff
Pakfiles\Vehicles\BMW_135_Cockpit.bff
Pakfiles\Vehicles\BMW_135_KC01.bff
Pakfiles\Vehicles\BMW_135_KC02.bff
Pakfiles\Vehicles\BMW_135_KC03.bff
Pakfiles\Vehicles\BMW_135_KC04.bff
Pakfiles\Vehicles\BMW_135_KIT01.bff
Pakfiles\Vehicles\BMW_135_KIT02.bff
Pakfiles\Vehicles\BMW_135_KIT03.bff
Pakfiles\Vehicles\BMW_135_KIT04.bff
Pakfiles\Vehicles\BMW_135_Livery.bff
Pakfiles\Vehicles\BMW_CSL_Gr4_Livery.bff
Pakfiles\Vehicles\BMW_CSL_Gr4_Cockpit.bff
Pakfiles\Vehicles\BMW_M1_Livery.bff
Pakfiles\Vehicles\BMW_M1_Cockpit.bff
Pakfiles\Vehicles\BMW_M3_E30_Livery.bff
Pakfiles\Vehicles\BMW_M3_E30_Cockpit.bff
Pakfiles\Vehicles\BMW_M3_E30_KC03.bff
Pakfiles\Vehicles\BMW_M3_E30_KC04.bff
Pakfiles\Vehicles\BMW_M3_E30_KIT03.bff
Pakfiles\Vehicles\BMW_M3_E30_KIT04.bff
Pakfiles\Vehicles\BMW_M3_E36_Cockpit.bff
Pakfiles\Vehicles\BMW_M3_E36_Livery.bff
Pakfiles\Vehicles\BMW_M3_E36_KC02.bff
Pakfiles\Vehicles\BMW_M3_E36_KC03.bff
Pakfiles\Vehicles\BMW_M3_E36_KC04.bff
Pakfiles\Vehicles\BMW_M3_E36_KIT02.bff
Pakfiles\Vehicles\BMW_M3_E36_KIT03.bff
Pakfiles\Vehicles\BMW_M3_E36_KIT04.bff
Pakfiles\Vehicles\BMW_M3_E46_Cockpit.bff
Pakfiles\Vehicles\BMW_M3_E46_Livery.bff
Pakfiles\Vehicles\BMW_M3_E46_KC02.bff
Pakfiles\Vehicles\BMW_M3_E46_KC03.bff
Pakfiles\Vehicles\BMW_M3_E46_KC04.bff
Pakfiles\Vehicles\BMW_M3_E46_KIT02.bff
Pakfiles\Vehicles\BMW_M3_E46_KIT03.bff
Pakfiles\Vehicles\BMW_M3_E46_KIT04.bff
Pakfiles\Vehicles\BMW_M3_E92_Cockpit.bff
Pakfiles\Vehicles\BMW_M3_E92_Livery.bff
Pakfiles\Vehicles\BMW_M3_E92_KC02.bff
Pakfiles\Vehicles\BMW_M3_E92_KC03.bff
Pakfiles\Vehicles\BMW_M3_E92_KC04.bff
Pakfiles\Vehicles\BMW_M3_E92_KIT02.bff
Pakfiles\Vehicles\BMW_M3_E92_KIT03.bff
Pakfiles\Vehicles\BMW_M3_E92_KIT04.bff
Pakfiles\Vehicles\BMW_M3_GT2_Cockpit.bff
Pakfiles\Vehicles\BMW_M3_GT2_Livery.bff
Pakfiles\Vehicles\BMW_M6_Livery.bff
Pakfiles\Vehicles\BMW_M6_Cockpit.bff
Pakfiles\Vehicles\BMW_M6_KC03.bff
Pakfiles\Vehicles\BMW_M6_KC04.bff
Pakfiles\Vehicles\BMW_M6_KIT03.bff
Pakfiles\Vehicles\BMW_M6_KIT04.bff
Pakfiles\Vehicles\BMW_Z4_2010_Livery.bff
Pakfiles\Vehicles\BMW_Z4_2010_Cockpit.bff
Pakfiles\Vehicles\BMW_Z4_2010_KC03.bff
Pakfiles\Vehicles\BMW_Z4_2010_KC04.bff
Pakfiles\Vehicles\BMW_Z4_2010_KIT03.bff
Pakfiles\Vehicles\BMW_Z4_2010_KIT04.bff
Pakfiles\Vehicles\BMW_Z4_GT3_Livery.bff
Pakfiles\Vehicles\BMW_Z4_GT3_Cockpit.bff
Pakfiles\Vehicles\BMW_Z4_M_KC02.bff
Pakfiles\Vehicles\BMW_Z4_M_KC03.bff
Pakfiles\Vehicles\BMW_Z4_M_KC04.bff
Pakfiles\Vehicles\BMW_Z4_M_KIT02.bff
Pakfiles\Vehicles\BMW_Z4_M_KIT03.bff
Pakfiles\Vehicles\BMW_Z4_M_KIT04.bff
Pakfiles\Vehicles\BMW_Z4_M_Cockpit.bff
Pakfiles\Vehicles\BMW_Z4_M_Livery.bff
Pakfiles\Vehicles\bugatti_veyron_KC04.bff
Pakfiles\Vehicles\bugatti_veyron_KIT04.bff
Pakfiles\Vehicles\bugatti_veyron_Cockpit.bff
Pakfiles\Vehicles\bugatti_veyron_Livery.bff
Pakfiles\Vehicles\CAMARO_DP_Cockpit.bff
Pakfiles\Vehicles\CAMARO_DP_Livery.bff
Pakfiles\Vehicles\CAMARO_KC02.bff
Pakfiles\Vehicles\CAMARO_KC03.bff
Pakfiles\Vehicles\CAMARO_KC04.bff
Pakfiles\Vehicles\CAMARO_KIT02.bff
Pakfiles\Vehicles\CAMARO_KIT03.bff
Pakfiles\Vehicles\CAMARO_KIT04.bff
Pakfiles\Vehicles\CAMARO_Cockpit.bff
Pakfiles\Vehicles\CAMARO_Livery.bff
Pakfiles\Vehicles\Caterham_R500_Cockpit.bff
Pakfiles\Vehicles\Caterham_R500_KC04.bff
Pakfiles\Vehicles\Caterham_R500_KIT04.bff
Pakfiles\Vehicles\Caterham_R500_Livery.bff
Pakfiles\Vehicles\CCX_KC04.bff
Pakfiles\Vehicles\CCX_KIT04.bff
Pakfiles\Vehicles\CCX_Livery.bff
Pakfiles\Vehicles\CCX_Cockpit.bff
Pakfiles\Vehicles\CHEVROLET_C6Z06_KC03.bff
Pakfiles\Vehicles\CHEVROLET_C6Z06_KC04.bff
Pakfiles\Vehicles\CHEVROLET_C6Z06_KIT03.bff
Pakfiles\Vehicles\CHEVROLET_C6Z06_KIT04.bff
Pakfiles\Vehicles\CHEVROLET_C6Z06_Livery.bff
Pakfiles\Vehicles\CHEVROLET_C6Z06_Cockpit.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_KC01.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_KC02.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_KC03.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_KC04.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_KIT01.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_KIT02.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_KIT03.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_KIT04.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_Livery.bff
Pakfiles\Vehicles\CHEVROLET_COBALT_Cockpit.bff
Pakfiles\Vehicles\Chevrolet_Corvette_1967_KC03.bff
Pakfiles\Vehicles\Chevrolet_Corvette_1967_KC04.bff
Pakfiles\Vehicles\Chevrolet_Corvette_1967_KIT03.bff
Pakfiles\Vehicles\Chevrolet_Corvette_1967_KIT04.bff
Pakfiles\Vehicles\Chevrolet_Corvette_1967_Livery.bff
Pakfiles\Vehicles\Chevrolet_Corvette_1967_Cockpit.bff
Pakfiles\Vehicles\Chevrolet_Corvette_C6R_GT1_Cockpit.bff
Pakfiles\Vehicles\Chevrolet_Corvette_C6R_GT1_Livery.bff
Pakfiles\Vehicles\Chevrolet_Corvette_GT3_Cockpit.bff
Pakfiles\Vehicles\Chevrolet_Corvette_GT3_Livery.bff
Pakfiles\Vehicles\Dodge_Challenger_RT_1971_KC03.bff
Pakfiles\Vehicles\Dodge_Challenger_RT_1971_KC04.bff
Pakfiles\Vehicles\Dodge_Challenger_RT_1971_KIT03.bff
Pakfiles\Vehicles\Dodge_Challenger_RT_1971_KIT04.bff
Pakfiles\Vehicles\Dodge_Challenger_RT_1971_Livery.bff
Pakfiles\Vehicles\Dodge_Challenger_RT_1971_Cockpit.bff
Pakfiles\Vehicles\Dodge_Challenger_SH_Cockpit.bff
Pakfiles\Vehicles\Dodge_Challenger_SH_Livery.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8_KC02.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8_KC03.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8_KC04.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8_KIT02.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8_KIT03.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8_KIT04.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8_Livery.bff
Pakfiles\Vehicles\DODGE_CHALLENGER_SRT8_Cockpit.bff
Pakfiles\Vehicles\DODGE_CHARGER_RT_69_KC03.bff
Pakfiles\Vehicles\DODGE_CHARGER_RT_69_KC04.bff
Pakfiles\Vehicles\DODGE_CHARGER_RT_69_KIT03.bff
Pakfiles\Vehicles\DODGE_CHARGER_RT_69_KIT04.bff
Pakfiles\Vehicles\DODGE_CHARGER_RT_69_Livery.bff
Pakfiles\Vehicles\DODGE_CHARGER_RT_69_Cockpit.bff
Pakfiles\Vehicles\dodge_vipersrt10_KC03.bff
Pakfiles\Vehicles\dodge_vipersrt10_KC04.bff
Pakfiles\Vehicles\dodge_vipersrt10_KIT03.bff
Pakfiles\Vehicles\dodge_vipersrt10_KIT04.bff
Pakfiles\Vehicles\dodge_vipersrt10_Livery.bff
Pakfiles\Vehicles\dodge_vipersrt10_Cockpit.bff
Pakfiles\Vehicles\dodge_viper_twinsturbo_Cockpit.bff
Pakfiles\Vehicles\dodge_viper_twinsturbo_Livery.bff
Pakfiles\Vehicles\Ford_Capri_RS3100_Cockpit.bff
Pakfiles\Vehicles\Ford_Capri_RS3100_Livery.bff
Pakfiles\Vehicles\Ford_Escort_Mk1_Cockpit.bff
Pakfiles\Vehicles\Ford_Escort_Mk1_Livery.bff
Pakfiles\Vehicles\ford_escort_rs_KC01.bff
Pakfiles\Vehicles\ford_escort_rs_KC02.bff
Pakfiles\Vehicles\ford_escort_rs_KC03.bff
Pakfiles\Vehicles\ford_escort_rs_KC04.bff
Pakfiles\Vehicles\ford_escort_rs_KIT01.bff
Pakfiles\Vehicles\ford_escort_rs_KIT02.bff
Pakfiles\Vehicles\ford_escort_rs_KIT03.bff
Pakfiles\Vehicles\ford_escort_rs_KIT04.bff
Pakfiles\Vehicles\ford_escort_rs_Livery.bff
Pakfiles\Vehicles\ford_escort_rs_Cockpit.bff
Pakfiles\Vehicles\ford_focusst_KC01.bff
Pakfiles\Vehicles\ford_focusst_KC02.bff
Pakfiles\Vehicles\ford_focusst_KC03.bff
Pakfiles\Vehicles\ford_focusst_KC04.bff
Pakfiles\Vehicles\ford_focusst_KIT01.bff
Pakfiles\Vehicles\ford_focusst_KIT02.bff
Pakfiles\Vehicles\ford_focusst_KIT03.bff
Pakfiles\Vehicles\ford_focusst_KIT04.bff
Pakfiles\Vehicles\ford_focusst_Cockpit.bff
Pakfiles\Vehicles\ford_focusst_Livery.bff
Pakfiles\Vehicles\ford_focus_rs_Cockpit.bff
Pakfiles\Vehicles\ford_focus_rs_KC03.bff
Pakfiles\Vehicles\ford_focus_rs_KC04.bff
Pakfiles\Vehicles\ford_focus_rs_KIT03.bff
Pakfiles\Vehicles\ford_focus_rs_KIT04.bff
Pakfiles\Vehicles\ford_focus_rs_Livery.bff
Pakfiles\Vehicles\Ford_GT40_Cockpit.bff
Pakfiles\Vehicles\Ford_GT40_Livery.bff
Pakfiles\Vehicles\ford_gt_Cockpit.bff
Pakfiles\Vehicles\Ford_GT_GT1_Cockpit.bff
Pakfiles\Vehicles\Ford_GT_GT1_Livery.bff
Pakfiles\Vehicles\Ford_GT_GT3_Cockpit.bff
Pakfiles\Vehicles\Ford_GT_GT3_Livery.bff
Pakfiles\Vehicles\ford_gt_KC03.bff
Pakfiles\Vehicles\ford_gt_KC04.bff
Pakfiles\Vehicles\ford_gt_KIT03.bff
Pakfiles\Vehicles\ford_gt_KIT04.bff
Pakfiles\Vehicles\ford_gt_Livery.bff
Pakfiles\Vehicles\Ford_Mustang_2010_KC02.bff
Pakfiles\Vehicles\Ford_Mustang_2010_KC03.bff
Pakfiles\Vehicles\Ford_Mustang_2010_KC04.bff
Pakfiles\Vehicles\Ford_Mustang_FALKEN_Cockpit.bff
Pakfiles\Vehicles\Ford_Mustang_2010_KC04.bff
Pakfiles\Vehicles\Ford_Mustang_2010_KIT02.bff
Pakfiles\Vehicles\Ford_Mustang_2010_KIT03.bff
Pakfiles\Vehicles\Ford_Mustang_2010_KIT04.bff
Pakfiles\Vehicles\Ford_Mustang_2010_Livery.bff
Pakfiles\Vehicles\Ford_Mustang_2010_Cockpit.bff
Pakfiles\Vehicles\Ford_Mustang_RTRX.bff
Pakfiles\Vehicles\Ford_Mustang_RTRX_Cockpit.bff
Pakfiles\Vehicles\Ford_Mustang_RTRX_Livery.bff
Pakfiles\Vehicles\Gumpert_apollo_Cockpit.bff
Pakfiles\Vehicles\Gumpert_apollo_KC04.bff
Pakfiles\Vehicles\Gumpert_apollo_KIT04.bff
Pakfiles\Vehicles\Gumpert_apollo_Livery.bff
Pakfiles\Vehicles\Honda_Civic_SI_KC01.bff
Pakfiles\Vehicles\Honda_Civic_SI_KC02.bff
Pakfiles\Vehicles\Honda_Civic_SI_KC03.bff
Pakfiles\Vehicles\Honda_Civic_SI_KC04.bff
Pakfiles\Vehicles\Honda_Civic_SI_KIT01.bff
Pakfiles\Vehicles\Honda_Civic_SI_KIT02.bff
Pakfiles\Vehicles\Honda_Civic_SI_KIT03.bff
Pakfiles\Vehicles\Honda_Civic_SI_KIT04.bff
Pakfiles\Vehicles\Honda_Civic_SI_Livery.bff
Pakfiles\Vehicles\Honda_Civic_SI_Cockpit.bff
Pakfiles\Vehicles\Honda_S2000_KC01.bff
Pakfiles\Vehicles\Honda_S2000_KC02.bff
Pakfiles\Vehicles\Honda_S2000_KC03.bff
Pakfiles\Vehicles\Honda_S2000_KC04.bff
Pakfiles\Vehicles\Honda_S2000_KIT01.bff
Pakfiles\Vehicles\Honda_S2000_KIT02.bff
Pakfiles\Vehicles\Honda_S2000_KIT03.bff
Pakfiles\Vehicles\Honda_S2000_KIT04.bff
Pakfiles\Vehicles\Honda_S2000_Livery.bff
Pakfiles\Vehicles\Honda_S2000_Cockpit.bff
Pakfiles\Vehicles\Infiniti_G35_KC01.bff
Pakfiles\Vehicles\Infiniti_G35_KC02.bff
Pakfiles\Vehicles\Infiniti_G35_KC03.bff
Pakfiles\Vehicles\Infiniti_G35_KC04.bff
Pakfiles\Vehicles\Infiniti_G35_KIT01.bff
Pakfiles\Vehicles\Infiniti_G35_KIT02.bff
Pakfiles\Vehicles\Infiniti_G35_KIT03.bff
Pakfiles\Vehicles\Infiniti_G35_KIT04.bff
Pakfiles\Vehicles\Infiniti_G35_Livery.bff
Pakfiles\Vehicles\Infiniti_G35_Cockpit.bff
Pakfiles\Vehicles\Jaguar_E_LW_Cockpit.bff
Pakfiles\Vehicles\Jaguar_E_LW_Livery.bff
Pakfiles\Vehicles\Jaguar_XKR_Cockpit.bff
Pakfiles\Vehicles\Jaguar_XKR_KC03.bff
Pakfiles\Vehicles\Jaguar_XKR_KC04.bff
Pakfiles\Vehicles\Jaguar_XKR_KIT03.bff
Pakfiles\Vehicles\Jaguar_XKR_KIT04.bff
Pakfiles\Vehicles\Jaguar_XKR_Livery.bff
Pakfiles\Vehicles\Koenigsegg_Agera_Cockpit.bff
Pakfiles\Vehicles\Koenigsegg_Agera_KC04.bff
Pakfiles\Vehicles\Koenigsegg_Agera_KIT04.bff
Pakfiles\Vehicles\Koenigsegg_Agera_Livery.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_GT3_Cockpit.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_GT3_Livery.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_LP560-4_KC03.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_LP560-4_KC04.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_LP560-4_KIT03.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_LP560-4_KIT04.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_LP560-4_Livery.bff
Pakfiles\Vehicles\Lamborghini_Gallardo_LP560-4_Cockpit.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_LP640_KC03.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_LP640_KC04.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_LP640_KIT03.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_LP640_KIT04.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_LP640_Livery.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_LP640_Cockpit.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_R-SV_GT1_Cockpit.bff
Pakfiles\Vehicles\Lamborghini_Murcielago_R-SV_GT1_Livery.bff
Pakfiles\Vehicles\Lamborghini_Reventon_Cop_Cockpit.bff
Pakfiles\Vehicles\Lamborghini_Reventon_Cop_Livery.bff
Pakfiles\Vehicles\Lamborghini_Reventon_KC04.bff
Pakfiles\Vehicles\Lamborghini_Reventon_KIT04.bff
Pakfiles\Vehicles\Lamborghini_Reventon_Livery.bff
Pakfiles\Vehicles\Lamborghini_Reventon_Cockpit.bff
Pakfiles\Vehicles\Lancia_Delta_Cockpit.bff
Pakfiles\Vehicles\Lancia_Delta_KC03.bff
Pakfiles\Vehicles\Lancia_Delta_KC04.bff
Pakfiles\Vehicles\Lancia_Delta_KIT03.bff
Pakfiles\Vehicles\Lancia_Delta_KIT04.bff
Pakfiles\Vehicles\Lancia_Delta_Livery.bff
Pakfiles\Vehicles\LEXUS_IS-F_Cockpit.bff
Pakfiles\Vehicles\LEXUS_IS-F_KC03.bff
Pakfiles\Vehicles\LEXUS_IS-F_KC04.bff
Pakfiles\Vehicles\LEXUS_IS-F_KIT03.bff
Pakfiles\Vehicles\LEXUS_IS-F_KIT04.bff
Pakfiles\Vehicles\LEXUS_IS-F_Livery.bff
Pakfiles\Vehicles\Lexus_LFA_KC04.bff
Pakfiles\Vehicles\Lexus_LFA_KIT04.bff
Pakfiles\Vehicles\Lexus_LFA_Livery.bff
Pakfiles\Vehicles\Lexus_LFA_Cockpit.bff
Pakfiles\Vehicles\Lexus_LFA_SH.bff
Pakfiles\Vehicles\Lexus_LFA_SH_Cockpit.bff
Pakfiles\Vehicles\Lexus_LFA_SH_Livery.bff
Pakfiles\Vehicles\Lotus_Cortina_Cockpit.bff
Pakfiles\Vehicles\Lotus_Cortina_Livery.bff
Pakfiles\Vehicles\lotus_elise_KC02.bff
Pakfiles\Vehicles\lotus_elise_KC03.bff
Pakfiles\Vehicles\lotus_elise_KC04.bff
Pakfiles\Vehicles\lotus_elise_KIT02.bff
Pakfiles\Vehicles\lotus_elise_KIT03.bff
Pakfiles\Vehicles\lotus_elise_KIT04.bff
Pakfiles\Vehicles\lotus_elise_Livery.bff
Pakfiles\Vehicles\lotus_elise_Cockpit.bff
Pakfiles\Vehicles\lotus_exige_KC03.bff
Pakfiles\Vehicles\lotus_exige_KC04.bff
Pakfiles\Vehicles\lotus_exige_KIT03.bff
Pakfiles\Vehicles\lotus_exige_KIT04.bff
Pakfiles\Vehicles\lotus_exige_Livery.bff
Pakfiles\Vehicles\lotus_exige_Cockpit.bff
Pakfiles\Vehicles\Maserati_GT_S_Cockpit.bff
Pakfiles\Vehicles\Maserati_GT_S_KC03.bff
Pakfiles\Vehicles\Maserati_GT_S_KC04.bff
Pakfiles\Vehicles\Maserati_GT_S_KIT03.bff
Pakfiles\Vehicles\Maserati_GT_S_KIT04.bff
Pakfiles\Vehicles\Maserati_GT_S_Livery.bff
Pakfiles\Vehicles\Maserati_MC12_Livery.bff
Pakfiles\Vehicles\Maserati_MC12_Cockpit.bff
Pakfiles\Vehicles\Mazda_MX5_KC01.bff
Pakfiles\Vehicles\Mazda_MX5_KC02.bff
Pakfiles\Vehicles\Mazda_MX5_KC03.bff
Pakfiles\Vehicles\Mazda_MX5_KC04.bff
Pakfiles\Vehicles\Mazda_MX5_KIT01.bff
Pakfiles\Vehicles\Mazda_MX5_KIT02.bff
Pakfiles\Vehicles\Mazda_MX5_KIT03.bff
Pakfiles\Vehicles\Mazda_MX5_KIT04.bff
Pakfiles\Vehicles\Mazda_MX5_Livery.bff
Pakfiles\Vehicles\Mazda_MX5_Cockpit.bff
Pakfiles\Vehicles\Mazda_RX7_FC_Cockpit.bff
Pakfiles\Vehicles\Mazda_RX7_FC_KC02.bff
Pakfiles\Vehicles\Mazda_RX7_FC_KC03.bff
Pakfiles\Vehicles\Mazda_RX7_FC_KC04.bff
Pakfiles\Vehicles\Mazda_RX7_FC_KIT02.bff
Pakfiles\Vehicles\Mazda_RX7_FC_KIT03.bff
Pakfiles\Vehicles\Mazda_RX7_FC_KIT04.bff
Pakfiles\Vehicles\Mazda_RX7_FC_Livery.bff
Pakfiles\Vehicles\Mazda_RX7_FC_Rival_Cockpit.bff
Pakfiles\Vehicles\Mazda_RX7_FC_Rival_Livery.bff
Pakfiles\Vehicles\Mazda_RX7_FC_SH_Cockpit.bff
Pakfiles\Vehicles\Mazda_RX7_FC_SH_Livery.bff
Pakfiles\Vehicles\Mazda_RX8_KC01.bff
Pakfiles\Vehicles\Mazda_RX8_KC02.bff
Pakfiles\Vehicles\Mazda_RX8_KC03.bff
Pakfiles\Vehicles\Mazda_RX8_KC04.bff
Pakfiles\Vehicles\Mazda_RX8_KIT01.bff
Pakfiles\Vehicles\Mazda_RX8_KIT02.bff
Pakfiles\Vehicles\Mazda_RX8_KIT03.bff
Pakfiles\Vehicles\Mazda_RX8_KIT04.bff
Pakfiles\Vehicles\Mazda_RX8_Livery.bff
Pakfiles\Vehicles\Mazda_RX8_Cockpit.bff
Pakfiles\Vehicles\Mazda_RX8_MadMike_Cockpit.bff
Pakfiles\Vehicles\Mazda_RX8_MadMike_Livery.bff
Pakfiles\Vehicles\McLaren_F1_KC04.bff
Pakfiles\Vehicles\McLaren_F1_KIT04.bff
Pakfiles\Vehicles\McLaren_F1_Livery.bff
Pakfiles\Vehicles\McLaren_F1_Cockpit.bff
Pakfiles\Vehicles\mclaren_mp4-12c_Cockpit.bff
Pakfiles\Vehicles\mclaren_mp4-12c_KC04.bff
Pakfiles\Vehicles\mclaren_mp4-12c_KIT04.bff
Pakfiles\Vehicles\mclaren_mp4-12c_Livery.bff
Pakfiles\Vehicles\mclaren_mp4-12c_sh.bff
Pakfiles\Vehicles\mclaren_mp4-12c_sh_Cockpit.bff
Pakfiles\Vehicles\mclaren_mp4-12c_sh_Livery.bff
Pakfiles\Vehicles\Mercedes_190E_Evo2_Cockpit.bff
Pakfiles\Vehicles\Mercedes_190E_Evo2_KC03.bff
Pakfiles\Vehicles\Mercedes_190E_Evo2_KC04.bff
Pakfiles\Vehicles\Mercedes_190E_Evo2_KIT03.bff
Pakfiles\Vehicles\Mercedes_190E_Evo2_KIT04.bff
Pakfiles\Vehicles\Mercedes_190E_Evo2_Livery.bff
Pakfiles\Vehicles\Mercedes_190E_SH_Cockpit.bff
Pakfiles\Vehicles\Mercedes_190E_SH_Livery.bff
Pakfiles\Vehicles\Mercedes_SL65_KC03.bff
Pakfiles\Vehicles\Mercedes_SL65_KC04.bff
Pakfiles\Vehicles\Mercedes_SL65_KIT03.bff
Pakfiles\Vehicles\Mercedes_SL65_KIT04.bff
Pakfiles\Vehicles\Mercedes_SL65_Livery.bff
Pakfiles\Vehicles\Mercedes_SL65_Cockpit.bff
Pakfiles\Vehicles\Mercedes_SLR722_KC04.bff
Pakfiles\Vehicles\Mercedes_SLR722_KIT04.bff
Pakfiles\Vehicles\Mercedes_SLR722_Livery.bff
Pakfiles\Vehicles\Mercedes_SLR722_Cockpit.bff
Pakfiles\Vehicles\MERCEDES_SLR_MOSS_Cockpit.bff
Pakfiles\Vehicles\MERCEDES_SLR_MOSS_KC04.bff
Pakfiles\Vehicles\MERCEDES_SLR_MOSS_KIT04.bff
Pakfiles\Vehicles\MERCEDES_SLR_MOSS_Livery.bff
Pakfiles\Vehicles\Mercedes_SLS_Cockpit.bff
Pakfiles\Vehicles\Mercedes_SLS_KC04.bff
Pakfiles\Vehicles\Mercedes_SLS_KIT04.bff
Pakfiles\Vehicles\Mercedes_SLS_Livery.bff
Pakfiles\Vehicles\Mercedes_SLS_SH_Cockpit.bff
Pakfiles\Vehicles\Mercedes_SLS_SH_Livery.bff
Pakfiles\Vehicles\mitsubishi_evoix_KC02.bff
Pakfiles\Vehicles\mitsubishi_evoix_KC03.bff
Pakfiles\Vehicles\mitsubishi_evoix_KC04.bff
Pakfiles\Vehicles\mitsubishi_evoix_KIT02.bff
Pakfiles\Vehicles\mitsubishi_evoix_KIT03.bff
Pakfiles\Vehicles\mitsubishi_evoix_KIT04.bff
Pakfiles\Vehicles\mitsubishi_evoix_Livery.bff
Pakfiles\Vehicles\mitsubishi_evoix_Cockpit.bff
Pakfiles\Vehicles\Mitsubishi_EvoIX_SH_Cockpit.bff
Pakfiles\Vehicles\Mitsubishi_EvoIX_SH_Livery.bff
Pakfiles\Vehicles\mitsubishi_evox_KC02.bff
Pakfiles\Vehicles\mitsubishi_evox_KC03.bff
Pakfiles\Vehicles\mitsubishi_evox_KC04.bff
Pakfiles\Vehicles\mitsubishi_evox_KIT02.bff
Pakfiles\Vehicles\mitsubishi_evox_KIT03.bff
Pakfiles\Vehicles\mitsubishi_evox_KIT04.bff
Pakfiles\Vehicles\mitsubishi_evox_Livery.bff
Pakfiles\Vehicles\mitsubishi_evox_Cockpit.bff
Pakfiles\Vehicles\Nissan_240sx_Drift_Cockpit.bff
Pakfiles\Vehicles\Nissan_240sx_Drift_Livery.bff
Pakfiles\Vehicles\Nissan_240sx_KC01.bff
Pakfiles\Vehicles\Nissan_240sx_KC02.bff
Pakfiles\Vehicles\Nissan_240sx_KC03.bff
Pakfiles\Vehicles\Nissan_240sx_KC04.bff
Pakfiles\Vehicles\Nissan_240sx_KIT01.bff
Pakfiles\Vehicles\Nissan_240sx_KIT02.bff
Pakfiles\Vehicles\Nissan_240sx_KIT03.bff
Pakfiles\Vehicles\Nissan_240sx_KIT04.bff
Pakfiles\Vehicles\Nissan_240sx_Livery.bff
Pakfiles\Vehicles\Nissan_240sx_Cockpit.bff
Pakfiles\Vehicles\Nissan_240ZG_Cockpit.bff
Pakfiles\Vehicles\Nissan_240ZG_Livery.bff
Pakfiles\Vehicles\Nissan_240ZG_SH_Cockpit.bff
Pakfiles\Vehicles\Nissan_240ZG_SH_Livery.bff
Pakfiles\Vehicles\Nissan_350Z_KC01.bff
Pakfiles\Vehicles\Nissan_350Z_KC02.bff
Pakfiles\Vehicles\Nissan_350Z_KC03.bff
Pakfiles\Vehicles\Nissan_350Z_KC04.bff
Pakfiles\Vehicles\Nissan_350Z_KIT01.bff
Pakfiles\Vehicles\Nissan_350Z_KIT02.bff
Pakfiles\Vehicles\Nissan_350Z_KIT03.bff
Pakfiles\Vehicles\Nissan_350Z_KIT04.bff
Pakfiles\Vehicles\Nissan_350Z_Livery.bff
Pakfiles\Vehicles\Nissan_350Z_Cockpit.bff
Pakfiles\Vehicles\Nissan_370Z_KC02.bff
Pakfiles\Vehicles\Nissan_370Z_KC03.bff
Pakfiles\Vehicles\Nissan_370Z_KC04.bff
Pakfiles\Vehicles\Nissan_370Z_KIT02.bff
Pakfiles\Vehicles\Nissan_370Z_KIT03.bff
Pakfiles\Vehicles\Nissan_370Z_KIT04.bff
Pakfiles\Vehicles\Nissan_370Z_Livery.bff
Pakfiles\Vehicles\Nissan_370Z_Cockpit.bff
Pakfiles\Vehicles\Nissan_GT-R_GT1_Cockpit.bff
Pakfiles\Vehicles\Nissan_GT-R_GT1_Livery.bff
Pakfiles\Vehicles\Nissan_GTR_Dday_Cockpit.bff
Pakfiles\Vehicles\Nissan_GTR_Dday_Livery.bff
Pakfiles\Vehicles\Nissan_GTR_KC03.bff
Pakfiles\Vehicles\Nissan_GTR_KC04.bff
Pakfiles\Vehicles\Nissan_GTR_KIT03.bff
Pakfiles\Vehicles\Nissan_GTR_KIT04.bff
Pakfiles\Vehicles\Nissan_GTR_Livery.bff
Pakfiles\Vehicles\Nissan_GTR_Cockpit.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_KC03.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_KC04.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_KIT03.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_KIT04.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_Livery.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_Cockpit.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_Rival.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_Rival_Cockpit.bff
Pakfiles\Vehicles\Nissan_GTR_SPECV_Rival_Livery.bff
Pakfiles\Vehicles\Nissan_S14A_KC01.bff
Pakfiles\Vehicles\Nissan_S14A_KC02.bff
Pakfiles\Vehicles\Nissan_S14A_KC03.bff
Pakfiles\Vehicles\Nissan_S14A_KC04.bff
Pakfiles\Vehicles\Nissan_S14A_KIT01.bff
Pakfiles\Vehicles\Nissan_S14A_KIT02.bff
Pakfiles\Vehicles\Nissan_S14A_KIT03.bff
Pakfiles\Vehicles\Nissan_S14A_KIT04.bff
Pakfiles\Vehicles\Nissan_S14A_Livery.bff
Pakfiles\Vehicles\Nissan_S14A_Cockpit.bff
Pakfiles\Vehicles\Nissan_S15_KC02.bff
Pakfiles\Vehicles\Nissan_S15_KC03.bff
Pakfiles\Vehicles\Nissan_S15_KC04.bff
Pakfiles\Vehicles\Nissan_S15_KIT02.bff
Pakfiles\Vehicles\Nissan_S15_KIT03.bff
Pakfiles\Vehicles\Nissan_S15_KIT04.bff
Pakfiles\Vehicles\Nissan_S15_Livery.bff
Pakfiles\Vehicles\Nissan_S15_Cockpit.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_KC01.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_KC02.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_KC03.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_KC04.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_KIT01.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_KIT02.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_KIT03.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_KIT04.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_Livery.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_Cockpit.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_SH_Cockpit.bff
Pakfiles\Vehicles\Nissan_Skyline2000GTR_SH_Livery.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_Cockpit.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_KC02.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_KC03.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_KC04.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_KIT02.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_KIT03.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_KIT04.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_Livery.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_SH_Cockpit.bff
Pakfiles\Vehicles\Nissan_Skyline_R32_SH_Livery.bff
Pakfiles\Vehicles\Nissan_Skyline_R34.bff
Pakfiles\Vehicles\Nissan_Skyline_R34_KC02.bff
Pakfiles\Vehicles\Nissan_Skyline_R34_KC03.bff
Pakfiles\Vehicles\Nissan_Skyline_R34_KC04.bff
Pakfiles\Vehicles\Nissan_Skyline_R34_KIT02.bff
Pakfiles\Vehicles\Nissan_Skyline_R34_KIT03.bff
Pakfiles\Vehicles\Nissan_Skyline_R34_KIT04.bff
Pakfiles\Vehicles\Nissan_Skyline_R34_Livery.bff
Pakfiles\Vehicles\Nissan_Skyline_R34_Cockpit.bff
Pakfiles\Vehicles\Pagani_C9_Cockpit.bff
Pakfiles\Vehicles\Pagani_C9_KC04.bff
Pakfiles\Vehicles\Pagani_C9_KIT04.bff
Pakfiles\Vehicles\Pagani_C9_Livery.bff
Pakfiles\Vehicles\Pagani_C9_Rival_Cockpit.bff
Pakfiles\Vehicles\Pagani_C9_Rival_Livery.bff
Pakfiles\Vehicles\Pagani_Cinque_Roadster_Cockpit.bff
Pakfiles\Vehicles\Pagani_Cinque_Roadster_HP_Cockpit.bff
Pakfiles\Vehicles\Pagani_Cinque_Roadster_HP_Livery.bff
Pakfiles\Vehicles\Pagani_Cinque_Roadster_KC04.bff
Pakfiles\Vehicles\Pagani_Cinque_Roadster_KIT04.bff
Pakfiles\Vehicles\Pagani_Cinque_Roadster_Livery.bff
Pakfiles\Vehicles\Pagani_Zonda_KC04.bff
Pakfiles\Vehicles\Pagani_Zonda_KIT04.bff
Pakfiles\Vehicles\Pagani_Zonda_Livery.bff
Pakfiles\Vehicles\Pagani_Zonda_Cockpit.bff
Pakfiles\Vehicles\Pagani_Zonda_R_Livery.bff
Pakfiles\Vehicles\Pagani_Zonda_R_Cockpit.bff
Pakfiles\Vehicles\Porsche_911RSR74_Cockpit.bff
Pakfiles\Vehicles\Porsche_911RSR74_Livery.bff
Pakfiles\Vehicles\Porsche_911RSR74_Rival_Cockpit.bff
Pakfiles\Vehicles\Porsche_911RSR74_Rival_Livery.bff
Pakfiles\Vehicles\Porsche_914_Cockpit.bff
Pakfiles\Vehicles\Porsche_914_Livery.bff
Pakfiles\Vehicles\Porsche_918_Cockpit.bff
Pakfiles\Vehicles\Porsche_918_KC04.bff
Pakfiles\Vehicles\Porsche_918_KIT04.bff
Pakfiles\Vehicles\Porsche_918_Livery.bff
Pakfiles\Vehicles\PORSCHE_997GT2_KC03.bff
Pakfiles\Vehicles\PORSCHE_997GT2_KC04.bff
Pakfiles\Vehicles\PORSCHE_997GT2_KIT03.bff
Pakfiles\Vehicles\PORSCHE_997GT2_KIT04.bff
Pakfiles\Vehicles\PORSCHE_997GT2_Livery.bff
Pakfiles\Vehicles\PORSCHE_997GT2_Cockpit.bff
Pakfiles\Vehicles\PORSCHE_997GT3AB_Cockpit.bff
Pakfiles\Vehicles\PORSCHE_997GT3AB_Livery.bff
Pakfiles\Vehicles\PORSCHE_997GT3RSR_Falken_Cockpit.bff
Pakfiles\Vehicles\PORSCHE_997GT3RSR_Falken_Livery.bff
Pakfiles\Vehicles\PORSCHE_997GT3RSR_Livery.bff
Pakfiles\Vehicles\PORSCHE_997GT3RSR_Cockpit.bff
Pakfiles\Vehicles\PORSCHE_997GT3RS_KC03.bff
Pakfiles\Vehicles\PORSCHE_997GT3RS_KC04.bff
Pakfiles\Vehicles\PORSCHE_997GT3RS_KIT03.bff
Pakfiles\Vehicles\PORSCHE_997GT3RS_KIT04.bff
Pakfiles\Vehicles\PORSCHE_997GT3RS_Livery.bff
Pakfiles\Vehicles\PORSCHE_997GT3RS_Cockpit.bff
Pakfiles\Vehicles\Porsche_997_CupR_Cockpit.bff
Pakfiles\Vehicles\Porsche_997_CupR_Livery.bff
Pakfiles\Vehicles\PORSCHE_CARRERA_GT_KC04.bff
Pakfiles\Vehicles\PORSCHE_CARRERA_GT_KIT04.bff
Pakfiles\Vehicles\PORSCHE_CARRERA_GT_Livery.bff
Pakfiles\Vehicles\PORSCHE_CARRERA_GT_Cockpit.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S_KC02.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S_KC03.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S_KC04.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S_KIT02.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S_KIT03.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S_KIT04.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S_Livery.bff
Pakfiles\Vehicles\PORSCHE_Cayman_S_Cockpit.bff
Pakfiles\Vehicles\Radical_SR3_Cockpit.bff
Pakfiles\Vehicles\Radical_SR3_Livery.bff
Pakfiles\Vehicles\Renault_Megane_KC01.bff
Pakfiles\Vehicles\Renault_Megane_KC02.bff
Pakfiles\Vehicles\Renault_Megane_KC03.bff
Pakfiles\Vehicles\Renault_Megane_KC04.bff
Pakfiles\Vehicles\Renault_Megane_KIT01.bff
Pakfiles\Vehicles\Renault_Megane_KIT02.bff
Pakfiles\Vehicles\Renault_Megane_KIT03.bff
Pakfiles\Vehicles\Renault_Megane_KIT04.bff
Pakfiles\Vehicles\Renault_Megane_Livery.bff
Pakfiles\Vehicles\Renault_Megane_Cockpit.bff
Pakfiles\Vehicles\RX7_KC02.bff
Pakfiles\Vehicles\RX7_KC03.bff
Pakfiles\Vehicles\RX7_KC04.bff
Pakfiles\Vehicles\RX7_KIT02.bff
Pakfiles\Vehicles\RX7_KIT03.bff
Pakfiles\Vehicles\RX7_KIT04.bff
Pakfiles\Vehicles\RX7_Livery.bff
Pakfiles\Vehicles\RX7_Cockpit.bff
Pakfiles\Vehicles\Scion_tC_Drag_Cockpit.bff
Pakfiles\Vehicles\Scion_tC_Drag_Livery.bff
Pakfiles\Vehicles\Scion_tC_KC01.bff
Pakfiles\Vehicles\Scion_tC_KC02.bff
Pakfiles\Vehicles\Scion_tC_KC03.bff
Pakfiles\Vehicles\Scion_tC_KC04.bff
Pakfiles\Vehicles\Scion_tC_KIT01.bff
Pakfiles\Vehicles\Scion_tC_KIT02.bff
Pakfiles\Vehicles\Scion_tC_KIT03.bff
Pakfiles\Vehicles\Scion_tC_KIT04.bff
Pakfiles\Vehicles\Scion_tC_Livery.bff
Pakfiles\Vehicles\Scion_tC_Cockpit.bff
Pakfiles\Vehicles\Scion_tC_TeamNFS_Cockpit.bff
Pakfiles\Vehicles\Scion_tC_TeamNFS_Livery.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_KC01.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_KC02.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_KC03.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_KC04.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_KIT01.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_KIT02.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_KIT03.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_KIT04.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_Livery.bff
Pakfiles\Vehicles\Seat_Leon_Cupra_Cockpit.bff
Pakfiles\Vehicles\Shelby_Daytona_Cockpit.bff
Pakfiles\Vehicles\Shelby_Daytona_Livery.bff
Pakfiles\Vehicles\SHELBY_GT500_67_KC03.bff
Pakfiles\Vehicles\SHELBY_GT500_67_KC04.bff
Pakfiles\Vehicles\SHELBY_GT500_67_KIT03.bff
Pakfiles\Vehicles\SHELBY_GT500_67_KIT04.bff
Pakfiles\Vehicles\SHELBY_GT500_67_Livery.bff
Pakfiles\Vehicles\SHELBY_GT500_67_Cockpit.bff
Pakfiles\Vehicles\SHELBY_TERLINGUA_Livery.bff
Pakfiles\Vehicles\SHELBY_TERLINGUA_Cockpit.bff
Pakfiles\Vehicles\Subaru_Impreza_STi_KC02.bff
Pakfiles\Vehicles\Subaru_Impreza_STi_KC03.bff
Pakfiles\Vehicles\Subaru_Impreza_STi_KC04.bff
Pakfiles\Vehicles\Subaru_Impreza_STi_KIT02.bff
Pakfiles\Vehicles\Subaru_Impreza_STi_KIT03.bff
Pakfiles\Vehicles\Subaru_Impreza_STi_KIT04.bff
Pakfiles\Vehicles\Subaru_Impreza_STi_Livery.bff
Pakfiles\Vehicles\Subaru_Impreza_STi_Cockpit.bff
Pakfiles\Vehicles\TOYOTA_corolla_ae86_dmac_Cockpit.bff
Pakfiles\Vehicles\TOYOTA_corolla_ae86_dmac_Livery.bff
Pakfiles\Vehicles\TOYOTA_corolla_KC01.bff
Pakfiles\Vehicles\TOYOTA_corolla_KC02.bff
Pakfiles\Vehicles\TOYOTA_corolla_KC03.bff
Pakfiles\Vehicles\TOYOTA_corolla_KC04.bff
Pakfiles\Vehicles\TOYOTA_corolla_KIT01.bff
Pakfiles\Vehicles\TOYOTA_corolla_KIT02.bff
Pakfiles\Vehicles\TOYOTA_corolla_KIT03.bff
Pakfiles\Vehicles\TOYOTA_corolla_KIT04.bff
Pakfiles\Vehicles\TOYOTA_corolla_Livery.bff
Pakfiles\Vehicles\TOYOTA_corolla_Cockpit.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_KC02.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_KC03.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_KC04.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_KIT02.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_KIT03.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_KIT04.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_Livery.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_Cockpit.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_SH_Cockpit.bff
Pakfiles\Vehicles\TOYOTA_SUPRA_SH_Livery.bff
Pakfiles\Vehicles\vw_golf_gti_KC01.bff
Pakfiles\Vehicles\vw_golf_gti_KC02.bff
Pakfiles\Vehicles\vw_golf_gti_KC03.bff
Pakfiles\Vehicles\vw_golf_gti_KC04.bff
Pakfiles\Vehicles\vw_golf_gti_KIT01.bff
Pakfiles\Vehicles\vw_golf_gti_KIT02.bff
Pakfiles\Vehicles\vw_golf_gti_KIT03.bff
Pakfiles\Vehicles\vw_golf_gti_KIT04.bff
Pakfiles\Vehicles\vw_golf_gti_Livery.bff
Pakfiles\Vehicles\vw_golf_gti_Cockpit.bff
Pakfiles\Vehicles\VW_Golf_Mk1_Cockpit.bff
Pakfiles\Vehicles\VW_Golf_Mk1_KC01.bff
Pakfiles\Vehicles\VW_Golf_Mk1_KC02.bff
Pakfiles\Vehicles\VW_Golf_Mk1_KC03.bff
Pakfiles\Vehicles\VW_Golf_Mk1_KC04.bff
Pakfiles\Vehicles\VW_Golf_Mk1_KIT01.bff
Pakfiles\Vehicles\VW_Golf_Mk1_KIT02.bff
Pakfiles\Vehicles\VW_Golf_Mk1_KIT03.bff
Pakfiles\Vehicles\VW_Golf_Mk1_KIT04.bff
Pakfiles\Vehicles\VW_Golf_Mk1_Livery.bff
Pakfiles\Vehicles\VW_Scirocco_KC01.bff
Pakfiles\Vehicles\VW_Scirocco_KC02.bff
Pakfiles\Vehicles\VW_Scirocco_KC03.bff
Pakfiles\Vehicles\VW_Scirocco_KC04.bff
Pakfiles\Vehicles\VW_Scirocco_KIT01.bff
Pakfiles\Vehicles\VW_Scirocco_KIT02.bff
Pakfiles\Vehicles\VW_Scirocco_KIT03.bff
Pakfiles\Vehicles\VW_Scirocco_KIT04.bff
Pakfiles\Vehicles\VW_Scirocco_Livery.bff
Pakfiles\Vehicles\VW_Scirocco_Cockpit.bff
) DO (
@ECHO + Processing %%G ...

@ECHO ++ Unpacking ...
SET _MSG=- Could not unpack %%G -- aborting!
REM Save the quickbms unpacking output to a file instead of showing it on screen
%UNPACK% %%G %_INSTALL_DIR% >> %_OUTPUTLOG% 2>&1 || GOTO die

@ECHO ++ Creating index file ...
SET _MSG=- Could not create BFF index file BFF_index\%%G___.txt -- aborting!
REM Assume that the appropriate BFF_index dir exists (it should)
REM and list the contents of the BFF and save to a file
%LIST% %%G > BFF_index\%%G___.txt 2>&1 || GOTO die

@ECHO ++ Dummying out ...
SET _MSG=- Could not dummy out %%G -- aborting!
CALL :copy_subroutine %_INSTALL_DIR%\%%G

SET /A _BFFCOUNT+=1
@ECHO.
)

GOTO prune


:copy_subroutine
REM Chop off the filename part and keep the full path of the 1st parameter
SET _DIR="%~dp1"
IF NOT EXIST %_DIR% (
  @ECHO + Creating %_DIR% ...

  SET _MSG=- Could not create %_DIR% -- aborting!
  MKDIR %_DIR% || GOTO die
)
%DUMMYOUT% %_CWD%%1 || GOTO die 
REM Note that 'GOTO eof' simply means 'subroutine has finished'
GOTO eof


:prune

:: Don't dummy out car liveries, as that will crash the game

@ECHO + Pruning the list of dummied out BFF files ...
@ECHO.

SET _MSG=- Could not prune the list of dummied out BFF files -- aborting!
DEL /S /Q %_INSTALL_DIR%\Pakfiles\vehicles\*_Livery.bff || GOTO die
@ECHO.

:: Disable the TXT files that makes the game crash when cars have body kits
:: We need the "tokens=*" parameter to avoid splitting paths up when a
:: space character is encountered. 
:: !_MSG! denotes that we use delayed expansion so that we can show each filename

@ECHO + Moving ^*_kt.txt files to ^*_kt.txt.disabled ...
@ECHO.

FOR /F "tokens=*" %%G IN ('DIR /S /B %_INSTALL_DIR%\vehicles\*_kt.txt') DO (
@ECHO + Disabling "%%G" ...
SET _MSG=- Could not disable "%%G" -- aborting!
MOVE /Y "%%G" "%%G".disabled || GOTO die
)
@ECHO.

@ECHO + Moving ^*_kct.txt files to ^*_kct.txt.disabled ...
@ECHO.
FOR /F "tokens=*" %%G IN ('DIR /S /B %_INSTALL_DIR%\vehicles\*_kct.txt') DO (

@ECHO + Disabling "%%G" ...
SET _MSG=- Could not disable "%%G" -- aborting!
MOVE /Y "%%G" "%%G".disabled || GOTO die
)
@ECHO.

@ECHO + Setting up automagical JSGME TOCFiles handling...
IF NOT EXIST %_INSTALL_DIR%\TOCFiles (
  MKDIR %_INSTALL_DIR%\TOCFiles
)
@ECHO. > %_INSTALL_DIR%\TOCFiles\DirPaks.toc-remove
@ECHO. > %_INSTALL_DIR%\TOCFiles\VehicleLiveries.toc-remove

:: Create (and hide) a "Kilroy Was Here" stamp that the UCP install script can check for
:: to ensure that lusers who are too cool to read the fine manual don't go
:: asking for support before they have been reminded to read the install instructions.

IF NOT EXIST %_INSTALL_DIR%\_RTFM_.txt (
  @ECHO Killroy Was Here. If you remove this file, you won't be able to make the UCP install script run. > %_INSTALL_DIR%\_RTFM_.txt
  ATTRIB +H %_INSTALL_DIR%\_RTFM_.txt
)

:finished

SET _MSG=+ Unpacked %_BFFCOUNT% BFF files, started at %_UNPACK_START%, finished at %TIME%
@ECHO. >> %_OUTPUTLOG%
@ECHO %_MSG% >> %_OUTPUTLOG%

@ECHO.
@ECHO %_MSG%
@ECHO.
@ECHO + The output from the unpacking process was saved to the file
@ECHO.
@ECHO   %_OUTPUTLOG% 
@ECHO.
@ECHO + The unpacked files were saved to the folder
@ECHO.
@ECHO   %_TARGET%
@ECHO.
@ECHO   The unpacked S2U version should now be activated with the JSGME tool, 
@ECHO   which will obviously take a while as it needs move a lot of files around,
@ECHO   so please be patient during the activation process.
@ECHO.
@ECHO   --The Authors
@ECHO.

GOTO exit


:die

:: Set _MSG and GOTO die when something goes wrong.

@ECHO.
@ECHO - Uh Oh! Something went awry...
@ECHO.
@ECHO  The process failed during the following step:
@ECHO.
@ECHO  %_MSG%
@ECHO.
@ECHO - Please review the error message given, act appropriately, and try again :)
@ECHO.

GOTO exit


:exit

:: return to the root folder of the unpacked mod
CD /D %_CWD%

:: End local variable scope

ENDLOCAL
pause

:eof