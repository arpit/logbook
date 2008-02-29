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
package cim.fx.logging.logBook
{
	import cim.fx.logging.connection.ConnectionLoggingListener;
	import cim.fx.logging.data.LogMessage;
	import cim.fx.logging.data.LogStorage;
	import cim.fx.logging.events.LogBookEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.System;
	import flash.ui.Keyboard;
	
	import mx.controls.Alert;
	import mx.core.WindowedApplication;
	import mx.events.CloseEvent;
	import mx.events.ListEvent;

	
	/**
	 * This is the code-behind class for the LogBook application.
	 * @author Kevin Fitzpatrick
	 */
	public class LogBookMain extends WindowedApplication
	{
		
		private var connectionLoggingListener:ConnectionLoggingListener;
		
		[Bindable]
		public var logStorage:LogStorage;
		
		
		//temporarily public
		protected var levelFilter:Number=-1;
		public var selectedCategories:Array= new Array();
		public var appSO:SavedWindowLocation;

		//FIXME: Let's see if we need to keep this or can't do it a better way
		public var keyArray:Array=new Array(false, false);
		
		
		//variables for file save
		private var stream:FileStream;	
		public var logsStringFormat:String;
		private var file:File;
		
		private var textString:String
		
		private var holdString:String;
		private var connectionName:String;
					
		protected function createLoggingListener():void{
			if(connectionLoggingListener == null){
				connectionLoggingListener = new ConnectionLoggingListener(connectionName);
				connectionLoggingListener.addEventListener(LogBookEvent.LOG_BOOK_LOG, handleLogEvent);	
			}
			else{
				this.connectionLoggingListener.setConnectionName(connectionName);
			}
			
		}
		
		
		/**
		 * The actual event handler for when a LogBookEvent is trigged.
		 * @private
		 */
		private function handleLogEvent(evt:LogBookEvent):void {
			logMessage(evt.logMessage);
		}
		
        /**
         * Traces out the LogMessage it receives. Child classes should override this.
         * @param	logObj	A LogMessage
         */
        public function logMessage(logObj:LogMessage):void
        {
        	// add message to the LogBook
        	logStorage.addLog(logObj);
        	dispatchEvent(new Event("LogMessagePost"));
        }
        
        /**
         * De-filter the logs
         */
        protected function clearCategoryFilter():void {
			logStorage.filter(null);
		}
        
        /**
         * Clear all the logs from the Application
         */
        protected function clearLogs():void {
        	logStorage.clear();
        }
        
        /**
		 * Simple function to save text contents to a txt file. 
		 *
		 */ 
		protected function onSaveLogsToFile():void{
			
			file = File.documentsDirectory;
			file = file.resolvePath("LogBookLogs.txt");
			
			file.addEventListener(Event.SELECT, onFileSelected, false, 0, true);
			stream = new FileStream();
			file.browseForSave("Choose a Location for your LogBook output file:");
		}
		
		private function onFileSelected(e:Event):void{
			file.cancel();
			stream.open(file, FileMode.WRITE);
			var useText:String = LogFormatter.getInstance().formatLogStorage(this.logStorage);
			stream.writeUTFBytes(useText);
			stream.close();
		}
		
		/**
		 * Event that sets a value of either the Control or C keys to true. 
		 * Means that button is currently pressed
		 */
		public function keyDownListener(evt:KeyboardEvent):void{
			if(evt.keyCode == 67){
				keyArray[1] = true;
			}else if(evt.keyCode == Keyboard.CONTROL){
				keyArray[0] = true;
			}
			if(keyArray[1]==true && holdString)System.setClipboard(holdString);
		}
		/**
		 * Event that resets the values of control or C keys to false. 
		 * 
		 */ 
		public function keyUpListener(evt:KeyboardEvent):void{
			if(evt.keyCode == 67){
				keyArray[1] = false;
			}else if(evt.keyCode == Keyboard.CONTROL){
				keyArray[0] = false;
			}else if(evt.keyCode == Keyboard.ENTER){
				
			}
		}
		/**
		 * Event places selection into a text view and sets holdString to that value for future copying. 
		 * Used in conjunction with key properties, text can be copied.
		 */ 
		public function onItemClick(evt:ListEvent):void{
			var selectedLog:LogMessage = evt.target.selectedItem as LogMessage;
			holdString = selectedLog.toString();
		}
		
		public function setConnectionName(connName:String):void{
			this.connectionName = connName;
			createLoggingListener();
		}
		
		/**
		 * Returns a string of the version number of the LogBook Application
		 */
		protected function getLocalVersion():String {
			var appDesc:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var airNS:Namespace = appDesc.namespace();
			return appDesc.airNS::version;
		}
	}
}