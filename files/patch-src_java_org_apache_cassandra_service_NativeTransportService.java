--- src/java/org/apache/cassandra/service/NativeTransportService.java.orig	2020-12-18 17:35:13 UTC
+++ src/java/org/apache/cassandra/service/NativeTransportService.java
@@ -159,12 +159,15 @@ public class NativeTransportService
      */
     public static boolean useEpoll()
     {
+        /*
         final boolean enableEpoll = Boolean.parseBoolean(System.getProperty("cassandra.native.epoll.enabled", "true"));
 
         if (enableEpoll && !Epoll.isAvailable() && NativeLibrary.osType == NativeLibrary.OSType.LINUX)
             logger.warn("epoll not available", Epoll.unavailabilityCause());
 
         return enableEpoll && Epoll.isAvailable();
+        */
+        return false; // Epoll is only available for Linux. Prevent warning given that we otherwise pass ourselves off as Linux.
     }
 
     /**
