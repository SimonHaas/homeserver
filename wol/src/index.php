<?php

$param = substr($_GET['MAC'], 0, 17);
$found = preg_match('/^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/', $param, $matches);

if (!$found) {
        echo "no MAC address supplied";
        die();
}

$command = "wakeonlan " . $matches[0];
echo $command . "<br>";
echo shell_exec($command);