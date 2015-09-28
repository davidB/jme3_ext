/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import javax.inject.Inject
import com.jme3.input.RawInputListener
import com.jme3.input.event.JoyAxisEvent
import com.jme3.input.event.JoyButtonEvent
import com.jme3.input.event.KeyInputEvent
import com.jme3.input.event.MouseButtonEvent
import com.jme3.input.event.MouseMotionEvent
import com.jme3.input.event.TouchEvent
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

/** 
 * A RawInputListener that forward every InputEvent to InputMapper.onEvent(...)
 * where dispatching can be applied.
 * @author David Bernard
 */
package class RawInputListener4InputMapper implements RawInputListener {
    final public InputMapper inputMapper

    @Inject
    @FinalFieldsConstructor
    new() {}

    override void beginInput() {
    }

    override void endInput() {
    }

    override void onJoyAxisEvent(JoyAxisEvent evt) {
        inputMapper.onEvent(evt)
    }

    override void onJoyButtonEvent(JoyButtonEvent evt) {
        inputMapper.onEvent(evt)
    }

    override void onMouseMotionEvent(MouseMotionEvent evt) {
        inputMapper.onEvent(evt)
    }

    override void onMouseButtonEvent(MouseButtonEvent evt) {
        inputMapper.onEvent(evt)
    }

    override void onKeyEvent(KeyInputEvent evt) {
        inputMapper.onEvent(evt)
    }

    override void onTouchEvent(TouchEvent evt) {
        inputMapper.onEvent(evt)
    }
}
