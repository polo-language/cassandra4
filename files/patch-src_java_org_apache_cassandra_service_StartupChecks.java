--- src/java/org/apache/cassandra/service/StartupChecks.java.orig	2022-12-07 20:55:03 UTC
+++ src/java/org/apache/cassandra/service/StartupChecks.java
@@ -365,6 +365,13 @@ public class StartupChecks
             if (options.isDisabled(getStartupCheckType()))
                 return;
             SigarLibrary.instance.warnIfRunningInDegradedMode();
+            try {
+                @SuppressWarnings("unused")
+                Class<?> loadMe = org.hyperic.sigar.SigarException.class;
+                SigarLibrary.instance.warnIfRunningInDegradedMode();
+            } catch (NoClassDefFoundError e) {
+                logger.info("Could not initialize SIGAR library: SIGAR option not selected during install or jar no longer available.");
+            }
         }
     };
 
