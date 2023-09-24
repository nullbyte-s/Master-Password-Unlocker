<?php
function gen() {
    $dia = date('j');
	$hora = date('G');
    $fator = pow((($dia + $hora) * 4.21) + 71933.3, 5) + ($hora * 100);
    $senha = $fator % 100000000;
    return intval($senha);
}
$currentpw = sprintf('%8d', gen());
$pw = $_POST['password'];
if ($pw == $currentpw) {
    echo 'gAAAAABlD0tMfV0-0Gap59YFbj6so4t9CIB9J_ToCD9wTe_rooWG1R0whgARP0n6vqlJtExE4aUrJv_0J7kedswHhmMej12c4h_0yN2IxZZp3xBsJy-yw0q2vTTpIorOYcV9NJGEy10n97bFqU62A3-QckjvAIZrM5ju86mAckHNEBxdQ_OL6U8=';
} else {
    http_response_code(204);
}
?>
