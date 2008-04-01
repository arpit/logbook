package net.comcast.logging.consoles{
	import net.comcast.logging.Level;
	import flash.utils.*;
	import flash.external.ExternalInterface;

	
	/**
	 * The FirebugConsole requires that the user have the firebug extension
	 * for Firefox installed
	 * 
	 * warning: Console calls will cause errors if the user doesn't have it installed
	 * or the site doesn't have a logging framework (as portalds does).
	 */ 
	public class FirebugConsole implements IConsole{
		
		public function log(source:*, level:Number, msg:String):void{
			var msg:String = "["+Level.getLevelString(level)+"]["+getQualifiedClassName(source)+"]"+msg;
			var jsLogFunc:String;
			switch (level)
			{
				case Level.FATAL:
					jsLogFunc = "console.error";
					break;
				case Level.WARN:
					jsLogFunc = "console.warn";
					break;
				case Level.INFO:
					jsLogFunc = "console.info";
					break;
				default:
					jsLogFunc = "console.log";
			} 
			ExternalInterface.call(jsLogFunc, msg);
			trace(msg);
		}
	}
}