/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import java.util.LinkedList
import javafx.beans.property.FloatProperty
import javafx.beans.property.FloatPropertyBase
import javafx.collections.FXCollections
import javafx.collections.ListChangeListener
import javafx.collections.ObservableList
import javax.inject.Inject
import javax.inject.Singleton
import com.jme3.app.SimpleApplication
import com.jme3.audio.AudioNode
import org.eclipse.xtend.lib.annotations.Data

@Singleton class AudioManager {
    public final FloatProperty masterVolume = new VolumeProperty("master")
    public final FloatProperty musicVolume = new VolumeProperty("music")
    public final FloatProperty soundVolume = new VolumeProperty("sound")
    public final ObservableList<AudioNode> musics = FXCollections::observableList(new LinkedList<AudioNode>())
    final package SimpleApplication app

    @Inject 
    new(SimpleApplication app) {
        this.app = app
        masterVolume.addListener([applyVolumes()])
        musicVolume.addListener([applyVolumes()])
        soundVolume.addListener([applyVolumes()])
        musics.addListener((
            [ListChangeListener.Change<? extends AudioNode> c|applyVolumes()] as ListChangeListener<AudioNode>))
    }

    // every AudioNode (not in musics list)  have a volume of 1.0
    // to avoid change existing node volume and to avoid new AudioNode ask "what is the volume"
    // we adjust listener volume so that sound could stay to 1.0
    def void applyVolumes() {
        var float factor1 = Math::max(0.01f, soundVolume.floatValue())
        app.getListener().setVolume(masterVolume.floatValue() * factor1)
        val volume = musicVolume.floatValue() / factor1
        app.enqueue[
            musics.forEach[m| m.volume = volume]
            true
        ]
    }

    def void loadFromAppSettings() {
        loadVolume(masterVolume)
        loadVolume(musicVolume)
        loadVolume(soundVolume)
    }

    def void saveIntoAppSettings() {
        saveVolume(masterVolume)
        saveVolume(musicVolume)
        saveVolume(soundVolume)
    }

    def private final void loadVolume(FloatProperty p) {
        var Float v = app.getContext().getSettings().get(prefKeyOf(p)) as Float
        p.set(if((v === null)) 1.0f else v.floatValue())
    }

    def private final void saveVolume(FloatProperty p) {
        app.getContext().getSettings().put(prefKeyOf(p), p.get())
    }

    def private final String prefKeyOf(FloatProperty p) {
        return String::format("audio_%s_volume", p.getName())
    }

    @Data
    static package class VolumeProperty extends FloatPropertyBase {
        final String name

        override Object getBean() {
            return null
        }

        override String getName() {
            return name
        }

        override void set(float newValue) {
            super.set(Math::min(1.0f, Math::max(0.0f, newValue)))
        }
    }
}
