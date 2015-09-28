/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import com.jme3.app.state.AppState
import com.jme3.app.state.AppStateManager

class PageManager {
    final AppStateManager stateManager
    final AppState[] pages
    int current = -1

    new(AppStateManager stateManager, AppState[] pages) {
        this.stateManager = stateManager
        this.pages = pages
    }

    def void goTo(int p) {
        if (p === current) {
            return;
        }
        hide(current)
        current = p
        show(current)
    }

    def void show(int p) {
        if (p < 0 || p >= pages.length) {
            return;
        }
        stateManager.attach({
            val _rdIndx_pages = p
            pages.get(_rdIndx_pages)
        })
    }

    def void hide(int p) {
        if (p < 0 || p >= pages.length) {
            return;
        }
        stateManager.detach({
            val _rdIndx_pages = p
            pages.get(_rdIndx_pages)
        })
    }

}
