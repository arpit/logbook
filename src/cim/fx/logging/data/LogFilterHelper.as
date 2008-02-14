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
	import mx.logging.LogEvent;
	// TODO: Document this class
	public class LogFilterHelper
	{
		public var filterCategories:Array;
		public var filterLevel:Number;
		public var filterTextQuery:String;
		private var startNum:Number;

		/**
		 * Constructor.
		 */
		public function LogFilterHelper(){
			
		}
		
		public function onCategory(item:LogMessage):Boolean {
			if(filterCategories == null || filterCategories.indexOf(item.category) != -1){
				return true;
			}
			return false;
		}
		public function onLevel(item:LogMessage):Boolean {
			if(filterLevel== -1) return true;
			if(filterLevel <= item.level ){
				return true;
			}
			return false;
		}
		
		public function onTextQuery(item:LogMessage):Boolean {
			if(filterTextQuery == "")return true;
			var quotesPattern:RegExp = /"[^"]*"/g;
			var allQuotes:Array = filterTextQuery.match(quotesPattern);
			
			var remainderWords:String = filterTextQuery.replace(quotesPattern, " ")
			var wordsPattern:RegExp = /(\w)+/g;
			var allWords:Array = remainderWords.match(wordsPattern);
			trace("The words in textField: "+allWords)
			trace("The strings in textField: "+allQuotes)
			for(var i:uint=0; i<allWords.length; i++){
				if(onLooseTextQuery(item, allWords[i])){
					return true;
				}
			}
			for(i=0; i<allQuotes.length; i++){
				var useNewStr:String = allQuotes[i].substring(1, allQuotes[i].length-2);
				trace(useNewStr)
				if(onStrictTextQuery(item,useNewStr)){
					return true;
				}
			}
			return false;			
		}
		
		public function onStrictTextQuery(item:LogMessage, str:String):Boolean{
			if(item.message.indexOf(str) != -1 
			|| LogEvent.getLevelString(item.level).indexOf(str) != -1 
			|| item.category.indexOf(str) != -1){
				return true;
			}
			return false;
		}
		
		public function onLooseTextQuery(item:LogMessage, str:String):Boolean {
			var m:String = item.message.toLowerCase();
			var l:String = LogEvent.getLevelString(item.level).toLowerCase();
			var c:String = item.category.toLowerCase();
			var ftq:String = str.toLowerCase();
			if(m.indexOf(ftq) != -1 
			|| l.indexOf(ftq) != -1 
			|| c.indexOf(ftq) != -1){
				return true;
			}
			return false;
		}
		
		public function onAll(item:LogMessage):Boolean{
			if(onCategory(item) && onTextQuery(item) && onLevel(item)){
				return true;
			}
			return false;
		}
		
		//private function filterAll(item:LogMessage):Boolean {
			
		//}
	}
}