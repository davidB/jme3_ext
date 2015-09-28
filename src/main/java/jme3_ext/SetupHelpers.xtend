/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import com.jme3.app.SimpleApplication
import com.jme3.input.InputManager
import com.jme3.input.Joystick
import com.jme3.input.JoystickAxis
import com.jme3.input.JoystickButton
import com.jme3.renderer.Camera
import java.io.File
import java.io.FileWriter
import java.io.PrintWriter
import java.util.logging.LogManager
import org.slf4j.bridge.SLF4JBridgeHandler
import java.util.logging.Logger

class SetupHelpers {
    static def disableDefaults(SimpleApplication app) {
        app.enqueue(null)
    }

    // see http://hub.jmonkeyengine.org/wiki/doku.php/jme3:advanced:debugging
    static def setDebug(SimpleApplication app, boolean v) {
        if (v) {
            testJul()
        }
        app.enqueue(null) // stateManager.attach(new StatsAppState());
        // val s = app.getStateManager().getState(BulletAppState.class);
        // if (s != null) s.setDebugEnabled(v);
        // Display.setResizable(v);
    }

    static def setAspectRatio(SimpleApplication app, float w, float h) {
        app.enqueue(null) // cam.resize(w, h, true);
        // cam.resize(cam.getWidth(), (int)(cam.getHeight() * 0.5), true);
        // app.getRenderManager().getPreViews().forEach((vp) -> {;
        // cp(cam, vp.getCamera());
        // });
        // app.getRenderManager().getPostViews().forEach((vp) -> {;
        // cp(cam, vp.getCamera());
        // });
        // app.getRenderManager().getMainViews().forEach((vp) -> {;
        // cp(cam, vp.getCamera());
        // });
    }

    static def cp(Camera src, Camera dest) {
        if (src !== dest) {
            dest.setViewPort(src.getViewPortLeft(), src.getViewPortRight(), src.getViewPortBottom(),
                src.getViewPortTop())
            dest.setFrustum(src.getFrustumNear(), src.getFrustumFar(), src.getFrustumLeft(), src.getFrustumRight(),
                src.getFrustumTop(), src.getFrustumBottom())
        }

    }

    static def logJoystickInfo(InputManager inputManager) {
        var File f = new File("log/joysticks.txt")
        f.getParentFile().mkdirs()
        val out = new PrintWriter(new FileWriter(f))
        try {
            dumpJoysticks(inputManager.getJoysticks(), out)
        } catch (Exception e) {
            throw new RuntimeException("Error writing joystick dump", e)
        } finally {
            if (out != null) out.close()
        }
    }

    static def dumpJoysticks(Joystick[] joysticks, PrintWriter out) {
        if (joysticks === null || joysticks.length === 0) {
            out.println("disable or empty")
            return;
        }
        for (Joystick j : joysticks) {
            out.println('''Joystick[«j.getJoyId()»]:«j.getName()»'''.toString)
            out.println('''  buttons:«j.getButtonCount()»'''.toString)
            for (JoystickButton b : j.getButtons()) {
                out.println('''   «b»'''.toString)
            }
            out.println('''  axes:«j.getAxisCount()»'''.toString)
            for (JoystickAxis axis : j.getAxes()) {
                out.println('''   «axis»'''.toString)
            }

        }

    }

    /** 
     * Redirect java.util.logging to slf4j :
     * * remove registered j.u.l.Handler
     * * add a SLF4JBridgeHandler instance to jul's root logger.
     */
    static def installSLF4JBridge() {
        val root = LogManager::getLogManager().getLogger("")
        for (h : root.getHandlers()) {
            root.removeHandler(h)
        }
        SLF4JBridgeHandler::install()
    }

    static def uninstallSLF4JBridge() {
        SLF4JBridgeHandler::uninstall()
    }

    // @Override
    // public void publish(LogRecord record) {
    // // following code will never capture event if FINER record are filtered (eg by ch.qos.logback.classic.jul.LevelChangePropagator)
    // if (record.getThrown() != null && Level.FINER.equals(record.getLevel()) /*&& "THROW".equals(record.getMessage()) */) {
    // record.setLevel(Level.WARNING);
    // }
    // super.publish(record);
    // };
    static def testJul() {
        testJul(Logger::getLogger(""))
    }

    static def testJul(Logger l) {
        l.config("jul.logger test : config")
        l.severe("jul.logger test : severe")
        l.warning("jul.logger test : warning")
        l.info("jul.logger test : info")
        l.fine("jul.logger test : fine")
        l.finer("jul.logger test : finer")
        l.finest("jul.logger test : finest")
        l.throwing("sourceClass", "sourceMethod", new Exception())
    }

}
