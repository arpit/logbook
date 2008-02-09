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
	import flash.events.MouseEvent;
	import flash.desktop.Clipboard;
	import flash.desktop.NativeDragOptions;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.Event;
	import mx.controls.DataGrid;
	import mx.collections.ArrayCollection;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	/*change:
	 TransferableData to Clipboard, 
	 TransferableFormats to ClipboardFormats 
	 and resolve() to resolvePath() 
	 NativeDragManager instead of DragManager
	 NativeDragOptions instead of DragOptions
	 addData to setData
	 to get this to work with Beta 2*/
	public class DragExcel
	{
		private var _dataGrid:DataGrid;
		private var dateFormatter:DateFormatter;
		private var dragIcon:BitmapData;
		
		public function DragExcel()
		{
			var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
				function ():void
				{
					dragIcon = Bitmap(loader.content).bitmapData;
				}
			);
			loader.load(new URLRequest("assets/icon_excel.png"));
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYY-MM-DD-HH-NN-SS";
		} 
		
		public function set dataGrid(dataGrid:DataGrid):void
		{
			_dataGrid = dataGrid;
			_dataGrid.addEventListener(MouseEvent.MOUSE_MOVE, startDragging);
		}
		
		private function startDragging(event:MouseEvent):void
		{
			if (!event.buttonDown) 
			{
				return;
			}

			var options:NativeDragOptions = new NativeDragOptions();
			options.allowCopy = true;
			options.allowLink = true;
			options.allowMove = false;

			var data:Clipboard = new Clipboard();
			data.setData(ClipboardFormats.TEXT_FORMAT, dgToHTML());
			data.setData(ClipboardFormats.FILE_LIST_FORMAT, [createXLS()]);
			NativeDragManager.doDrag(_dataGrid, data, dragIcon, null, options);
		}
		
		private function createXLS():File
		{
			var file:File = File.createTempDirectory().resolvePath("data-"+dateFormatter.format(new Date())+".xls");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(dgToHTML());
			fileStream.close();
			return file;
		}

		private function dgToHTML():String
		{
			var rows:Array = _dataGrid.selectedItems;
			if (!rows || rows.length == 0)
			{
				return "";
			}
			var html:String = "<table>";
			html += "<tr>";
			for (var i:int = 0; i<_dataGrid.columnCount; i++)
			{
				html += "<th>" + DataGridColumn(_dataGrid.columns[i]).headerText + "</th>";							
			}
			html += "</tr>";
			for (var j:int = 0; j<rows.length; j++)
			{
				var row:Object = rows[j];
				html += "<tr>";
				for (var k:int = 0; k<_dataGrid.columnCount; k++)
				{
					html += "<td>" + row[DataGridColumn(_dataGrid.columns[k]).dataField] + "</td>";							
				}
				html += "</tr>";
			}
			html += "</table>";
			return html;
		}
			
	}
}