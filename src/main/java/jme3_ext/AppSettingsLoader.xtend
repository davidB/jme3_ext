/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import com.jme3.system.AppSettings

interface AppSettingsLoader {
    def AppSettings loadInto(AppSettings settings) throws Exception

    def AppSettings save(AppSettings settings) throws Exception

}
