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
	import flash.net.SharedObject;
	
	import mx.core.WindowedApplication;
	public class SavedWindowLocation 
	{
		private var _application:WindowedApplication;
		private var _appSO:SharedObject;
		public function SavedWindowLocation(app:WindowedApplication){
			_application = app;
		}
		public function setSavedWindowPosition():void{
			
			_appSO = SharedObject.getLocal("preferences");
			if(_appSO.data.x!=undefined) _application.nativeWindow.x = _appSO.data.x;
			if(_appSO.data.y!=undefined) _application.nativeWindow.y = _appSO.data.y;
			if(_appSO.data.w!=undefined){
				_application.nativeWindow.width = _appSO.data.w;
			}else{
				_application.nativeWindow.width = 900;
			}
			if(_appSO.data.h!=undefined){
				_application.nativeWindow.height = _appSO.data.h;
			}else{
				_application.nativeWindow.height = 450;
			}
		}
		public function saveWindowLocation():void{
			_appSO = SharedObject.getLocal("preferences");
			_appSO.data.x = _application.nativeWindow.x;
			_appSO.data.y = _application.nativeWindow.y;
			_appSO.data.w = _application.nativeWindow.width;
			_appSO.data.h = _application.nativeWindow.height;
			_appSO.flush();
		}
	}
}