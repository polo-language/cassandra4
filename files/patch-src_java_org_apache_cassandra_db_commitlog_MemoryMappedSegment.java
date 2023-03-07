--- src/java/org/apache/cassandra/db/commitlog/MemoryMappedSegment.java.orig	2022-12-07 20:55:02 UTC
+++ src/java/org/apache/cassandra/db/commitlog/MemoryMappedSegment.java
@@ -25,7 +25,6 @@ import java.nio.channels.FileChannel;
 import org.apache.cassandra.config.DatabaseDescriptor;
 import org.apache.cassandra.io.FSWriteError;
 import org.apache.cassandra.io.util.FileUtils;
-import org.apache.cassandra.utils.NativeLibrary;
 import org.apache.cassandra.utils.SyncUtil;
 
 /*
@@ -90,7 +89,7 @@ public class MemoryMappedSegment extends CommitLogSegm
         {
             throw new FSWriteError(e, getPath());
         }
-        NativeLibrary.trySkipCache(fd, startMarker, nextMarker, logFile.absolutePath());
+//        NativeLibrary.trySkipCache(fd, startMarker, nextMarker, logFile.absolutePath());
     }
 
     @Override
