package jme3_ext

import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.net.URLClassLoader
import java.util.Locale
import java.util.Properties
import java.util.ResourceBundle
import java.util.Scanner
import java.util.TreeMap

/** 
 * from http://hub.jmonkeyengine.org/t/i18n-from-csv-calc/31492
 * @author Empire_Phoenix
 */
class I18NUtility {
	static TreeMap<File, ClassLoader> processed = new TreeMap()

	private new() {
	}

	def synchronized static ResourceBundle getBundle(File csv, Locale local) {
		val String csvname = csv.getName().replace(".csv", "")
		var ClassLoader i18nloader = I18NUtility::processed.get(csv)
		if (i18nloader === null) {
			val in = new Scanner(csv)
			try {
				// process header
				val header = in.nextLine().split(";")
				val outFiles = <File>newArrayOfSize(header.length)
				val languageProperties = <Properties>newArrayOfSize(header.length)

				for (var int i = 2; i < header.length; i++) {
					var String language = header.get(i)
					if (!language.isEmpty()) {
						language = '''_«language»'''
					}
					val File outFile = new File(csv.getParentFile(), '''«csvname»«language».properties''')
					outFiles.set(i, outFile)
					languageProperties.set(i, new Properties())
				}
				// reading to properties
				while (in.hasNextLine()) {
					val String[] line = in.nextLine().split(";")
					val String key = line.get(0)

					for (var int i = 2; i < languageProperties.length; i++) {
						languageProperties.get(i).setProperty(key, line.get(i))
					}
				}
				// writing
				for (var int i = 2; i < languageProperties.length; i++) {
					languageProperties.get(i).store(
						new FileOutputStream(outFiles.get(i)), '''generated from «csv.getName()»''')
				}
				val urls = #[csv.getParentFile().toURI().toURL()]
				i18nloader = new URLClassLoader(urls)
				I18NUtility::processed.put(csv, i18nloader)
			} catch (IOException e) {
				throw new RuntimeException(e)
			} finally {
				in.close()
			}

		}
		return ResourceBundle::getBundle(csvname, local, i18nloader)
	}
}
