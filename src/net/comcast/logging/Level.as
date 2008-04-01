package net.comcast.logging{
	public final class Level{
		public static const FATAL:Number = 1000;
		public static const ERROR:Number = 8;
		public static const WARN:Number = 6;
		public static const INFO:Number = 4;
		public static const DEBUG:Number = 2;
		public static const ALL:Number = 0;
		
		public static const UNKNOWN_LEVEL:String = "UNKNOWN_LEVEL";
		
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