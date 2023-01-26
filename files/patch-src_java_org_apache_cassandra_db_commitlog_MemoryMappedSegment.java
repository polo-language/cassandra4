--- src/java/org/apache/cassandra/db/commitlog/MemoryMappedSegment.java.orig	2022-12-07 20:55:02 UTC
+++ src/java/org/apache/cassandra/db/commitlog/MemoryMappedSegment.java
@@ -90,7 +90,7 @@ public class MemoryMappedSegment extends CommitLogSegm
         {
             throw new FSWriteError(e, getPath());
         }
-        NativeLibrary.trySkipCache(fd, startMarker, nextMarker, logFile.absolutePath());
+//        NativeLibrary.trySkipCache(fd, startMarker, nextMarker, logFile.absolutePath());
     }
 
     @Override
