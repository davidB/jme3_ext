/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import lombok.extern.slf4j.Slf4j
import com.jme3.app.Application
import com.jme3.app.SimpleApplication
import com.jme3.app.state.AbstractAppState
import com.jme3.app.state.AppStateManager

/** 
 * @author david.bernard
 */
@Slf4j abstract class AppState0 extends AbstractAppState {
    package org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(AppState0)
    protected SimpleApplication app

    override final void initialize(AppStateManager stateManager, Application app) {
        super.initialize(stateManager, app)
        try {
            this.app = app as SimpleApplication
            log.trace("doInitialize(): {}", this)
            doInitialize()
            initialized = true
            super.setEnabled(false)
            setEnabled(true)
        } catch (Exception exc) {
            log.warn("failed to initialize(..,..)", exc)
            throw exc
        }

    }

    override final void setEnabled(boolean enabled) {
        if(isEnabled() === enabled) return;
        super.setEnabled(enabled)
        if(!isInitialized()) return;
        try {
            if (enabled) {
                log.trace("doEnable(): {}", this)
                doEnable()
            } else {
                log.trace("doDisable(): {}", this)
                doDisable()
            }
        } catch (Exception exc) {
            log.warn('''failed to setEnabled(«enabled»)''', exc)
            throw exc
        }

    }

    override final void update(float tpf) {
        if (isEnabled()) {
            doUpdate(tpf)
        }

    }

    def protected void doInitialize() {
    }

    def protected void doEnable() {
    }

    def protected void doUpdate(float tpf) {
    }

    def protected void doDisable() {
    }

    def protected void doDispose() {
    }

    override final void cleanup() {
        setEnabled(false)
        try {
            if (isInitialized()) {
                log.trace("doDispose(): {}", this)
                doDispose()
            }

        } catch (Exception exc) {
            log.warn("failed to doDispose()", exc)
            throw exc
        }
        initialized = false
    }

}
