#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cgi, cgitb
import time
cgitb.enable()


print '''Content-Type: text/html

<html>
<body>
<h1> Interpretertest </h1>  <br> 
<p> Wenn dieser Text erscheint, funktioniert der Interpreter &uuml;ber 
das CGI des Apache einwandfrei. </p>
</body>
</html>'''


