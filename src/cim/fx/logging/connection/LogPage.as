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
package cim.fx.logging.connection
{
	import cim.fx.logging.data.LogMessage;
	import cim.fx.logging.data.LogStorage;
	import cim.fx.logging.events.LogBookEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.LocalConnection;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Dispatched when the LocalConnection receives a logMessage() command.
	 *  @eventType cim.fx.logging.events.LogBookEvent.LOG_BOOK_LOG
	 */
	[Event(name="logBookLog",type="cim.fx.logging.events.LogBookEvent")]
	
	/**
	 * LogPage is the data model representing one 
	 * Logging connection. The LogBook can manage multiple 
	 * LogPages
	 */ 
	
	public class LogPage extends EventDispatcher{
		
		[Bindable]
		public var logStorage:LogStorage;
		
		private var _connectionName:String;
		
		private var connection:LocalConnection;
		
		/**
		 * Constructor
		 * @param	p_connectionName	Name of the connection you wish to use.  
		 * 								Make sure your localconnection name begins 
		 * 								with an underscore since you are attempting a cross_domain connection.
		 * @param	p_domain			Name of domain you wish to allow. Allows all by default: <code>'*'</code>.
		 */
		public function LogPage(p_connectionName:String, p_domain:String = "*") {
			_connectionName = p_connectionName;
			logStorage = new LogStorage();
			createConnection(p_domain);
		}  
		
		/**
		 * @private
		 * @param	domain	Domains to allow. Default is all: <code>'*'</code>
		 */
		private function createConnection(domain:String):void {
        	connection = new LocalConnection();
        	connection.allowDomain(domain);
        	connection.client = this;
        	if(_connectionName)
        	connection.connect(_connectionName);		
		}
		
		
		/**
		 * A LocalConnection closure method sent by a LocalConnectionTarget
		 * @param	date		Timestamp of the message.
		 * @param	category	Category of the message.  Often the class which spawned the message.
		 * @param	level		Level of the message. See LogEventLevel & LogEvent.
		 * @param 	message		The text of the message.
		 *  
		 * @see	cim.fx.logging.targets.LocalConnectionTarget
		 */
		public function logMessage(date:Date, category:String, level:Number, message:String):void {
			var log:LogMessage = new LogMessage();
			log.date = date;
			log.category = category;
			log.level = level;
			log.message = message;
			logStorage.addLog(log);
		}
		
		/**
         * Clear all the logs from the Application
         */
        public function clearLogs():void {
        	logStorage.clear();
        }
        
        /**
         * De-filter the logs
         */
        public function clearCategoryFilter():void {
			logStorage.filter(null);
		}
		
		/**
		 * Filter through the logs via categories, levels and text values
		 * 
		 * @param	category	An array of categories
		 * @param	level		Only logs above this level will be seen
		 * @param	text		Only logs with this as a substring will be seen
		 */ 
		public function filterAll(category:Array, level:Number, text:String):void{
			logStorage.filterAll(category, level, text);
		}
	}
}