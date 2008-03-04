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
package cim.fx.logging.targets
{

import flash.events.*;
import flash.net.LocalConnection;

import mx.logging.*;
import mx.logging.targets.*;

/**
 * Provides a logger target that outputs to a <code>LocalConnection</code>,
 * connected to a logging application.  To be used with the Flex logging framework.
 * 
 * @author www.renaun.com, edited by Kevin Fitzpatrick
 */
public class LocalConnectionTarget extends LineFormattedTarget 
{

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
    public function LocalConnectionTarget(connectionId:String) 
    {
		super();
		lc = new LocalConnection();
        lc.addEventListener(StatusEvent.STATUS, statusEventHandler);
        this.connection = connectionId;
        this.filters=["*"];
		this.level = LogEventLevel.ALL;
		this.includeDate = true;
		this.includeTime = true;
		this.includeCategory = true;
		this.includeLevel = true;
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

    override public function logEvent(event:LogEvent):void
    {
		var level:int = event.level;    	

    	var d:Date = (includeDate || includeTime) ? new Date() : null;

 		var category:String = includeCategory ?
							  ILogger(event.target).category :
							  "";
    	try {
    		lc.send(connection, LOGGING_METHOD, d, category, level, event.message);
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
    	return "LocalConnectionTarget[" + this.id + "]";
    }
    
    public function getConnectionId():String {
    	return connection;
    }
}
}