<?php
$to        = $_GET['to'] ?? 'doug.bierer@etista.com';
$to        = filter_var($to, FILTER_SANITIZE_EMAIL);
$subject   = 'TEST FROM DOUGBIERERETISTACOM3 ' . date('Y-m-d H:i:s');
$body      = var_export($_SERVER, TRUE);
$headers   = [
	'From' => 'services@linuxforphp.com',
	'CC'   => 'doug@unlikelysource.com',
	'X-Mailer' => 'PHP/' . phpversion(),
];
mail($to, $subject, $body, $headers);
echo '<pre>';
var_dump($to, $subject, $body, $headers);
echo '</pre>';
