package net.comcast.logging{
	import net.comcast.logging.consoles.IConsole;
	import net.comcast.logging.consoles.TraceConsole;
	
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
		
		private static var _console:IConsole = new TraceConsole()
		private static var level:Number=200;
		
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
		
		
		
		/**
		 * @private
		 */ 
		private static function log(source:*, lvl:Number, msg:String):void{
			if(lvl>=level){
				/*var log:ILogger;
				
				if (source is String) 
					log = Log.getLogger(source);
				else
					log = Log.getLogger(Reflection.getClassName(source));
				*/
				_console.log(source,lvl,msg);
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
		public static function set console(c:IConsole):void{
			_console = c;
		} 
		
	}
}