/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import javax.inject.Singleton
import com.jme3.app.Application
import com.jme3.app.SimpleApplication
import com.jme3.app.state.AppStateManager
import com.jme3.asset.AssetManager
import com.jme3.input.InputManager
import com.jme3x.jfx.GuiManager
import com.jme3x.jfx.cursor.ICursorDisplayProvider
import com.jme3x.jfx.cursor.proton.ProtonCursorProvider
import com.google.inject.AbstractModule
import com.google.inject.Provides

class JmeModule extends AbstractModule {
	override protected void configure() {
	}

	@Provides
	def Application application(SimpleApplication app) {
		return app
	}

	@Provides
	def AssetManager assetManager(SimpleApplication app) {
		return app.getAssetManager()
	}

	@Provides
	def AppStateManager stateManager(SimpleApplication app) {
		return app.getStateManager()
	}

	@Provides
	def InputManager inputManager(SimpleApplication app) {
		return app.getInputManager()
	}

	// -- Jfx-jme
	@Provides
	@Singleton
	def ICursorDisplayProvider cursorDisplayProvider(SimpleApplication app) {
		return new ProtonCursorProvider(app, app.getAssetManager(), app.getInputManager())
	}

	@Provides
	@Singleton
	def GuiManager guiManager(SimpleApplication app, ICursorDisplayProvider c) {
		try {
			// guiManager modify app.guiNode so it should run in JME Thread
			app.enqueue [
				val guiManager = new GuiManager(app.getGuiNode(), app.getAssetManager(), app, true, c);
				app.inputManager.addRawInputListener(guiManager.inputRedirector)
				guiManager
			].get() // HACK (Future.get is BAD and should be fix)
		} catch (RuntimeException e) {
			throw e
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage(), e)
		}
	}

}
