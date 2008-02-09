package cim.fx.logging.logBook
{
	import mx.formatters.Formatter;
	import mx.logging.LogEvent;
	public class LogLevelFormatter extends Formatter {
		//TODO: write unit tests for LogLevelFormatter
		public function LogLevelFormatter() {
			super();
		}
		
		override public function format(value:Object):String {
			var stringValue:String;
			stringValue = LogEvent.getLevelString(value as Number);
			return stringValue;			
		}
	}
}