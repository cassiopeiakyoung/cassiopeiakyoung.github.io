## Senior Portrait Request Form

I know how much my friends *loved* filling out their college application forms, so I've decided to emulate the experience. If you want a senior portrait, please fill out the following form!

\* required field
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
Name: <input type="text" id="name" name="name"/>*
E-mail: <input type="text" id="name" name="email"/>*
Address: <input type="text" id="name" name="address"/>*
<input type="submit">
</form>

<?php
// define variables and set to empty values
$name = $email = $gender = $comment = $website = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["name"]);
  $email = test_input($_POST["email"]);
  $website = test_input($_POST["website"]);
  $comment = test_input($_POST["comment"]);
  $gender = test_input($_POST["gender"]);
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>