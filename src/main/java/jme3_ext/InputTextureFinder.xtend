/// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
package jme3_ext

import com.jme3.input.Joystick
import com.jme3.input.KeyInput
import com.jme3.input.event.InputEvent
import com.jme3.input.event.JoyAxisEvent
import com.jme3.input.event.JoyButtonEvent
import com.jme3.input.event.KeyInputEvent
import com.jme3.input.event.MouseButtonEvent
import com.jme3.input.event.MouseMotionEvent
import java.net.URL

class InputTextureFinder {
	public String base="Textures/Inputs"
	public String folderKeyInputEvent="Keyboard & Mouse"
	public String theme="Black"

	/** 
	 * @TODO complete missing conversion, texture,...
	 * @TODO provide alternative for LSHIFT/RSHIFT, LCONTROL/RCONTROL, DIVIDE/SLASH,...
	 * @TODO provide alternative for numpad and regular number
	 */
	def String find(KeyInputEvent evt) {
		var String variant=null 
		
		switch (evt.getKeyCode()) {
			case KeyInput.KEY_0:{
				variant="0"
			}
			case KeyInput.KEY_1:{
				variant="1"
			}
			case KeyInput.KEY_2:{
				variant="2"
			}
			case KeyInput.KEY_3:{
				variant="3"
			}
			case KeyInput.KEY_4:{
				variant="4"
			}
			case KeyInput.KEY_5:{
				variant="5"
			}
			case KeyInput.KEY_6:{
				variant="6"
			}
			case KeyInput.KEY_7:{
				variant="7"
			}
			case KeyInput.KEY_8:{
				variant="8"
			}
			case KeyInput.KEY_9:{
				variant="9"
			}
			case KeyInput.KEY_NUMPAD0:{
				variant="0"
			}
			case KeyInput.KEY_NUMPAD1:{
				variant="1"
			}
			case KeyInput.KEY_NUMPAD2:{
				variant="2"
			}
			case KeyInput.KEY_NUMPAD3:{
				variant="3"
			}
			case KeyInput.KEY_NUMPAD4:{
				variant="4"
			}
			case KeyInput.KEY_NUMPAD5:{
				variant="5"
			}
			case KeyInput.KEY_NUMPAD6:{
				variant="6"
			}
			case KeyInput.KEY_NUMPAD7:{
				variant="7"
			}
			case KeyInput.KEY_NUMPAD8:{
				variant="8"
			}
			case KeyInput.KEY_NUMPAD9:{
				variant="9"
			}
			case KeyInput.KEY_A:{
				variant="A"
			}
			case KeyInput.KEY_B:{
				variant="B"
			}
			case KeyInput.KEY_C:{
				variant="C"
			}
			case KeyInput.KEY_D:{
				variant="D"
			}
			case KeyInput.KEY_E:{
				variant="E"
			}
			case KeyInput.KEY_F:{
				variant="F"
			}
			case KeyInput.KEY_G:{
				variant="G"
			}
			case KeyInput.KEY_H:{
				variant="H"
			}
			case KeyInput.KEY_I:{
				variant="I"
			}
			case KeyInput.KEY_J:{
				variant="J"
			}
			case KeyInput.KEY_K:{
				variant="K"
			}
			case KeyInput.KEY_L:{
				variant="L"
			}
			case KeyInput.KEY_M:{
				variant="M"
			}
			case KeyInput.KEY_N:{
				variant="N"
			}
			case KeyInput.KEY_O:{
				variant="O"
			}
			case KeyInput.KEY_P:{
				variant="P"
			}
			case KeyInput.KEY_Q:{
				variant="Q"
			}
			case KeyInput.KEY_R:{
				variant="R"
			}
			case KeyInput.KEY_S:{
				variant="S"
			}
			case KeyInput.KEY_T:{
				variant="T"
			}
			case KeyInput.KEY_U:{
				variant="U"
			}
			case KeyInput.KEY_V:{
				variant="V"
			}
			case KeyInput.KEY_W:{
				variant="W"
			}
			case KeyInput.KEY_X:{
				variant="X"
			}
			case KeyInput.KEY_Y:{
				variant="Y"
			}
			case KeyInput.KEY_Z:{
				variant="Z"
			}
			case KeyInput.KEY_UP:{
				variant="Arrow_Up"
			}
			case KeyInput.KEY_DOWN:{
				variant="Arrow_Down"
			}
			case KeyInput.KEY_LEFT:{
				variant="Arrow_Left"
			}
			case KeyInput.KEY_RIGHT:{
				variant="Arrow_Right"
			}
			case KeyInput.KEY_SPACE:{
				variant="Space"
			}
			case KeyInput.KEY_TAB:{
				variant="Tab"
			}
			case KeyInput.KEY_CAPITAL:{
				variant="Caps_Lock"
			}
			case KeyInput.KEY_LSHIFT,
			case KeyInput.KEY_RSHIFT:{
				variant="Shift"
			}
			case KeyInput.KEY_LCONTROL,
			case KeyInput.KEY_RCONTROL:{
				variant="Ctrl"
			}
			case KeyInput.KEY_LMENU,
			case KeyInput.KEY_RMENU:{
				variant="Alt"
			}
			case KeyInput.KEY_LMETA,
			case KeyInput.KEY_RMETA:{
				variant="Command"
			}// or "Win"
			
			case KeyInput.KEY_BACK:{
				variant="Backspace"
			}
			case KeyInput.KEY_DELETE:{
				variant="Del"
			}
			case KeyInput.KEY_RETURN:{
				variant="Enter_Alt"
			}
			case KeyInput.KEY_ESCAPE:{
				variant="Esc"
			}
			case KeyInput.KEY_HOME:{
				variant="Home"
			}
			case KeyInput.KEY_END:{
				variant="End"
			}
			case KeyInput.KEY_PGDN:{
				variant="Page_Down"
			}
			case KeyInput.KEY_PGUP:{
				variant="Page_Up"
			}
			case KeyInput.KEY_INSERT:{
				variant="Insert"
			}
			case KeyInput.KEY_SUBTRACT,
			case KeyInput.KEY_MINUS:{
				variant="Minus"
			}
			case KeyInput.KEY_DIVIDE,// ???
			
			case KeyInput.KEY_SLASH:{
				variant="Slash"
			}
			case KeyInput.KEY_MULTIPLY:{
				variant="Asterisk"
			}
			case KeyInput.KEY_NUMLOCK:{
				variant="Num_Lock"
			}
		}return if ((variant !== null)) String.format("%s/%s/Keyboard_%s_%s.png", base, folderKeyInputEvent, theme, variant) else null  
	}
	def String find(MouseButtonEvent evt) {
		var String variant=null 
		
		switch (evt.getButtonIndex()) {
			case 0:{
				variant="Left"
			}
			case 1:{
				variant="Right"
			}
			case 2:{
				variant="Middle"
			}
		}return if ((variant !== null)) String.format("%s/%s/Keyboard_%s_Mouse_%s.png", base, folderKeyInputEvent, theme, variant) else null  
	}
	def String find(MouseMotionEvent evt) {
		return String.format("%s/%s/Keyboard_%s_Mouse_Simple.png", base, folderKeyInputEvent, theme) 
	}
	//TODO use value of the event to provide more info (eg: Dpad_Left, mixing with Directional Arrow)
	def String find(JoyAxisEvent evt) {
		val prefix = findJoystickPrefix(evt.getAxis().getJoystick()) 
        val variant0 = evt.getAxis().getName() 
		val variant = switch (variant0) {
			case "Left Thumb 3": "LB"
			case "Right Thumb 3": "RB"
			case "y": "Left_Stick"
			case "x": "Left_Stick"
			case "rx": "Right_Stick"
			case "ry": "Right_Stick"
			case "z": "LT"
			case "rz": "RT"
			case "pov": "Dpad"
			case "pov_x": if (evt.getValue() > 0.5) "Dpad_Right" else if (evt.getValue() < -0.5) "Dpad_Left" else "Dpad"
			case "pov_y": if (evt.getValue() > 0.5) "Dpad_Up" else if (evt.getValue() < -0.5) "Dpad_Down" else "Dpad"
			default: variant0
		}//TODO force capitalize(variant) ?
		String.format("%s/%s_%s.png", base, prefix, variant) 
	}
	
	def String find(JoyButtonEvent evt) {
		val prefix = findJoystickPrefix(evt.getButton().getJoystick()) 
		val variant0 = evt.getButton().getName() 
		val variant = switch (variant0) {
			case "Left Thumb 3": "LT"
			case "Right Thumb 3": "RT"
			case "Left Thumb": "LB"
			case "Right Thumb": "RB"
			case "Select": "Back"
			case "Mode": "Start"
			default: variant0
		}//TODO force capitalize(variant) ?
		String.format("%s/%s_%s.png", base, prefix, variant) 
	}

	def String findJoystickPrefix(Joystick joystick) {
		var String kindName=joystick.getName().toLowerCase() 
		// xbox is used as generic gamepad until there are assets for others.
		if ((kindName.contains("xbox") || kindName.contains("x-box")) && kindName.contains("360")) {
		      "Xbox 360/360" 
		} else if ((kindName.contains("xbox") || kindName.contains("x-box")) && kindName.contains("one")) {
		      "Xbox One/One" 
		} else if (kindName.contains("ps3")) {
			 "PS3/PS3" 
		} else if (kindName.contains("ps4")) {
			 "PS4/PS4" 
		} else if (kindName.contains("ouya")) {
			 "Ouya/Ouya" 
		} else {
		    "Generic"
		}
	}
	//TODO manage TouchEvent
	//TODO send url of a default (unknown texture)
	def private String findPath0(InputEvent evt) {
		var String path=if ((evt instanceof JoyButtonEvent)) find(evt as JoyButtonEvent) else if ((evt instanceof JoyAxisEvent)) find(evt as JoyAxisEvent) else if ((evt instanceof KeyInputEvent)) find(evt as KeyInputEvent) else if ((evt instanceof MouseButtonEvent)) find(evt as MouseButtonEvent) else if ((evt instanceof MouseMotionEvent)) find(evt as MouseMotionEvent) else null      
		return path 
	}
	def String findPath(InputEvent evt) {
		var String path=findPath0(evt) 
		var URL url=if ((path !== null)) Thread.currentThread().getContextClassLoader().getResource(path) else null  
		return if ((url === null)) '''«base»/undef.png''' else path  
	}
	def URL findUrl(InputEvent evt) {
		var String path=findPath(evt) 
		return if ((path !== null)) Thread.currentThread().getContextClassLoader().getResource(path) else null  
	}
}