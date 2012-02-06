== Shift 2 Unleashed - Unofficial Community Patch v1.1 ==

This is an unofficial "patch" for Shift 2 Unleashed developed by the nogripracing.com modding community.

The objective is to combine bug fixes and enhancements while preserving the driving feel of stock S2U. There are no deliberate physics changes included, but car handling is improved in some cases as a result of bug fixing. As it is intended as a "patch", there are some enhancements included that would have been nice to see in an official patch, such as increasing player level maximum from 20 to 40. See changelist section below for full list of bug fixes and enhancements.

It is intended for people who enjoy driving the game out of the box, but were bothered by the bugs, and as a base for future mod development, to make sure that new mods are built on top of bug free data.


=== Credits ===

**Main Authors:**
 matt2380, JDougNY, ermo (current maintainer), and pez2k

**Contributors and supporters:**
 brrupsz, Bongomaster, D1Racer, djotefsoup, edubz123, Jeroen vd Helm, Jonzy, Kaerar, Kazumi,
 Kinski, kligson, MacGear, ogre2010, outlaw22, SakuraBlack, Siggs, xpertvision.

Thanks to Juls for the great inject tool (with no size limtations).

Thanks to Luigi Auriemma for the quickbms .bff unpacking tool (http://aluigi.altervista.org/quickbms.htm).

Thanks to JoneSoft for the Generic Mod Enabler (JSGME) freeware that has been included to assist installation (http://www.users.on.net/~jscones/software/products-jsgme.html).


== 1. Important information ==

**To avoid problems, please (!) take the time to read this readme properly from start to finish.** :-)

* Installations instructions are at the bottom of this readme.
* This mod is intended for use with a freshly installed game. 
* This mod requires that you have already installed the latest official patch (v1.02),
  which is included in the PC DLC Pack (Legends and Speedhunters packs), which you can find
  at http://store.origin.com/ and then search for "unleashed", then choose the version that
  suits you:

** "DVD Boxed Copy"
** "Non-Origin version"
** "Origin version"

* if you install other mods after the UCP then it is strongly recommended you continue
  to use the JSGME freeware.

=== After installation ===

* Reset your saved car setups in the GARAGE> TUNING menu (using the "R" key), this is due to
  the significant changes made to the car tuning (ie, fixing the reverse toe value bug). 
* Some users may also need to reset their controller profile after installation, otherwise
  their controler may not respond to steering.
* See this thread for discussion: http://www.nogripracing.com/forum/showthread.php?t=264000


== 2. Changelist ==

=== v1.1 pre-release ===

* New maintainer (ermo)
* Revised installation with a selection of unpacked game files for ease of modding and compatibility
* Only includes the JSGME installation method (simpler to support, creates automatic backups for consistency)
* Support for dropping custom liveries directly into \vehicles\textures
* README rewritten in WikiCreole syntax for easier viewing/publishing of inline images
* (NOT DONE) Increase maximum career level to 40 (and be able to buy speedhunter stickers)
* (NOT DONE) Change how reward cars are handled
* (NOT DONE) Decrease collision stickiness
* (NOT DONE) Decrease AI aggressiveness (we want the AI to ram less)
* (NOT DONE) Increase damage levels/sensitivity


=== v1.06 ===

* New backup and install method
* Corrected engine swap HP menu stats
* Sellable Speedhunters DLC cars
* Increase maximum career level to 30 with following reward vehicles:
**  Level 21 = Limited Edition cars, Alfa Romeo Giulietta, Nissan S15, and Lamborghini Murcielago LP640
**  Level 22 = Chevrolet Camaro, Dr Pepper Edition
**  Level 23 = Porsche GT3, AutoBild Edtion
**  Level 24 = Alfa Romeo 8C Spider
**  Level 25 = Aston Martin DBS Volante
**  Level 26 = Audi R8 Spyder
**  Level 27 = Pagani Cinque Roadster
**  Level 28 = Pagani Cinque Roadster, Hot Pursuit Edition
**  Level 29 = Lamborghini Reventon, Hot Pursuit Cop Edition
**  Level 30 = Koenigsegg Agera
* Increase prize money earned in quick races from $200 to $20,000
* Enable prize money and XP for solo quick race
* Increase caster range from 0-7.3 to 0-10 degrees
* Increase garage spaces to 800
* Fixed sound for Nissan 2000GTR and Nissan 240ZG engine swap
* Fixed Mazda RX8 and Porsche 914 engine descriptions
* Fixed bug in Bugatti Veyron rear-left SlowBumpRange


=== v1.05 ===

* Removed the "unlock hidden cars and events" component in v1.03 and v1.04 because it was 
  causing some problems with save games/new careers/menu selection for some people, sorry!
**  Anyone who installed v1.03 or v1.04 and had problems with their savegame should restore
    their original unmodded backup (v1.02) of these two files before installing v1.05:
***   \Pakfiles\BOOTFLOW.bff
***   \Pakfiles\BOOTPSA.bff
* Fixed typos in three files that were included with the original game (two menu files and one
  damage file).
* Enabled ability to skip career movies.
* Corrected power of Mazda RX7 FC rotary (stock and turbo upgrades).
* Corrected install location of some of the track.lod files
* Adjusted max caster from 70 to 73 (to match range of default game = 72.5)


=== v1.04 ===

* Attempted to fix problem with unlocking hidden cars which caused an issue with main menu
  and prevented starting a new career (however this was still bugged, removed in v1.05).
* Added some missing chassis updates that were supposed to be in v1.03.


=== v1.03 ===

* Removed intro movies for a faster game startup.
* Numerous changes within each vehicles chassis file:
**  Fixed reversed toe values bug (flip positive and negative values to match tuning menu).
**  Created standard adjustment units for the following tuning options (set all base values to
    0 while keeping original preset values, this way you know what you're actually setting for
    these items).
***   Tyre pressure now displays the actual kPa value (previously we saw only a condensed kPa
      range, which varied between different cars, making tuning confusing).
***   Steering lock now displays your actual steering lock (allowing easier comparison between
      cars).
***   Differential Power/Coast/Preload
***   Caster ranges now range from 0 to 70, corresponding to 0 to 7 degrees.
***   Established a common base camber tuning range (-5 to +5 degrees) and adjustment value
       (0.1).
**  Unlocked more default tuning options for lower tier cars.
**  Fixed uneven ReboundTravel on many cars.
**  Fixed diffuser base value typos on various cars.
**  Fixed uneven left/right tuning on various cars.
**  Fixed front & rear wing range for Audi R8 LMS.
**  Fixed camber values on various cars.
**  Corrected fuel tank locations (some were up to 2m behind car).
**  Fixed missing DiffPumpSetting values (from "DiffPumpSetting= " to "DiffPumpSetting=0"
    which was found to produce more consistent AI behaviour in Overhaul mod for Shift 1)
* Fixed a bug that prevented proper upgrade of Mercedes 190e Evo2
* Unlocked hidden cars and events (turns out this was bugged, sorry! Removed in v1.05).
* Disabled reverse driving penalty to double available tracks in hot lap mode.
* Reduced the magnetized effect of collisions with walls/rails and other vehicles.
* Fixed reversed mirrors in several cars.
* Fixed syntax errors in tracks.lod files


== 3. Installation ==

* STEP 0: -- Prerequisites
* STEP 1: -- Copy S2U_UCP Folder
* STEP 2: -- Backup Save Game
* STEP 3a: -- Run Unpack Script
* STEP 3b: -- Activate Unpacked Version
* STEP 3c: -- Rename TOCFiles
* STEP 4a: -- Run UCP Install Script
* STEP 4b: -- Activate UCP
* STEP 5: -- Ingame Actions


=== STEP 0: -- Prerequisites ===

This mod requires that you have already installed the latest official patch (v1.02) which is included in the free PC DLC Pack (Legends and Speedhunters packs), go to http://store.origin.com/ and search for "unleashed", then choose the version that suits you:

* "DVD Boxed Copy"
* "Non-Origin version"
* "Origin version"

Then click "add to basket", then "checkout" (which will require that you create an origin.com account or to sign-in if you already have an account). 

**DEACTIVATE** any previous UCP versions installed via JSGME.

**DELETE** any existing UCP_modified_assets (or UCP temp files) folder in your S2U installation folder.


=== STEP 1: -- Copy S2U_UCP Folder ===

Copy the contents of this "S2U_UCP" folder into your Shift 2 install folder. So, all the following will be copied into your Shift 2 install folder:

{{{
 \MODS <--- //empty folder//
 \UCP_modified_assets 	<--- //entire folder//
  dummy.bff
  JoneSoft.txt
  JSGME.exe <--- //run this in your S2U install folder//
  JSGME.ini
  nfsshift.bms
  NFSSInjector.exe
  quickbms.exe
  README_UCP.txt <--- //the file you are reading now//
  UCP_create_JSGME_install.cmd
  UCP_s2u_unpacker.cmd
}}}
		
Run //JSGME.exe// from your S2U install folder after copying. It will open a new window with the title "Generic Mod Enabler".


=== STEP 2: -- Backup Save Game ===

I strongly recommend that you make a backup of your save game file, which on my Win7 system is located at:

* C:\Users\ermo\Documents\SHIFT 2 UNLEASHED\profiles\default.sav


=== STEP 3a: -- Run Unpack Script ===

Run the //UCP_s2u_unpacker.cmd// script as administrator. 

* To run the script as administrator, you will need to right-click it and choose "Run as administrator".


=== STEP 3b: -- Activate Unpacked Version ===

Once the //UCP_s2u_unpacker.cmd// script has done its job, you need to activate the unpacked game files:

* In the JSGME window, select the "S2U_Unpacked_version" row in the "Available Mods:"
  column and press ">" to activate the unpacked version of S2U.
* Note that this process will take a while, as JSGME needs to make backups of several
  gigabytes of packed S2U game data and move approximately 6 GB of unpacked game data
  to your S2U installation folder.


=== STEP 3c: -- Rename TOCFiles ===

Once the unpacked version has been activated, you need to rename two files in the \TOCFiles folder to avoid the game crashing when it tries to read data from the now empty BFF game archive files:

* \TOCFiles\DirPaks.toc -> \TOCFiles\DirPaks-disabled.toc
* \TOCFiles\VehicleLiveries.toc -> \TOCFiles\VehicleLiveries-disabled.toc


=== STEP 4a: -- Run UCP Install Script ===

Now you'll need run the //UCP_create_JSGME_install.cmd// file that you copied into your Shift 2 install folder as administrator:

* To run the script as administrator, you will need to right-click it and choose
  "Run as administrator"
* You will be asked to "Press any key to continue..." so pay attention to the script output.
* This script automatically creates a folder called "\MODS\UCP_v1.1_JSGME_install" which
  contains all necessary files that will be used by the JSGME software to install the UCP. 


=== STEP 4b: -- Activate UCP ===

Once the //UCP_create_JSGME_install.cmd// script has done its job, you need to activate the UCP mod:

* In the JSGME window, select "UCP_v1.1_JSGME_install" in the left column then activate it by
  clicking the ">" button at the top between the two columns.
* After a little while, the activation process will prompt you about file conflicts between
  the already installed S2U_Unpacked_version and the UCP.
**  This is per design, so press "Yes" to begin the UCP activation process.
* Once this is complete, click "Close" and you have finished installing the UCP.


=== STEP 5: -- Ingame Actions ===

After installing the UCP, you should:

* Reset your saved car setups in the GARAGE> TUNING menu (using the "R" key),
**  This is due to the significant changes made to the car tuning (ie, fixing the reverse toe
    value bug). 
* Some users may also need to reset their controller profile after installation, otherwise
  their controller may not respond to steering.


== 4. Uninstall ==

If you want to uninstall the UCP, simply run //JSGME.exe//, select "UCP_v1.1_JSGME_install" in the right column then deactivate it by clicking the "<" button.

* once this is complete, click "Close" and the UCP will remain deactivated.
 (You can easily reactivate it later by following Step 4b of the Installation instructions)

Similarly, you can also disable the unpacked version, though it should be pointed out that the Unpacked version and the UCP are both intended to be the base on which all other mods build.


//The End//