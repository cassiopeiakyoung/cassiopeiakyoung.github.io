<?php
// define variables and set to empty values
$name = $_POST[filter_var($str, 'name')];
$email = $_POST[filter_var($email, 'email')];
$address = $_POST[filter_var($str, 'address')];

$email_from = $email;
$email_subject = "New Form submission";
$email_body = "You have received a form submission from the user $name. Their email address is $email, and their address is $address\n".

$to = "nicolaskyoung@gmail.com";
$headers = "From: $email_from \r\n";
mail($to,$email_subject,$email_body,$headers);
?>

