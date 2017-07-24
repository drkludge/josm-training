The [gis/jz](../gis/jz/readme.md) folder is where the [gis/bin/josm.cmd](gis/bin/jsom.cmd) command expects to find the [AZUL Systems Java JDK known as Zulu](http://www.azul.com/downloads/zulu/).

1. For MS Window pick the zip archive from the [zulu-windows page](http://www.azul.com/downloads/zulu/zulu-windows/).  Yes we want the .zip file not the .msi file.  Yes we will use the server version not the client msi. The reason for this choice is that we want the installation to be portble and not tied to the MS registry. Also note as of 2017 **JOSM requires Java version 8 to function properly.**
2. Open the zip archive.
3. Copy the files in say, zulu8.21.0.1-jdk8.0.131-win_x64, to the \gis\apps\jz folder.  Note that the directory name in the zip archive will change with each release.
4. Download the JOSM jar.  See the gis\apps\josm directory.
5. Double click the josm.cmd file found in the gis\bin directory.

You should be up and running.

As of 7/2017 here are the list of files in the archive.  Please copy all these files and directories to the [jz](../gis/jz/readme.md)  directory.

```
bin
demo
include
jre
lib
sample
ASSEMBLY_EXCEPTION
DISCLAIMER
LICENSE
readme.txt
release
src.zip
THIRD_PARTY_README
Welcome.html```
