/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import com.jme3.app.state.AppState
import com.jme3.app.state.AppStateManager
import java.util.TreeMap
import java.util.Stack

class PageManager<P> {
    final AppStateManager stateManager
    
    public val pages = new TreeMap<P, AppState>()
    public val flow = new Stack<P>()

    new(AppStateManager stateManager) {
        this.stateManager = stateManager
    }
    
    def void back(P p) {
        flow.pop
        show(flow.peek)
    }
    
    def void goTo(P p) {
        if (p === flow.peek) {
            return;
        }
        if (pages.containsKey(p)) {
            hide(flow.pop)
            flow.push(p)
            show(p)
        }
    }

    def void show(P p) {
        val page = pages.get(p)
        if (page !== null) {
            stateManager.attach(page)
        }
    }

    def void hide(P p) {
        val page = pages.get(p)
        if (page !== null) {
            stateManager.detach(page)
        }
    }
}
