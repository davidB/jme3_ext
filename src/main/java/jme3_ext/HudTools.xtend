/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import java.net.URL
import javafx.fxml.FXMLLoader
import javafx.scene.layout.Region
import javax.inject.Inject
import javax.inject.Provider
import javax.inject.Singleton
import com.jme3x.jfx.AbstractHud
import com.jme3x.jfx.FXMLUtils
import com.jme3x.jfx.GuiManager
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import com.jme3.renderer.ViewPort

@Singleton
class HudTools {
    public final Provider<FXMLLoader> pFxmlLoader
    public final GuiManager guiManager

    @Inject
    @FinalFieldsConstructor
    new() {}
    
    def <T> Hud<T> newHud(String fxmlPath, T controller) {
        try {
            val FXMLLoader fxmlLoader = pFxmlLoader.get()
            val URL location = Thread.currentThread().getContextClassLoader().getResource(fxmlPath)
            if (location === null) {
                throw new IllegalArgumentException('''fxmlPath not available : «fxmlPath»''')
            }
            fxmlLoader.setLocation(location)
            fxmlLoader.setController(controller)
            val Region rv = fxmlLoader.load(location.openStream())
            if (!(FXMLUtils.checkClassInjection(controller))) {
                throw new AssertionError()
            }
            return new Hud<T>(rv, controller)
        } catch (RuntimeException exc) {
            throw exc
        } catch (Exception exc) {
            throw new RuntimeException(exc)
        }

    }

    def void show(AbstractHud hud) {
        if (hud !== null) {
            if(!hud.isInitialized()) hud.precache()
            guiManager.attachHudAsync(hud)
        }

    }

    def void hide(AbstractHud hud) {
        if (hud !== null) {
            guiManager.detachHudAsync(hud)
        }

    }

    def void scaleToFit(Hud<?> hud, ViewPort vp) {
		val cam = vp.getCamera()
		val cw = cam.getWidth()
		val pw = hud.region.prefWidth(cw)
		//double pw = hud.region.widthProperty().doubleValue();
		val rw = cw/pw
		val tw = (cw-pw) *0.5 * rw
		hud.region.scaleXProperty().set(rw)
		hud.region.translateXProperty().set(tw)

		val ch = cam.getHeight()
		val ph = hud.region.prefHeight(ch)
		//double ph = hud.region.widthProperty().doubleValue();
		val rh = ch/ph
		val th = (ch-ph) *0.5 * rh
		hud.region.scaleYProperty().set(rh)
		hud.region.translateYProperty().set(th)
	}
}
