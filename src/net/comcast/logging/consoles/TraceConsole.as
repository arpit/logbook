package net.comcast.logging.consoles{
	
	import flash.utils.*;
	import net.comcast.logging.Level;
	
	/**
	 * The TraceConsole is the simplest console type that
	 * just sends all log messages to the trace window.
	 * 
	 * warning: Trace statements do not work on non-debug 
	 * swfs or on debug swfs running on non-debug versions 
	 * of the flash player. Use this only during development. 
	 * 
	 */ 
	public class TraceConsole implements IConsole{
		
		public function log(source:*, level:Number, msg:String):void{
			trace("["+Level.getLevelString(level)+"]["+getQualifiedClassName(source)+"]"+msg);	
		}
	}
}