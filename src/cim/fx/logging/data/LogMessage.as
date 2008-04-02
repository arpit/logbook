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
package cim.fx.logging.data
{
	import cim.fx.logging.logBook.LogLevelFormatter;
	import mx.formatters.DateFormatter;
	
	/**
	 *  A data object class used to store the info associated with a particular logging message.
	 */
		 
	[Bindable]
	public class LogMessage
	{
		/**
		 * The category the log message falls into.  Often the class which spawned the message is used.
		 */
		public var category:String;
		
		/**
		 * The text of the log message.
		 */
		public var message:String;
		
		/**
		 * The date/time when the message was created
		 */
		public var date:Date;
		
		/**
	     *  Provides access to the level for this log event.
	     *  Valid values are:
	     *    <ul>
	     *      <li><code>LogEventLogEventLevel.INFO</code> designates informational messages
	     *      that highlight the progress of the application at
	     *      coarse-grained level.</li>
	     *
	     *      <li><code>LogEventLevel.DEBUG</code> designates informational
	     *      level messages that are fine grained and most helpful when
	     *      debugging an application.</li>
	     *
	     *      <li><code>LogEventLevel.ERROR</code> designates error events that might
	     *      still allow the application to continue running.</li>
	     *
	     *      <li><code>LogEventLevel.WARN</code> designates events that could be
	     *      harmful to the application operation.</li>
	     *
	     *      <li><code>LogEventLevel.FATAL</code> designates events that are very
	     *      harmful and will eventually lead to application failure.</li>
	     *    </ul>
	     */
		public var level:Number;
		
		
		public function LogMessage():void {
		}
		
		//TODO: make this return something better formatted
		public function toString():String {
			var timestampFormatter:DateFormatter = new DateFormatter();
			var levelFormatter:LogLevelFormatter = new LogLevelFormatter();
			return timestampFormatter.format(date)+ '.' +
					date.getMilliseconds()+"\t\t"+
					category+"\t\t" +
					levelFormatter.format(level)+"\t\t"+
					message;
		}
	}
}