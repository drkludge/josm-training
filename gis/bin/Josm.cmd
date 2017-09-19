rem http://josm.openstreetmap.de/wiki/HowTo/JOSM-under-Linux
rem https://github.com/cobra/josm-update-script/blob/master/josm.sh
rem http://manpages.ubuntu.com/manpages/lucid/man1/josm.1.html
rem https://help.openstreetmap.org/questions/9169/josm-save-preferences-and-plugins-locally
rem java.exe -Xmx1024M -jar josm-tested.jar -Djosm.home="./JosmTestedSettings"
rem http://wiki.openstreetmap.org/wiki/JOSM/Windows
rem -Dsun.java2d.opengl=true
rem http://us.generation-nt.com/bug-610006-josm-please-enable-respecting-system-proxy-settings-help-201778952.html
rem JAVA_OPTS="$JAVA_OPTS -Djava.net.preferIPv4Stack=true -Djava.net.useSystemProxies=true"
rem 
rem http://comments.gmane.org/gmane.comp.gis.openstreetmap.devel/6328
rem /usr/share/josm and /usr/lib/josm is built into JOSM to look for
rem resources (e.g. images in /usr/share/josm/images/...)
rem 
rem Else, set JOSM_RESOURCES environment variable or set the java define
rem "josm.resource" (start josm via "java -Djosm.resource=/foo/bar ...")
rem 
rem http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=497559
rem /usr/lib/jvm/java-6-openjdk/bin/java -Dhttp.proxyHost=192.168.1.1 -Dhttp.proxyPort=3128 -jar /usr/share/josm/josm.jar
rem 
rem https://github.com/cobra/josm-update-script/blob/master/josm.sh
rem java -jar -Xmx$mem -Dsun.java2d.opengl=$useopengl $jarfile $@ >~/.josm/josm.log 2>&1
rem JAVA_HOME
rem JAVA_OPTS JAVA_OPTS="-Dhttp.proxyHost=yourProxyURL"  before starting
rem http://wiki.openstreetmap.org/wiki/JOSM/HOWTO/Run_from_flash_disk_with_Java
rem d options
rem http://wiki.openstreetmap.org/wiki/Java_Runtime_Environment#How_to_run_a_Java_application
rem http://alvinalexander.com/blog/post/java/java-xmx-xms-memory-heap-size-control
rem Else, set JOSM_RESOURCES environment variable or set the java define
rem "josm.resource" (start josm via "java -Djosm.resource=/foo/bar ...")

rem set temp/tmp so that files are not in
rem C:\Documents and Settings\User\Local Settings\Temp\JMapViewerTiles_User
SET TMP=\gis\data\josm_temp
SET TEMP=\gis\data\josm_temp
SET JOSM_RESOURCES=\gis\apps\josm
SET APPDATA=\gis\apps\josm
SET mydir=\gis\apps\josm
cd %mydir%
rem SET javaopt=-Xmx1024M
rem SET javaopt=-Xmx6G
rem rework command line switches to set JOSM directories:
rem -Djosm.pref=... - set the preferences directory
rem -Djosm.userdata=... - set the user data directory
rem -Djosm.cache=... - set the cache directory
rem -Djosm.home=homedir relocate all 3 directories to homedir.
rem Cache directory will be in homedir/cache (unless -Djosm.cache is set)
rem -Djosm.home has lower precedence, i.e. the specific setting overrides
rem the general one.
rem SET javaopt=-Xmx1024M -Dsun.java2d.opengl=true -Djosm.pref="\josm" -Djosm.cache="\josm_temp" -Djosm.userdata="\josm\data_files" -Djosm.home="\josm\JOSM"
rem simple GC logging messages -XX:+PrintGC
rem https://blog.codecentric.de/en/2014/01/useful-jvm-flags-part-8-gc-logging/
rem http://stackoverflow.com/questions/19026112/what-is-current-status-of-oracle-java-hotspot-vm-performance-options-usestring
rem -XX:+PrintStringTableStatistics and -XX:StringTableSize=. Java 7 
rem Based on my check of JDK6u21 and JDK7u21 using PrintFlagsFinal, we have the following values:
rem dropped from jvm7 -XX:+UseCompressedStrings
rem                                JDK6u21      JDK7u21
rem 
rem -XX:+UseStringCache              false         false
rem -XX:+UseCompressedStrings        false  <unsupported>
rem -XX:+OptimizeStringConcat        false          true
rem http://stackoverflow.com/questions/1049983/jvm-xxstringcache-argument
rem You need -XX:+AggressiveOpts to enable many of the weird options, -XX:+UseStringCache including.
rem http://www.oracle.com/technetwork/articles/java/vmoptions-jsp-140102.html
rem https://blog.codecentric.de/en/2014/01/useful-jvm-flags-part-8-gc-logging/
rem jvm 8 says Java HotSpot(TM) Client VM warning: ignoring option UseStringCache; support was removed in 8.0
rem -XX:+UseStringCache -XX:+PrintStringTableStatistics 
rem https://docs.oracle.com/javase/8/embedded/develop-apps-platforms/codecache.htm
rem http://stackoverflow.com/questions/16794783/how-to-read-a-verbosegc-output
rem http://zzzoot.blogspot.com/2009/02/java-mysql-increased-performance-with.html
rem -XX:+UseLargePages 
rem "C:\Program Files (x86)\Java\jre1.8.0_31\bin\java.exe" -XX:+PrintFlagsFinal -version

rem SET javaopt=-Xms512M -Xmx1256M -XX:+AggressiveOpts -XX:+PrintCodeCacheOnCompilation -XX:ReservedCodeCacheSize=12M -XX:+UseCodeCacheFlushing -XX:+PrintCodeCache -XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -XX:+PrintTenuringDistribution -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+PrintCommandLineFlags  -XX:+PrintFlagsFinal -Xloggc:josm.gc.log -XX:-UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=8K -XshowSettings:vm -XshowSettings:properties

(SET javaopt=)
rem SET javaopt=-Xms512M
SET javaopt=-Xms1024M
SET javaopt=%javaopt% -XX:+AggressiveOpts
rem -client = 32-bit client version
rem "Error: missing `server' JVM jvm.dll"
rem means that the correct JRE/JDK is requird.
rem -server = 32-bit server version.
rem "Error: This Java instance does not support a 64-bit JVM."
rem means that the correct JRE/JDK is requird.
rem -d64 = 64-bit server version.
rem Enable 64-bit server on 64-bit O/S.  The startup may be a bit slower.
SET javaopt=%javaopt% -client
set javaopt=%javaopt% -XX:+TieredCompilation
rem Constrain the default 32 meg code cache size to 12M.
rem The most that I have seen used with many plugins is 6.6M.
rem Use -XX:+PrintCodeCacheOnCompilation to find Code Cache size.
rem
rem SET javaopt=%javaopt% -XX:InitialCodeCacheSize=3M
rem SET javaopt=%javaopt% -XX:ReservedCodeCacheSize=12M
rem CodeCache: size=12288Kb used=2511Kb max_used=6565Kb free=9776Kb
rem
rem After 7/12/2016 JOSM 10526 update
rem SET javaopt=%javaopt% -XX:InitialCodeCacheSize=4M
rem SET javaopt=%javaopt% -XX:ReservedCodeCacheSize=16M
rem CodeCache: size=12288Kb used=7675Kb max_used=11665Kb free=4612Kb
rem CodeCache: size=16384Kb used=6646Kb max_used=12468Kb free=9737Kb
rem CodeCache: size=16384Kb used=9743Kb max_used=12920Kb free=6640Kb
rem CodeCache: size=16384Kb used=10516Kb max_used=13785Kb free=5867Kb
rem
rem SET javaopt=%javaopt% -XX:InitialCodeCacheSize=6M
rem SET javaopt=%javaopt% -XX:ReservedCodeCacheSize=18M
rem CodeCache: size=18432Kb used=12902Kb max_used=17074Kb free=5529Kb
rem CodeCache: size=18432Kb used=12902Kb max_used=17074Kb free=5529Kb
rem CodeCache: size=18432Kb used=15208Kb max_used=17507Kb free=3223Kb
rem CodeCache: size=18432Kb used=14353Kb max_used=17827Kb free=4078Kb
rem CodeCache: size=18432Kb used=14329Kb max_used=17842Kb free=4102Kb
rem
rem SET javaopt=%javaopt% -XX:InitialCodeCacheSize=10M
rem SET javaopt=%javaopt% -XX:ReservedCodeCacheSize=20M
rem CodeCache: size=20480Kb used=13798Kb max_used=16701Kb free=6681Kb
rem
rem SET javaopt=%javaopt% -XX:+PrintCodeCacheOnCompilation
SET javaopt=%javaopt% -XX:InitialCodeCacheSize=16M
SET javaopt=%javaopt% -XX:ReservedCodeCacheSize=24M
SET javaopt=%javaopt% -XX:+UseCodeCacheFlushing
SET javaopt=%javaopt% -XX:+PrintCodeCache
SET javaopt=%javaopt% -XX:+UseConcMarkSweepGC
SET javaopt=%javaopt% -XX:+DisableExplicitGC

SET javaopt=%javaopt% -XX:+PrintTenuringDistribution
SET javaopt=%javaopt% -XX:+PrintGC
SET javaopt=%javaopt% -XX:+PrintGCDetails
SET javaopt=%javaopt% -XX:+PrintGCTimeStamps
SET javaopt=%javaopt% -XX:+PrintGCDateStamps
SET javaopt=%javaopt% -XX:-UseGCLogFileRotation
SET javaopt=%javaopt% -XX:NumberOfGCLogFiles=10
SET javaopt=%javaopt% -XX:GCLogFileSize=8K
rem  https://blog.gceasy.io/2016/11/15/rotating-gc-log-files/
set  Generating time stamp & replacing '' with 0 and / with -
set file_suffix=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set file_suffix=%file_suffix: =0%
set file_suffix=%file_suffix:/=-%
SET javaopt=%javaopt% -Xloggc:josm_gc_%file_suffix%.log

SET javaopt=%javaopt% -XX:+PrintCommandLineFlags
SET javaopt=%javaopt% -XX:+PrintFlagsFinal
SET javaopt=%javaopt% -XshowSettings:vm
SET javaopt=%javaopt% -XshowSettings:properties

rem set josmopt=-Djosm.pref="\gis\apps\josm" -Djosm.cache="\gis\data\josm_temp" -Djosm.userdata="\gis\apps\josm\data_files" -Djosm.home="\gis\apps\josm"

rem https://josm.openstreetmap.de/wiki/Help/CommandLineOptions

rem Note that these options go before the -jar josm.jar portion of the commmand.
rem The options are called <Java-options>
(SET josmjvmopt=)
SET josmjvmopt=
SET josmjvmopt=%josmjvmopt% -Djosm.home="\gis\apps\josm"
SET josmjvmopt=%josmjvmopt% -Djosm.pref="\gis\apps\josm"
SET josmjvmopt=%josmjvmopt% -Djosm.cache="\gis\data\josm_temp"
SET josmjvmopt=%josmjvmopt% -Djosm.userdata="\gis\apps\josm\data_files"

rem Note that these are post -jar josm.jar options.  Here you will see
rem the dash dash, --, options set.
(SET josmopt=)
SET josmopt=
rem SET josmopt=%josmopt% --debug
SET josmopt=%josmopt% --set=lastDirectory=C:\gis\apps\josm\data_files
SET josmopt=%josmopt% --set=mapillary.start-directory=C:\gis\data\osm_survey\mapillary
SET josmopt=%josmopt% --set=search.history-size=80
SET josmopt=%josmopt% --set=select.history-size=80

rem for jython
rem java -cp "josm-jar.jar:/path/to/jython.jar"
(SET josmcp=)
rem SET josmcp=C:\gis\apps\josm\plugins\scripting\postgresql-9.4.1212.jar
rem SET josmcp=C:\gis\apps\josm\plugins\scripting\postgresql-9.4.1212.jar;.
rem SET josmcp=%mydir%\josm-tested.jar
rem SET josmcp=%josmcp%:%mydir%\data_files\plugins\scripting\jython-2.5.3.jar
rem SET josmcp=%mydir%\data_files\plugins\scripting\jython-2.5.3.jar

rem set the path to a python location.
SET PATH=C:\gis\apps\groovy;C:\gis\apps\josm\plugins\scripting;"C:\gis\apps\Explorer (x86)\Python";%path%
rem set path=.
SET GROOVY_HOME="C:\gis\apps\groovy"
set path=.;%path%
SET java_home="C:\gis\apps\jz"
SET path=%java_home%\bin;%path%

set

"java.exe" %javaopt% %josmjvmopt% -jar %mydir%\josm-tested.jar %josmopt% %josmcp%
set
pause
