--- doc/gen-nodetool-docs.py.orig	2020-01-30 17:34:31 UTC
+++ doc/gen-nodetool-docs.py
@@ -53,7 +53,7 @@ def create_rst(command):
         cmdName = command.group(0).strip()
         cmdFilename = outdir + "/" + cmdName + ".txt"
         rstFilename = outdir + "/" + cmdName + ".rst"
-        with open(cmdFilename, "w+") as cmdFile:
+        with open(cmdFilename, "w+b") as cmdFile:
             proc = Popen([nodetool, "help", cmdName], stdin=PIPE, stdout=PIPE)
             (out, err) = proc.communicate()
             cmdFile.write(out)
@@ -72,7 +72,7 @@ with open(outdir + "/nodetool.rst", "w+") as output:
             output.write(command)
 
 # create the command usage pages
-with open(helpfilename, "rw+") as helpfile:
+with open(helpfilename, "r+") as helpfile:
     for commandLine in helpfile:
         command = command_re.match(commandLine)
         create_rst(command)
