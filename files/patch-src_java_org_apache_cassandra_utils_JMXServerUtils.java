--- src/java/org/apache/cassandra/utils/JMXServerUtils.java.orig	2018-02-21 22:13:38 UTC
+++ src/java/org/apache/cassandra/utils/JMXServerUtils.java
@@ -46,6 +46,7 @@ import org.slf4j.LoggerFactory;
 import com.sun.jmx.remote.internal.RMIExporter;
 import com.sun.jmx.remote.security.JMXPluggableAuthenticator;
 import org.apache.cassandra.auth.jmx.AuthenticationProxy;
+import sun.misc.ObjectInputFilter;
 import sun.rmi.registry.RegistryImpl;
 import sun.rmi.server.UnicastServerRef2;
 
@@ -308,7 +309,7 @@ public class JMXServerUtils
         // to our custom Registry too.
         private Remote connectorServer;
 
-        public Remote exportObject(Remote obj, int port, RMIClientSocketFactory csf, RMIServerSocketFactory ssf)
+        public Remote exportObject(Remote obj, int port, RMIClientSocketFactory csf, RMIServerSocketFactory ssf, ObjectInputFilter unused)
         throws RemoteException
         {
             Remote remote = new UnicastServerRef2(port, csf, ssf).exportObject(obj, null, true);
