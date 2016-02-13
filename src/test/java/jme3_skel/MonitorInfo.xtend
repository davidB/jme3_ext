package jme3_skel

import java.awt.DisplayMode
import java.awt.GraphicsDevice
import java.awt.GraphicsEnvironment
import org.lwjgl.opengl.Display
import com.jogamp.newt.MonitorDevice
import com.jogamp.newt.MonitorMode
import com.jogamp.newt.Screen
import com.jogamp.newt.util.MonitorModeUtil
import com.jogamp.nativewindow.util.Dimension

class MonitorInfo {

	def static void main(String[] args) {
		try {
			main1(args)
			main2(args);
			// main3(args)
		} catch (Exception exc) {
			exc.printStackTrace()
		}
	}

	def static void main1(String[] args) {
		System::out.printf("\n---------------------------------\n")
		var GraphicsEnvironment ge = GraphicsEnvironment::getLocalGraphicsEnvironment()
		var GraphicsDevice[] gs = ge.getScreenDevices()
		for (GraphicsDevice curGs : gs) {
			System::out.printf("\n\nDevice\n")
			System::out.printf("%s\t%s\t%s\n", curGs.isDisplayChangeSupported(), curGs.isFullScreenSupported(),
				curGs === ge.getDefaultScreenDevice())
			for (DisplayMode dm : curGs.getDisplayModes()) {
				System::out.printf("%dx%d\t%d\t%d\t%s\n", dm.getWidth(), dm.getHeight(), dm.getBitDepth(),
					dm.getRefreshRate(), dm === curGs.getDisplayMode())
			}
		// GraphicsConfiguration[] gc = curGs.getConfigurations();
		// for(GraphicsConfiguration curGc : gc)
		// {
		// Rectangle bounds = curGc.getBounds();
		// ColorModel cm = curGc.getColorModel();
		// ImageCapabilities ic = curGc.getImageCapabilities();
		// System.out.printf("%s,%s\t%sx%s\t%s\t%s\n", bounds.getX(), bounds.getY(), bounds.getWidth(), bounds.getHeight(), cm, ic);
		// }
		}
	}

	def static void main2(String[] args) {
	    System::out.printf("\n---------------------------------\n")
		// Pick the monitor:
		// Either the one used by a window ..
		// MonitorDevice monitor = window.getMainMonitor();
		for (Screen screen : Screen.getAllScreens()) {
			System::out.printf("Screen %s\n", screen) // Or arbitrary from the list ..
			for (MonitorDevice monitor : screen.getMonitorDevices()) {
				System::out.printf("Monitor %s\n", monitor) // Current and original modes ..
				val mmCurrent = monitor.queryCurrentMode()
				val mmOrig = monitor.getOriginalMode()
				// Target resolution
				val res = new Dimension(800, 600)
				// Target refresh rate shall be similar to current one ..
				val freq = mmCurrent.getRefreshRate()
				// Target rotation shall be similar to current one
				val rot = mmCurrent.getRotation()
				var monitorModes = monitor.supportedModes
                monitorModes = MonitorModeUtil.filterByFlags(monitorModes, 0); // no interlace, double-scan etc
                monitorModes = MonitorModeUtil.filterByRotation(monitorModes, rot);
                monitorModes = MonitorModeUtil.filterByResolution(monitorModes, res);
                monitorModes = MonitorModeUtil.filterByRate(monitorModes, freq);
                monitorModes = MonitorModeUtil.getHighestAvailableBpp(monitorModes);
				for (MonitorMode mm : monitorModes) {
					System::out.printf("MonitorMode %s %s\n", mm, mm.equals(mmOrig))
				}
			}
		}
	}

	def static void main3(String[] args) throws Exception {
		System::out.printf("\n---------------------------------\n") // {
		// org.lwjgl.opengl.DisplayMode dm = Display.getDesktopDisplayMode();
		// System.out.printf("DisplayMode %dx%d\t%d\t%s\n", dm.getWidth(), dm.getHeight(), dm.getFrequency(), dm.isFullscreenCapable());
		// }
		// {
		// org.lwjgl.opengl.DisplayMode dm = Display.getDisplayMode();
		// System.out.printf("DisplayMode %dx%d\t%d\t%s\n", dm.getWidth(), dm.getHeight(), dm.getFrequency(), dm.isFullscreenCapable());
		// }
		for (org.lwjgl.opengl.DisplayMode dm : Display.getAvailableDisplayModes()) {
			System::out.printf("DisplayMode %dx%d\t%d\t%s\n", dm.getWidth(), dm.getHeight(), dm.getFrequency(),
				dm.isFullscreenCapable())
		}
	}

}
