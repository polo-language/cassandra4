--- src/java/org/apache/cassandra/utils/NativeLibrary.java.orig	2022-12-07 20:55:03 UTC
+++ src/java/org/apache/cassandra/utils/NativeLibrary.java
@@ -140,7 +140,10 @@ public final class NativeLibrary
         else if (osName.contains("mac"))
             return MAC;
 
-        logger.warn("the current operating system, {}, is unsupported by Cassandra", osName);
+        if (osName.contains("bsd"))
+            logger.warn("the current operating system, {}, is fantastic, though not officially supported by cassandra", osName);
+        else
+            logger.warn("the current operating system, {}, is unsupported by cassandra", osName);
         if (osName.contains("aix"))
             return AIX;
         else
