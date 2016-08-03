# FlashAir FTP Upload

This package adds/enables the following features to Toshiba FlashAir cards:

* Sets wifi to station mode, so it can connect to standard access points.
* Connect to wifi network on power-up.
* Sets wifi to continue attempting to connect indefinitely, in case your access point is slow or not ready when the FlashAir boots.
* Waits for an SD write event, then runs a script to upload the contents of the card to an FTP server
* Uploaded files are tracked and each only uploaded once.
* Optionally, files can be deleted after upload. **THIS FEATURE IS KNOWN TO CAUSE DATA LOSS**

The intended use for this is in a camera, so that every photo taken is uploaded to an FTP server.

### Note about delete-after-upload feature

When tested, the delete feature of the FlashAir cards would cause the next file write to be lost. If you have a solution for this, please let us know!

## Installation

1. Open `SD_WLAN/CONFIG` and edit the `APPSSID` and `APPNETWORKKEY` parameters for your wifi network.
2. Open `Settings.lua` and enter your FTP server details.

### Windows

3. Copy the files from this folder to your FlashAir card. The `CONFIG` file must overwrite your existing `CONFIG`. The `ftpupload.lua` and `Settings.lua` files must be in the root/top folder of the card.
4. Create a folder called `uploaded` on the card. Here, the ftpupload script will store information about which files have been previously uploaded.

### Mac OS X

3. Open Terminal.app.
4. `cd` to this folder, if you haven't already.
5. Run `install.sh`. For a new FlashAir card that hasn't been named, the command will be

    ./install.sh "/Volumes/NO NAME/"

Alternatively, you can install the files manually by following the Windows instructions.
