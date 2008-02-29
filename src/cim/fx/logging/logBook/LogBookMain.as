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
	import cim.fx.logging.connection.LogPage;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.core.WindowedApplication;

	
	/**
	 * This is the code-behind class for the LogBook application.
	 * @author Kevin Fitzpatrick
	 */
	public class LogBookMain extends WindowedApplication{
		[Bindable]
		public var logPage:LogPage;
		
		//temporarily public
		protected var levelFilter:Number=-1;
		public var selectedCategories:Array= new Array();
		public var appSO:SavedWindowLocation;

		
		//variables for file save
		private var stream:FileStream;	
		public var logsStringFormat:String;
		private var file:File;
		
		private var textString:String
		
		private var connectionName:String;
		
		public function createLogPage(connectionName:String):void{
			this.logPage = new LogPage(connectionName);
		}
		
        /**
		 * Simple function to save text contents to a txt file. 
		 *
		 */ 
		protected function onSaveLogsToFile():void{
			if(!logPage)return;
			file = File.documentsDirectory;
			file = file.resolvePath("LogBookLogs.txt");
			
			file.addEventListener(Event.SELECT, onFileSelected, false, 0, true);
			stream = new FileStream();
			file.browseForSave("Choose a Location for your LogBook output file:");
		}
		
		private function onFileSelected(e:Event):void{
			stream.open(file, FileMode.WRITE);
			var useText:String = LogFormatter.getInstance().formatLogStorage(this.logPage.logStorage);
			stream.writeUTFBytes(useText);
			stream.close();		
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