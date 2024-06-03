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
    $stmt = $conn->prepare("INSERT INTO cedula (cedula_number, date_issued, place_of_issue, basic_comm_tax, gross_receipts, gross_amounts, salaries_receipts, salaries_amounts, income_property, income_amounts, interest, fname, mname, lname, gender, address, citizenship, civil_status, height, weight, birthdate, place_of_birth, occupation, tin_number) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param(
        "ssssssssssssssssssssssss",
        $cedulas->cedula_number,
        $cedulas->date_issued,
        $cedulas->place_of_issue,
        $cedulas->basic_comm_tax,
        $cedulas->gross_receipts,
        $cedulas->gross_amounts,
        $cedulas->salaries_receipts,
        $cedulas->salaries_amounts,
        $cedulas->income_property,
        $cedulas->income_amounts,
        $cedulas->interest,
        $cedulas->fname,
        $cedulas->mname,
        $cedulas->lname,
        $cedulas->gender,
        $cedulas->address,
        $cedulas->citizenship,
        $cedulas->civil_status,
        $cedulas->height,
        $cedulas->weight,
        $cedulas->birthdate,
        $cedulas->place_of_birth,
        $cedulas->occupation,
        $cedulas->tin_number
    );

    $stmt->execute();
    $stmt->close();
    
    // $result = $conn->prepare("SELECT cedula_number FROM cedula WHERE cedula_number = ?");
    // $result->bind_param("s", $cedulas->cedula_number);
    // if ($result->num_rows() > 0) {
    //     echo json_encode(true);
    // } else {
    //     echo json_encode(false);
    // }
    // $result->close();
}

$conn->close();
