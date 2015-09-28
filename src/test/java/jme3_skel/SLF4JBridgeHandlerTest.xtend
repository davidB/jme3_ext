package jme3_skel

import jme3_ext.SetupHelpers
import org.junit.Test

class SLF4JBridgeHandlerTest {
    @Test def void testInstall() {
        SetupHelpers.installSLF4JBridge()
        SetupHelpers.testJul()
        SetupHelpers.uninstallSLF4JBridge()
    }

}
