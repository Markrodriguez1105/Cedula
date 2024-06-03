<?php
include 'connectDb.php';
header('Content-Type: application/json');

if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Max-Age: 86400');
}

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
    exit(0);
}

$cedulas = json_decode(file_get_contents("php://input"));
if ($cedulas) {
    if ($cedulas->action == 'getLastId') {
        $result = $conn->query("SELECT RIGHT(cedula_number, 5) FROM `cedula` ORDER BY 1 DESC LIMIT 1;");
        if ($result->num_rows > 0) {
            echo json_encode($result->fetch_row());
        }
        $result->close();
    }

    if($cedulas->action =='count'){
        $result = $conn->query("SELECT COUNT(*) FROM `cedula`;");
        if ($result->num_rows > 0) {
            echo json_encode($result->fetch_column());
        }
        $result->close();
    }
    if($cedulas->action == 'total'){
        $result = $conn->query("SELECT SUM(`gross_receipts` + `salaries_receipts` + `income_property` + `basic_comm_tax` + `interest`) as total FROM `cedula`;");
        if ($result->num_rows > 0) {
            echo json_encode($result->fetch_column());
        }
        $result->close();
    }
}


$conn->close();
