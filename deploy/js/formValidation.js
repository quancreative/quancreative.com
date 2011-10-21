
// Inspired by base2 and Prototype
(function(){
  var initializing = false, fnTest = /xyz/.test(function(){xyz;}) ? /\b_super\b/ : /.*/;

  // The base Class implementation (does nothing)
  this.Class = function(){};

  // Create a new Class that inherits from this class
  Class.extend = function(prop) {
    var _super = this.prototype;

    // Instantiate a base class (but only create the instance,
    // don't run the init constructor)
    initializing = true;
    var prototype = new this();
    initializing = false;

    // Copy the properties over onto the new prototype
    for (var name in prop) {
      // Check if we're overwriting an existing function
      prototype[name] = typeof prop[name] == "function" &&
        typeof _super[name] == "function" && fnTest.test(prop[name]) ?
        (function(name, fn){
          return function() {
            var tmp = this._super;

            // Add a new ._super() method that is the same method
            // but on the super-class
            this._super = _super[name];

            // The method only need to be bound temporarily, so we
            // remove it when we're done executing
            var ret = fn.apply(this, arguments);
            this._super = tmp;

            return ret;
          };
        })(name, prop[name]) :
        prop[name];
    }

    // The dummy class constructor
    function Class() {
      // All construction is actually done in the init method
      if ( !initializing && this.init )
        this.init.apply(this, arguments);
    }

    // Populate our constructed prototype object
    Class.prototype = prototype;

    // Enforce the constructor to be what we expect
    Class.constructor = Class;

    // And make this class extendable
    Class.extend = arguments.callee;

    return Class;
  };
})();

var formValidation = Class.extend({
								  
	init: function(myForm){
				
		this.myForm = $(myForm);
		this.allRequiredFields = $(myForm + ' .required');
		this.labelColor = $(myForm + ' label').css('color');
		this.errorMessage = '';		
		this.allErrorFields = new Array;		
		this.activateSubmit();
	},
	
	activateSubmit: function(){
		var me = this;
		
		this.myForm.submit(function(){
			
			if(me.validateFields()){
				return true;
				
			}else{
				return false;
			}
			
		});
	},
	
	validateFields: function(){
		var me = this;
		var valid = true;
				
		$.each(this.allRequiredFields , function(){
			
			var $thisField = $(this);			
			
			me.resetObj($thisField);
			
			if($thisField.is('#email')){
				
				if(this.value != '' && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value)){					
					valid = false;
					
					var message = 'Your email is invalid.';
					me.displayError($thisField, message);					
				}				
			}
			
			if($thisField.val() ==''){				
				me.allErrorFields.push($thisField.attr('name'));
				
				var message = 'This field is required. Please enter a value.';
				me.displayError($thisField, message);
				
				valid = false;
			}
	   });		
		
		return valid;	
	},
	
	displayError: function(targetObj, message){
		var me = this;
		var $thisObj = targetObj;
		var myHtml = "<p class='errorMessage' style=' color: red; '>" + message + "</p>"
		
		// add the error message
		$thisObj.after(myHtml);
		
		//add style to the li
		$thisObj.parent().css({ 'background':'#ffdfdf', 'marginTop':'6px', 'padding':'4px'});
		
		// change the label font's color to red
		var $myLabel = $thisObj.parent().find('label');
		$myLabel.addClass('error')
		$myLabel.css( {'color':'red', 'fontWeight':'bold'} );
	},
	
	resetObj: function(targetObj){
		
		var me = this;
		var $thisObj = targetObj;
		
		// clear old error if there's any
		$thisObj.parent().find('p.errorMessage').remove();
		
		// reset to original
		var $myLabel = $thisObj.parent().find('label.error');
		$myLabel.removeAttr('style');
		$myLabel.removeAttr('class');		
		
		// remove the style that was previously injected 
		$thisObj.parent().removeAttr('style');
	}
})



