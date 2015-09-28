/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import javafx.scene.layout.Region
import com.jme3x.jfx.AbstractHud
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

@FinalFieldsConstructor 
class Hud<T> extends AbstractHud {
    public final Region region
    public final T controller

    override protected Region innerInit() throws Exception {
        return region
    }
}
