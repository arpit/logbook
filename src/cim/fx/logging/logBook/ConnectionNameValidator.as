package cim.fx.logging.logBook{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class ConnectionNameValidator extends Validator{
		
		public function ConnectionNameValidator(){
			super();
		}
	
		override protected function doValidation(value:Object):Array{
			var errors:Array = [];
			trace('checking .. '+String(value));
			errors = super.doValidation(value)
			if(errors.length > 0) return errors;
			var connectionName:String = String(value);
			if(connectionName.charAt(0) != "_"){
				errors.push(new ValidationResult(true,null,"","LocalConnections for LogBook must begin with underscore ('_')"));
				return errors;
			}
			if(connectionName.length<2){
				errors.push(new ValidationResult(true,null,"","Connection names cannot be just underscore"));
			}
			return errors;
			
		}
		
	}
}