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

package net.comcast.logging{
	import net.comcast.logging.consoles.IConsole;
	
	/**
	 * The Logger class logs messages from the application to a 
	 * console. The Logger class itself is only responsible for
	 * determining whether the message should be logged based 
	 * on the level of the message. The formatting and output
	 * is handled by the console.Loggers can be instantiated with
	 * different Consoles (see TraceConsole, FlexConsole etc)
	 * 
	 * 
	 */ 
	 
	public class Logger{
		
		private static var level:Number=Level.ALL;
		
		[ArrayElementType("net.comcast.logging.consoles.IConsole")]
		private static var consoles:Array = [];
		
		/**
		 * This level should be used only for fatal failures
		 * 
		 * @param	source	The instance sending the log message
		 * @param	msg		The message string being sent
		 */ 
		public static function fatal( source:*, msg:String):void{
			log(source,	Level.FATAL, msg);
		}
		
		/**
		 * Errors on the application that it can safely recover 
		 * from should be logged using this method
		 * 
		 * @param	source	The instance sending the log message
		 * @param	msg		The message string being sent
		 */ 
		public static function error( source:*, msg:String):void{
			log(source,	Level.ERROR, msg);
		}
		
		/**
		 * Application level warnings for events that could create
		 * errors later should be logged using this.
		 * 
		 * @param	source	The instance sending the log message
		 * @param	msg		The message string being sent
		 */ 
		public static function warn( source:*, msg:String):void{
			log(source,	Level.WARN, msg);
		}
		
		/**
		 * Generic information messages should be logged using this.
		 * Should not be verbose
		 *  
		 * @param	source	The instance sending the log message
		 * @param	msg		The message string being sent
		 */ 
		public static function info( source:*, msg:String):void{
			log(source,	Level.INFO, msg);
		}
		
		/**
		 * Configuration settings should be logged using this
		 * 
		 * @param	source	The instance sending the log message
		 * @param	msg		The message string being sent
		 */ 
		public static function debug( source:*, msg:String):void{
			log(source,	Level.DEBUG, msg);
		}
		
		
		private static var _console:IConsole;
		/**
		 * @private
		 */ 
		private static function log(source:*, lvl:Number, msg:String):void{
			if(lvl>=level){
				for(var i:uint=0; i<consoles.length; i++){ 
					_console = consoles[i];
					_console.log(source,lvl,msg);
				}
			}
		}
		
		/**
		 * Set the logging level of the application.
		 * Only messages marked at equal to or higher
		 * than this level will be sent to the console.
		 * 
		 * @param	lvl	The level to set the logger at.
		 */ 
		public static function setLevel(lvl:Number):void{
			level = lvl;
		}
		
		public static function getLevel():Number{
			return level;
		}
		/**
		 * @deprecated 
		 */ 
		public static function set console(c:IConsole):void{
			addConsole(c);
		} 
		
		public static function addConsole(c:IConsole):void{
			consoles.push(c);	
		}
		
		public static function removeLogger(c:IConsole):void{
			var index:Number = consoles.indexOf(c);
			if(index==-1){
				throw new Error("Could not remove item from Array, item doesnt exist in the Array");
			}
			consoles.splice(index,1);
		}
		
	}
}