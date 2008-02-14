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
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	/**
	 * LogStorage is a data object to store all of the LogMessages that come into 
	 * LogBook so they can remain persistent throughout the runtime of the AIR
	 * app.
	 */ 
	public class LogStorage
	{
		/**
		 * @private
		 * Holds all of the LogMessages for the LogBook. No matter what the filter,
		 * this array will always be up to date.
		 */
		private var _logs:ArrayCollection;
		
		/**
		 * @private
		 * Holds a list of all the categories under which LogMessages have been filed.
		 */
		private var _categories:ArrayCollection;
		
		/**
		 * @private
		 * Sort used to organize categories ArrayCollection so that the List of 
		 * them stays alphabetical irregardless of the time of their adding.
		 */
		private var categorySorter:Sort
		
		private var filterHelper:LogFilterHelper;
		
		/**
		 * Constructor
		 */
		public function LogStorage() {
			_logs = new ArrayCollection();
			
			_categories = new ArrayCollection();
			
			filterHelper = new LogFilterHelper();
		}
		
		/**
		 * Add a log to the storage object. Stores its category as well.
		 * @param	log		A LogMessage object.
		 */
		public function addLog(log:LogMessage):void {
			_logs.addItem(log);
			var c:String = log.category;
			if(!_categories.contains(c)){
				_categories.addItem(c);
				// if the collection has no Sort yet, add one
				if(_categories.sort==null) {
					categorySorter = new Sort();
					categorySorter.fields = [new SortField(null, false)];
					_categories.sort = categorySorter;
				}
				_categories.refresh();
			}
		}
		
		/**
		 * Refreshes both of the ArrayCollections
		 */
		public function refresh():void {
			_logs.refresh();
			_categories.refresh();
		}
		
		
		/**
		 * Removes all the logs in memory.
		 */
		public function clear():void {
			filterHelper.filterCategories = null;
			_logs.source = [];
			_categories.source = [];	
		}
		
		/**
		 * Filters logs to look as though it only contains LogMessages whose
		 * categories matches one of the categories stored in the Array of strings 'categories'.
		 * @param	categories	An Array of the categories one wishes to filter for. 
		 */  
		public function filter(categories:Array):void {
			filterHelper.filterCategories = categories;
			_logs.filterFunction = filterHelper.onCategory;
			_logs.refresh();
		}
		public function filterLevel(level:Number=-1):void {
			filterHelper.filterLevel = level;
			_logs.filterFunction = filterHelper.onLevel;
			_logs.refresh();
		}
		/**
		 * Filters logs to look as though it only contains message who have
		 * the query in its message or it's category.
		 * 
		 * @param query		Text string to look for.
		 */
		public function filterText(query:String):void {
			filterHelper.filterTextQuery = query;
			_logs.filterFunction = filterHelper.onTextQuery;
			_logs.refresh();
		}
		
		/**
		 * Filter logs by category, level, and text string.
		 */
		public function filterAll(c:Array, l:Number, q:String):void{
			filterHelper.filterCategories = c;
			filterHelper.filterLevel = l;
			filterHelper.filterTextQuery = q;
			_logs.filterFunction = filterHelper.onAll;
			_logs.refresh();
		}
		
		[Bindable]
		public function set logs(ac:ArrayCollection):void {
		}
		
		public function get logs():ArrayCollection {
			return _logs;
		}
		
		[Bindable]
		public function set categories(c:ArrayCollection):void {
			_categories = c;
		}
		public function get categories():ArrayCollection {
			return _categories;
		}
		
		public function get length():Number {
			return _logs.length;
		}
	}
}