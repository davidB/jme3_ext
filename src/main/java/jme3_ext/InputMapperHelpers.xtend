/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import java.awt.im.InputContext
import java.util.Collection
import java.util.Deque
import java.util.Locale
import java.util.stream.Collectors
import rx.Observable
import rx.Observer
import rx.Subscription
import com.jme3.input.JoystickAxis
import com.jme3.input.JoystickButton
import com.jme3.input.event.InputEvent
import com.jme3.input.event.JoyAxisEvent
import com.jme3.input.event.JoyButtonEvent
import com.jme3.input.event.KeyInputEvent
import com.jme3.input.event.MouseButtonEvent
import com.jme3.input.event.MouseMotionEvent
import com.jme3.input.event.TouchEvent

/** 
 * A collection of functions, mainly to simplify usage of InputMapper.
 * @author David Bernard
 */
class InputMapperHelpers {
    /** 
     * The default InputEventHash function used by InputMapper.
     */
    def static int defaultInputEventHash(InputEvent evt) {
        // pseudo-pattern matching
        if (evt instanceof JoyAxisEvent) {
            var JoyAxisEvent e = evt as JoyAxisEvent
            return 1000 + e.getJoyIndex() * 100 + e.getAxisIndex()
        } else if (evt instanceof MouseMotionEvent) {
            return 2000
        } else if (evt instanceof JoyButtonEvent) {
            var JoyButtonEvent e = evt as JoyButtonEvent
            return 3000 + e.getJoyIndex() * 100 + e.getButtonIndex()
        } else if (evt instanceof MouseButtonEvent) {
            var MouseButtonEvent e = evt as MouseButtonEvent
            return 4000 + e.getButtonIndex()
        } else if (evt instanceof KeyInputEvent) {
            var KeyInputEvent e = evt as KeyInputEvent
            return 5000 + e.getKeyCode()
        } else if (evt instanceof TouchEvent) {
            var TouchEvent e = evt as TouchEvent
            return 6000 + e.getPointerId() * 100 + e.getType().ordinal()
        }
        return 0 // evt.hashCode();
    }

    /** 
     * A factory to create a Template KeyInputEvent usable with defaultInputEventHash.
     */
    def static KeyInputEvent tmplKeyInputEvent(int keyCode) {
        return new KeyInputEvent(keyCode, 0 as char, true, false)
    }

    /** 
     * A factory to create a Template JoyAxisEvent usable with defaultInputEventHash.
     */
    def static JoyAxisEvent tmplJoyAxisEvent(JoystickAxis axis) {
        return new JoyAxisEvent(axis, 0)
    }

    /** 
     * A factory to create a Template JoyButtonEvent usable with defaultInputEventHash.
     */
    def static JoyButtonEvent tmplJoyButtonEvent(JoystickButton button) {
        return new JoyButtonEvent(button, true)
    }

    /** 
     * A factory to create a Template MouseMotionEvent usable with defaultInputEventHash.
     */
    def static MouseMotionEvent tmplMouseMotionEvent() {
        return new MouseMotionEvent(0, 0, 0, 0, 0, 0)
    }

    /** 
     * A factory to create a Template MouseButtonEvent usable with defaultInputEventHash.
     */
    def static MouseButtonEvent tmplMouseButtonEvent(int btnIndex) {
        return new MouseButtonEvent(btnIndex, true, 0, 0)
    }

    /** 
     * Convert KeyInputEvent into true when isPressed() else false.
     */
    def static boolean isPressed(KeyInputEvent evt) {
        return evt.isPressed()
    }

    /** 
     * Convert KeyInputEvent into 1.0f when isPressed() else 0.0f.
     */
    def static float isPressedAsOne(KeyInputEvent evt) {
        return if(evt.isPressed()) 1.0f else 0.0f
    }

    /** 
     * Convert KeyInputEvent into -1.0f when isPressed() else 0.0f.
     */
    def static float isPressedAsNegOne(KeyInputEvent evt) {
        return if(evt.isPressed()) -1.0f else 0.0f
    }

    /** 
     * Convert KeyInputEvent into -1.0f when isPressed(), -0.5f when isRepeating, else 0.0f.
     */
    def static float isPressedNegOneAndHalf(KeyInputEvent evt) {
        return if(evt.isPressed()) -1.0f else if(evt.isRepeating()) -0.5f else 0.0f
    }

    def static Collection<InputEvent> findTemplatesOf(InputMapper inputMapper, Observer<?> dest) {
        return inputMapper.mappings.entrySet().stream().filter(null).map(null).collect(Collectors::toList())
    }

    def static void mapKey(InputMapper m, int keyCode, Observer<Float> dest, boolean asOne) {
        m.map(tmplKeyInputEvent(keyCode), if(asOne) null else null, dest)
    }

    def static void mapKey(InputMapper m, int keyCode, Observer<Boolean> dest) {
        m.map(tmplKeyInputEvent(keyCode), null, dest)
    }

    def static <T> Subscription latest(Observable<T> src, Deque<T> latest, int capacity) {
        return src.subscribe([v|
            if (latest.size == capacity) latest.removeLast()
            latest.addFirst(v)
        ])
    }

    /** 
     * for debug, print, logging,... 
     */
    def static String toString(InputEvent evt, boolean timePrefix) {
        if(evt === null) return "null"
        var String v = if(timePrefix) '''«evt.getTime()» '''.toString else ""
        if (evt instanceof JoyAxisEvent) {
            var JoyAxisEvent e = evt as JoyAxisEvent
            return v +
                String::format("JoyAxisEvent(joystickIndex : %s , axis: %s / %s, value : %s )", e.getJoyIndex(),
                    e.getAxis().getName(), e.getAxisIndex(), e.getValue())
        } else if (evt instanceof JoyButtonEvent) {
            var JoyButtonEvent e = evt as JoyButtonEvent
            return v +
                String::format("JoyButtonEvent(joystickIndex : %s , btn: %s / %s, value : %S)", e.getJoyIndex(),
                    e.getButton().getName(), e.getButtonIndex(), e.isPressed())
        }
        return v + evt.toString()
    }

    def static boolean isKeyboardAzerty() {
        return Locale::FRANCE.getCountry().equals(InputContext::getInstance().getLocale().getCountry())
    }

}
