<?php 
echo '<p>This is the index file.</p>'
?>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>quan creative - welcome</title>
<meta name="description" content="Hand-crafted pixels and text by Quan Ngo." />
<meta name="keywords" content="quancreative, quan, creative, Quan Ngo, quan, ngo, web standards, CSS, XHTML, markup, style, freelance, web design, web development, goodies" />
<meta name="author" content="Quan Creative" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<style type="text/css">
*{padding: 0; margin: 0; }
body{ background: #50341c;}
</style>

<script src="js/swfobject.js" type="text/javascript"></script>
<script src="js/swfaddress.js" type="text/javascript"></script>
<script type="text/javascript">

function writeToLog(msg){ if (window.console && window.console.log) window.console.log(msg); }
function sendToJavaScript(val, param){ writeToLog(val); }

swfobject.embedSWF("main.swf", "content", "100%", "100%", "9.0.0", "expressInstall.swf", {}, {bgcolor: '#50341c', menu: 'true', allowfullscreen: 'true'}, {id: 'website'});	
</script>
</head>
<body>
	
    <div id="content">
    	<h1>Welcome</h1>

		<p>QuanCreative is an online portfolio of Quan Ngo, a web designer &amp; developer.<br>
		I offer a complete package to all of my clients. I deliver rock solid website creation layered with beautiful design.</p>
        
    	<p>You need to upgrade your Flash Player.<br>
		This site requires a more recent version of the Flash plugin than you currently have. This plugin is free and can be downloaded <a href="http://www.adobe.com/products/flashplayer/" target="_blank">here</a>.<br>
        Or, <a href="light/">enter light version (html)</a> 
        </p>
  
    </div>

<script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
<script type="text/javascript">
_uacct = "UA-1695787-1";
urchinTracker();
</script> 
</body>
</html>
