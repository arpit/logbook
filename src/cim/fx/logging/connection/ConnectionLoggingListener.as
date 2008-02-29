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
	import cim.fx.logging.events.LogBookEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.LocalConnection;
	
	/**
	 * Dispatched when the LocalConnection receives a logMessage() command.
	 *  @eventType cim.fx.logging.events.LogBookEvent.LOG_BOOK_LOG
	 */
	[Event(name="logBookLog",type="cim.fx.logging.events.LogBookEvent")]
	
	public class ConnectionLoggingListener extends EventDispatcher
	{
		private var _connectionName:String;
		
		private var connection:LocalConnection;
		
		/**
		 * Constructor
		 * @param	p_connectionName	Name of the connection you wish to use.  
		 * 								Make sure your localconnection name begins 
		 * 								with an underscore since you are attempting a cross_domain connection.
		 * @param	p_domain			Name of domain you wish to allow. Allows all by default: <code>'*'</code>.
		 */
		public function ConnectionLoggingListener(p_connectionName:String, p_domain:String = "*") {
			_connectionName = p_connectionName;
			createConnection(p_domain);
		}  
		
		/**
		 * @private
		 * @param	domain	Domains to allow. Default is all: <code>'*'</code>
		 */
		private function createConnection(domain:String):void {
        	connection = new LocalConnection();
        	connection.allowDomain(domain);
        	// call all methods coming through the LC on this class 
        	connection.client = this;
        	if(_connectionName)
        	connection.connect(_connectionName);		
		}
		
		public function setConnectionName(name:String):void{
			try{
				connection.close()
			}
			catch(e:Error){
				trace('[ConnectionLoggingListener] Caught LC error');
				// connection wasn't connected, so could not be closed.
				// Flash Player really should have an isConnected method
				// for LocalConnections.
			}
			connection.connect(name);
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
			
			dispatchEvent(new LogBookEvent(log));
		}
	}
}