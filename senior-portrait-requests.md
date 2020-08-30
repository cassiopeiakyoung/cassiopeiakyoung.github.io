## Senior Portrait Request Form

<script language="JavaScript" src="/gen_validatorv31.js" type="text/javascript"></script>

I know how much my friends *loved* filling out their college application forms, so I've decided to emulate the experience. If you want a senior portrait, please fill out the following application!

\* required field
<form method="post" name="myemailform" action="nicolaskyoung.github.io/acceptportraits.php">
Name: <input type="text" id="name" name="name"/>* <br>
E-mail: <input type="email" id="name" name="email"/>* <br>
Address: <input type="text" id="name" name="address"/>* <br>
<input type="submit" value="Submit Application">
</form>

<script language="JavaScript">
// Code for validating the form
// Visit http://www.javascript-coder.com/html-form/javascript-form-validation.phtml
// for details
var frmvalidator  = new Validator("myemailform");
frmvalidator.addValidation("name","req","Please provide your name"); 
frmvalidator.addValidation("email","req","Please provide your email"); 
frmvalidator.addValidation("email","email","Please enter a valid email address"); 
</script>