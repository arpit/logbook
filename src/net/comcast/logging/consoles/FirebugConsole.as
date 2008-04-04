/*

The MIT License

Copyright (c) 2008 Comcast Interactive Media

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/
package net.comcast.logging.consoles{
	import net.comcast.logging.Level;
	import flash.utils.*;
	import flash.external.ExternalInterface;

	
	/**
	 * The FirebugConsole requires that the user have the firebug extension
	 * for Firefox installed.
	 * 
	 * warning: Console calls will cause errors if the user doesn't have it installed
	 * or the site doesn't have a logging framework
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