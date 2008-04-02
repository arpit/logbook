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

package net.comcast.logging{
	public final class Level{
		public static const FATAL:Number = 1000;
		public static const ERROR:Number = 8;
		public static const WARN:Number = 6;
		public static const INFO:Number = 4;
		public static const DEBUG:Number = 2;
		public static const ALL:Number = 0;
		
		public static const UNKNOWN_LEVEL:String = "UNKNOWN_LEVEL";
		
		/**
		 * @param	level	A Number representing a Log level. The Number must
		 * 					be one of values as the Levels declared here as static
		 * 					constants, else "UNKNOWN_LEVEL" is returned.
		 * @return	The string corresponding to a Log level
		 */ 
		public static function getLevelString(level:Number):String{
			switch(level){
				case FATAL : 	return "SEVERE";
							 	break;
				case ERROR   : 	return "ERROR";
								break;
				case WARN :		return "WARN";
							   	break;
				case INFO	:	return "INFO";
								break;
				case DEBUG	:	return "DEBUG";
								break;
				case ALL	:	return "ALL";
								break;
								
				default		:	return UNKNOWN_LEVEL;
								break;
			}			
		}		
	}
}