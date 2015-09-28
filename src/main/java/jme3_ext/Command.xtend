/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import rx.subjects.PublishSubject
import org.eclipse.xtend.lib.annotations.Data

@Data
final class Command<T> {
    public final String label
    public final PublishSubject<T> value = PublishSubject::create()

}
