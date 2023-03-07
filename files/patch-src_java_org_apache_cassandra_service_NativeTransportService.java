--- src/java/org/apache/cassandra/service/NativeTransportService.java.orig	2022-12-07 20:55:03 UTC
+++ src/java/org/apache/cassandra/service/NativeTransportService.java
@@ -29,7 +29,6 @@ import org.slf4j.Logger;
 import org.slf4j.LoggerFactory;
 
 import io.netty.channel.EventLoopGroup;
-import io.netty.channel.epoll.Epoll;
 import io.netty.channel.epoll.EpollEventLoopGroup;
 import io.netty.channel.nio.NioEventLoopGroup;
 import io.netty.util.Version;
@@ -38,7 +37,6 @@ import org.apache.cassandra.config.EncryptionOptions;
 import org.apache.cassandra.metrics.ClientMetrics;
 import org.apache.cassandra.transport.Dispatcher;
 import org.apache.cassandra.transport.Server;
-import org.apache.cassandra.utils.NativeLibrary;
 
 /**
  * Handles native transport server lifecycle and associated resources. Lazily initialized.
@@ -160,12 +158,15 @@ public class NativeTransportService
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
