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
package cim.fx.logging.events
{
	import flash.events.Event;
	import cim.fx.logging.data.LogMessage;
	
	/**
	 * Represents the log information for a single logging event.
	 *  The loging system dispatches a single event each time a process requests
	 *  information be logged.
	 *  This event can be captured by any object for storage or formatting.
	 * @author Kevin Fitzpatrick Kevin_Fitzpatrick2@cable.comcast.com
	 */ 
	public class LogBookEvent extends Event
	{
		public var logMessage:LogMessage;
		
		 /**
	     *  Event type constant; identifies a logging event.
	     */
	    public static const LOG_BOOK_LOG:String = "logBookLog";
		
		/**
		 * Constructor.
		 * 
		 * @param	logMessage	The LogMessage containing all the information 
		 */
		public function LogBookEvent(logMessage:LogMessage)
		{
			//TODO: implement function
			super(LogBookEvent.LOG_BOOK_LOG, false, false);
			this.logMessage = logMessage;
		}
		
		
		/**
		 *  @private
	     */
	    override public function clone():Event	
	    {
	        return new LogBookEvent(logMessage);
	    }
	}
}