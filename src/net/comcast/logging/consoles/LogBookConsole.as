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
package net.comcast.logging.consoles
{

import flash.events.*;
import flash.net.LocalConnection;
import flash.utils.getQualifiedClassName;


/**
 * Provides a logger target that outputs to a <code>LocalConnection</code>,
 * connected to a logging application. 
 * 
 * @author Arpit Mathur
 */
public class LogBookConsole implements IConsole{

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
     *  Constructor.
	 *
	 *  <p>Constructs an instance of a logger target that will send
	 *  the log data to the Debug application.</p>
	 *
     *  @param	connectionId		defines the Debug application connection string
     */
    public function LogBookConsole(connectionId:String) 
    {
		super();
		lc = new LocalConnection();
        lc.addEventListener(StatusEvent.STATUS, statusEventHandler);
        this.connection = connectionId;
    }
    
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

    /**
     *  @private
     */
    private var lc:LocalConnection;
    
    /**
     *  The name of the method to call on the Debug application connection.
     */
    public static const LOGGING_METHOD:String = "logMessage";
    
    public static const REMOTE_MESSAGE_HANDLER:String = "handleMessage";
	
    /**
     *  @private
     *  The name of the connection string to the Debug application.
     */
    private var connection:String;    

	//--------------------------------------------------------------------------
	//
	//  EventListener
	//
	//--------------------------------------------------------------------------


	/**
	 * 	Supress common LocalConnection status message from bubbling up
	 * 	as errors
	 */
    private function statusEventHandler(event:StatusEvent):void 
    {
        //trace("statusEventHandler: " + event.code);
    }


	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------

    public function log(source:*, level:Number, msg:String):void{
		
    	var d:Date = new Date();

 		var category:String = getQualifiedClassName(source)
    	try {
    		lc.send(connection, LOGGING_METHOD, d, category, level, msg);
	    } catch(error:Error) {
	    	trace('[LocalConection Error] cound not send message across LocalConnection ');
	    }
    }
    
    public function message(msg:String, ...args):void{
    	trace("==> " + args.length)
    	try {
    		if(args.length == 0){
    			lc.send(connection, msg);
    		}
    		else{
    			lc.send(connection, msg , args);
    		}
    		
	    } catch(error:Error) {
	    	trace('[LocalConection Error] cound not send message across LocalConnection ');
	    }
    }

    /**
	 *  @private
	 */
	private function pad(num:Number):String
    {
        return num > 9 ? num.toString() : "0" + num.toString();
    }    
    
    public function toString():String
    {
    	return "LocalConnectionTarget[" + this.connection + "]";
    }
    
    public function getConnectionId():String {
    	return connection;
    }
	
	//---------------------------------------------    
	
	// API
	    
	//---------------------------------------------    
    
    public function clear():void{
    	message("clearLogs");
    }
}
}