<?php
function dbconnection()
{
    $con = mysqli_connect("localhost", "root", "", "flutter_api");
    return $con;
}
