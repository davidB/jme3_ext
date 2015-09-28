/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_skel

import com.jme3.input.KeyInput
import com.jme3.input.event.KeyInputEvent
import jme3_ext.InputMapper
import org.junit.Test
import org.mockito.InOrder
import org.mockito.Mockito
import rx.Observer
import rx.subjects.PublishSubject
import rx.subjects.Subject

import static jme3_ext.InputMapperHelpers.tmplKeyInputEvent
import static org.mockito.Mockito.inOrder
import static org.mockito.Mockito.mock
import static org.mockito.Mockito.times
import static org.mockito.Mockito.verify
import jme3_ext.InputMapperHelpers

class InputMapperTest {
    package val sut = new InputMapper()

    @Test def void testDirectUsage() {
        // 1. Define action
        /*FIXME Cannot add Annotation to Variable declaration. Java code: @SuppressWarnings("unchecked")*/
        var Observer<Float> observer = mock(typeof(Observer))
        // 2. map InputEvents --to--> actions (setup InputMapper's mappings)
        sut.mappings.clear()
        sut.map(tmplKeyInputEvent(KeyInput::KEY_0), [InputMapperHelpers::isPressedAsOne(it)], observer) // 3. simulate events
        sut.onEvent(new KeyInputEvent(KeyInput::KEY_0, Character.valueOf('0').charValue, true, false))
        sut.onEvent(new KeyInputEvent(KeyInput::KEY_0, Character.valueOf('0').charValue, false, false)) // 4. check
        var InOrder inOrder1 = inOrder(observer)
        inOrder1.verify(observer, times(1)).onNext(1.0f)
        inOrder1.verify(observer, times(1)).onNext(0.0f)
        verify(observer, Mockito::never()).onCompleted()
    }

    @Test def void testIndirectUsage() {
        // 1. Define action (a biz facade points from where 'real' action)
        var Subject<Float, Float> actionf0 = PublishSubject::create()
        // 2. map InputEvents --to--> actions (setup InputMapper's mappings)
        sut.mappings.clear()
        sut.map(tmplKeyInputEvent(KeyInput::KEY_0), [InputMapperHelpers::isPressedAsOne(it)], actionf0) // 3. map actions --to--> subscribe listener/observer
        /*FIXME Cannot add Annotation to Variable declaration. Java code: @SuppressWarnings("unchecked")*/
        var Observer<Float> observer = mock(typeof(Observer))
        actionf0.subscribe(observer)
        sut.onEvent(new KeyInputEvent(KeyInput::KEY_0, Character.valueOf('0').charValue, true, false))
        sut.onEvent(new KeyInputEvent(KeyInput::KEY_0, Character.valueOf('0').charValue, false, false))
        var InOrder inOrder1 = inOrder(observer)
        inOrder1.verify(observer, times(1)).onNext(1.0f)
        inOrder1.verify(observer, times(1)).onNext(0.0f)
        verify(observer, Mockito::never()).onCompleted()
    }

}
