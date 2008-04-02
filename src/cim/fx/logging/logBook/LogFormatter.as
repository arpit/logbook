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
package cim.fx.logging.logBook{
	import cim.fx.logging.data.LogMessage;
	import cim.fx.logging.data.LogStorage;
	import mx.formatters.DateFormatter;
	
	/**
	 * Formats the Log Messages to a format easy to
	 * view. Implemented as a Singleton.
	 */ 
	public class LogFormatter{
		private var timestampFormatter:DateFormatter = new DateFormatter();
		private var levelFormatter:LogLevelFormatter = new LogLevelFormatter();
		
		/**
		 * @private
		 */ 
		public function LogFormatter(){
			timestampFormatter.formatString = "JJ:NN:SS";
		}
		
		private static var instance:LogFormatter;
		/**
		 * Singleton access
		 */ 
		public static function getInstance():LogFormatter{
			if(!instance){
				instance = new LogFormatter();
			}
			return instance;
		}
		
		/**
		 * Formats the LogMessage objects as needed.
		 * @see cim.fx.logging.data.LogMessage
		 * 
		 * @param	logEntry	The <code>LogMessage</code> object to be formatted.
		 */ 
		public function formatLog(logEntry:LogMessage):String{
			var ts:String = timestampFormatter.format(logEntry.date)+" \t"
			var lf:String = padTrailing(levelFormatter.format(logEntry.level), 10, " ");
			return ts+lf+padTrailing(logEntry.category, 25, " ")+logEntry.message+"\n";	
		}
		
		/**
		 * Format an array of <code>LogMessage</code> objects and return a String 
		 * representation of it all. Used when the LogBook goes from grid view to
		 * text view.
		 * 
		 * @param	sourceArray	An array of <code>LogMessage</code> objects.
		 * @see	cim.fx.logging.data.LogMessage
		 */ 
		public function formatLogs(sourceArray:Array):String{
			var textString:String = "";
			for(var i:int; i<sourceArray.length; i++){
				textString+=formatLog(LogMessage(sourceArray[i]));
			}
			return textString;
		}
		
		/**
		 * Format all the logs in a LogStorage
		 * 
		 * @param	data	An instance of <code>LogStorage</code>
		 * @see	cim.fx.logging.data.LogStorage
		 */ 
		public function formatLogStorage(data:LogStorage):String {
			var sourceArray:Array = data.logs.source;
			return formatLogs(sourceArray);
			
		}
		
		private function padTrailing(s:String, n:Number, char:String = " "):String{
			var diff:Number = n-s.length;
			for(var i:Number=0;i<diff; i++){
				s += char
			} 
			return s;
		}

	}
}