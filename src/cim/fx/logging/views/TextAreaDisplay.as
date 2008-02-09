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
package cim.fx.logging.views{
	import cim.fx.logging.data.LogMessage;
	import cim.fx.logging.data.LogStorage;
	import cim.fx.logging.logBook.LogFormatter;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TextArea;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;

	public class TextAreaDisplay extends TextArea{
		private var _data:LogStorage;
		private var textString:String;
		
		private var _dataProvider:ArrayCollection;
		private var formatter:LogFormatter;
		
		public function TextAreaDisplay(){
			formatter = LogFormatter.getInstance();
				
		}
		
		public function set dataProvider(d:ArrayCollection):void{
			_dataProvider = d;
			d.addEventListener(CollectionEvent.COLLECTION_CHANGE, onDataProviderChange);
		}
		
		private function onDataProviderChange(event:CollectionEvent):void{
			if(event.kind == CollectionEventKind.ADD){
				for each(var logEntry:LogMessage in event.items){
					this.text+=formatter.formatLog(logEntry)	
				}
			}
			else{
				this.text = "";
				var src:ArrayCollection = ArrayCollection(event.target);
				for(var i:Number = 0; i< src.length; i++){
					this.text += formatter.formatLog(LogMessage(src.getItemAt(i)));
				}
			}
			
			 
		}
	}
}