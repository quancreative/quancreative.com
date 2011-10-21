package com.quancreative.pages.contact.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Quint;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.utils.setTimeout;

	public class ContactForm extends MovieClip
	{
		private static const normalFillColor:uint = 0xFFFFFF; // white
		private static const focusFillColor:uint = 0xD2F1FC; // lite Blue 
		private static const errorFillColor:uint = 0xFFE9D7;		
		
		private var emailValidate	: Boolean;
		private var cacheEmail		: String = ""; 
		private var userInputs 		: Array = [];
		private var animationInputs	: Array = [];
		private var animationXpos	: Array = [];
		
		private var formMask	: Sprite;
		private var bkgdTween 	: TweenLite;
		
		private var userName 	: MovieClip;
		private var userEmail 	: MovieClip;
		private var userMsg 	: MovieClip;
		private var submit 		: MovieClip;
		private var respond		: MovieClip;
		
		private var headerTxt : TextField;
		public var bkgdMC		: MovieClip;
		public var bkgd_mc		: MovieClip;
		public var submit_mc		: MovieClip;
		public var userName_mc		: MovieClip;
		public var userMessage_mc		: MovieClip;
		public var userEmail_mc		: MovieClip;
		public var respond_mc		: MovieClip;
		public var header_txt		: TextField;

		// lite orange
		
		public function ContactForm()
		{
			userName = MovieClip(getChildByName("userName_mc"));
			userEmail = MovieClip(getChildByName("userEmail_mc"));
			userMsg = MovieClip(getChildByName("userMessage_mc"));
			respond = MovieClip(getChildByName("respond_mc"));
			
			bkgdMC = MovieClip(getChildByName("bkgd_mc"));
			bkgdMC.alpha = 0;
			
			headerTxt = TextField(getChildByName("header_txt"));
			headerTxt.alpha = 0;
			
			userInputs.push(userName);
			userInputs.push(userEmail);
			userInputs.push(userMsg);
			
			var totalInputs:uint = userInputs.length;
			
			for(var i:uint = 0; i < totalInputs; i++)
			{
				var myHolder : MovieClip = userInputs[i];
				myHolder.alpha = 0;
				
				var myField : TextField = myHolder.inputText;
				myField.addEventListener(FocusEvent.FOCUS_IN, onTextFocusIn);	
				myField.addEventListener(FocusEvent.FOCUS_OUT, onTextFocusOut);	
			}
			
			submit = MovieClip(getChildByName("submit_mc"));
			submit.buttonMode = true;
			submit.alpha = 0;
			submit.addEventListener(MouseEvent.MOUSE_DOWN, onSubmit);
			
			animationXpos.push(userName.x);
			animationXpos.push(userEmail.x);
			animationXpos.push(userMsg.x);
			animationXpos.push(submit.x);
			
			animationInputs.push(userName);
			animationInputs.push(userEmail);
			animationInputs.push(userMsg);
			animationInputs.push(submit);
			
			// Testing scenario.
//			transitionIn();
//			setTimeout(transitionOut, 2000);
//			setTimeout(transitionIn, 3000);
		}
		
		//--------------------------------------
		//  Events
		//--------------------------------------
		private function onTextFocusIn(event:FocusEvent):void{				
			var myInputText:TextField = event.currentTarget as TextField;
			myInputText.textColor = 0x000000;
			
//			tweenColor(event.currentTarget, focusFillColor);
			
			var myHolder:MovieClip = myInputText.parent as MovieClip;
			
			switch (myHolder.name) {				
				case "userName":
				{
					if (myInputText.text == "Please tell me your name.") {
						myInputText.text = "";
					}
					break;
				}
				case "userEmail":
				{
					
					if (myInputText.text == "Please check your email address again."){						
						myInputText.text = cacheEmail;
						
					} else if (myInputText.text == "Please tell me your email."){
						myInputText.text = "";
					}
					break;
				}
				case "userMessage":
				{
					if (myInputText.text == "Please enter your message.") {
						myInputText.text = "";
					}
					break;
				}				
			}			
		}
		
		private function onTextFocusOut(event:FocusEvent):void{			
			tweenColor(event.currentTarget, normalFillColor);
			//var myHolder:MovieClip = event.currentTarget.parent as MovieClip;

		}
		
		private function onSubmit(event:MouseEvent):void{			
			validateForm();			
		}
		
		private function _onKeyDown(event:KeyboardEvent):void{
			//trace('a key was hit');
			if(event.charCode == 13)
			{
				validateForm();
			};
		}
		
		private function handleComplete(event:Event):void{
			var urlLoader:URLLoader = URLLoader(event.target);
			
			// Expect the script to return name and description variables.
	   	 	// Display these values in a text field on the screen.
    	 	//trace( loader.Name + loader.userEmail);			
			//var returnVariables:URLVariables = new URLVariables(urlLoader.data);
			var returnMessage:String = String(urlLoader.data);
			respond.alert.text = returnMessage;
			
			TweenLite.to(respond, 1, {y:0, ease:Quint.easeInOut});
			
			respond.exit.buttonMode = true;
			respond.exit.addEventListener(MouseEvent.MOUSE_DOWN, exitDown);
		}
		
		private function exitDown(event:MouseEvent):void{
			TweenLite.to(respond, 1, {y: -respond.height, ease:Quint.easeInOut});
		}
		
		private function tweenColor(target:*, color:uint):void{			
			var myHolder:MovieClip = target.parent as MovieClip;
			var myFill:MovieClip = myHolder.bkgdFill;		
			
			TweenLite.to(myFill, .25, {tint:color});
		}
				
		private function validateForm():void{
			var valid:Boolean = true;
			
			// name			
			if (userName.inputText.text == ""){
				alertError(userName.inputText , "Please tell me your name.");

				valid = false;
			}			
			
			// email
			if (userEmail.inputText.text == "" || userEmail.inputText.text == "Please tell me your email."){
				alertError(userEmail.inputText , "Please tell me your email.");
				
				valid = false;
				
			} else {
				
				var emailReg:RegExp = /^[a-z0-9][-._a-z0-9]*@([a-z0-9][-_a-z0-9]*\.)+[a-z]{2,6}$/;					
				if(!emailReg.test(userEmail.inputText.text)){
					
					if (userEmail.inputText.text != "Please check your email address again."){
						cacheEmail = userEmail.inputText.text;
					}
										
					alertError(userEmail.inputText , "Please check your email address again.");						
					
					valid = false;					
				}
			}
			
			// message
			if (userMsg.inputText.text == ""){
				alertError(userMsg.inputText , "Please enter your message.");
				
				valid = false;
			}
			
			if(valid == true){
				
				sendEmail();
			}
			// testing
			//TweenLite.to(respond, 1, {y:0, ease:Quint.easeInOut});
		}
		
		private function alertError(targetTnput:*, alertMessage:String):void
		{						
				targetTnput.textColor = 0xCE5050;
				targetTnput.text = alertMessage;
				
				tweenColor(targetTnput, errorFillColor);
		}
		
		private function sendEmail():void{	
			
			// Create a URLRequest to contain the data to send
			// to email.php
			var UrlRequest:URLRequest = new URLRequest( "php/email.php" );
			
			// Create name-value pairs to send to the server
			var variables:URLVariables = new URLVariables();
			variables.userName = userName.inputText.text;
			variables.userEmail = userEmail.inputText.text
			variables.userMessage = userMsg.inputText.text;
			UrlRequest.data = variables;
			
			// Create a URLLoader to send the data and receive a response
			var loader:URLLoader = new URLLoader();
			
			//Expect the script to return URL-encoded variables
			//loader.dataFormat = DataFormat.VARIABLES;
			
			// Listen to the complete event to read the server response
			loader.addEventListener( Event.COMPLETE, handleComplete );
			
			// Send the data in the URLRequest off of the script
			loader.load(UrlRequest);
		}
		
		public function transitionIn() : void
		{
			transitionInPrep();
			bkgdTween.kill();
			
			// Take them outside of the stage to tween them in.
			bkgdMC.x = stage.stageWidth;
			bkgdMC.alpha = 0;
			headerTxt.x = stage.stageWidth/2;
			bkgdTween = new TweenLite(bkgdMC, .75, {x:0, alpha: 1, ease:Quart.easeOut});
			TweenLite.to(headerTxt, .75, {x:0, alpha: 1, ease:Quart.easeOut, delay:.5});
			
			setTimeout(transitionInB, 1000);
		}

		private function transitionInPrep() : void 
		{
			if (formMask) 
			{
				if (formMask.parent) removeChild(formMask);
				
				formMask = null;
			}
		}

		private function transitionInB() : void
		{
			var bkgdHeight: uint = stage.stageHeight;	
			bkgdTween = new TweenLite(bkgdMC, .5, {height:stage.stageHeight, ease:Quint.easeIn, onComplete:transitionInFinsish});
		}
		
		private function transitionInFinsish() : void
		{
			formMask = new Sprite();
			formMask.graphics.beginFill(0xFF0000);
			formMask.graphics.drawRect(0, 0, bkgdMC.width, bkgdMC.height);
			
			addChild(formMask);
			mask = formMask;
			
			// Move the fields into place
			var totalClip:uint = animationInputs.length;
			var delay : Number = 0;
			for (var i:uint = 0; i < totalClip; i++) 
			{
				var myHolder:MovieClip = animationInputs[i];	
				var myHolderXPos : Number = animationXpos[i];
				
				// Move it back 30 pixel
				myHolder.x = -20;			
				TweenLite.to(myHolder, .5, {x: myHolderXPos, alpha : 1, ease:Quart.easeOut, delay:delay, onComplete:tweenFinished, onCompleteParams:[i]});
				delay += .1;
			}
			
			function tweenFinished(index : uint) : void
			{
				// if it reaches the last one, remove the mask
				if (index == totalClip -1)
				{
					removeChild(formMask);					
					mask = null;
					formMask = null;
				}
			}
		}

		public function transitionOut() : void 
		{
			transitionInPrep();
			
			// Move the fields into place
			var totalClip:uint = animationInputs.length;
			var delay : Number = 0;
			for (var i: Number = totalClip - 1; i > -1; i--) 
			{
				var mc : MovieClip = animationInputs[i];
				var xPos : Number = mc.x + 6;
				
				TweenLite.to(mc, .3, {x: xPos, alpha : 0, ease:Quart.easeIn, delay:delay});
				delay += .1;
			}
			
			bkgdTween = new TweenLite(bkgdMC, .5, {height: 1, alpha: 0, delay: .7, ease:Quart.easeOut});
			TweenLite.to(headerTxt, .5, {alpha: 0, delay: .8});
		}
	}
}