<?php
    $db_host = getenv("MYSQL_HOST");
    $db_name = getenv("MYSQL_DATABASE");
    $db_user = getenv("MYSQL_USER");
    $db_pass = getenv("MYSQL_PASSWORD");

    try {
        $db = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);

        $hit_sql  = "CREATE TABLE IF NOT EXISTS hits(";
        $hit_sql .= "id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,";
        $hit_sql .= "hit_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,";
        $hit_sql .= "hit_ip VARCHAR(15) NOT NULL";
        $hit_sql .= ") AUTO_INCREMENT = 1;";
        $db->query($hit_sql);

        $ins = "INSERT INTO hits (hit_ip) VALUES('" . $_SERVER['REMOTE_ADDR'] . "');";
        $db->query($ins);

        $query = "SELECT hit_dt, hit_ip FROM hits ORDER BY hit_dt DESC LIMIT 2;";

        $st = $db->prepare($query);
        $st->execute();

        $hits = [];
        while($row = $st->fetch(PDO::FETCH_ASSOC)) {
            $hit['dt'] = $row['hit_dt'];
            $hit['ip'] = $row['hit_ip'];
            $hits[] = $hit;
        }

    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }

    $db = null;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevOps Excercise</title>
</head>
<body>
    <p>
<?php
    if ($hits[0]) { print("<p>Last visit on <b>" . $hits[0]['dt'] . "</b> from <b>" . $hits[0]['ip'] . "</b>.</p>"); }
    if ($hits[1]) { print("<p>Previous visit on <b>" . $hits[1]['dt'] . "</b> from <b>" . $hits[1]['ip'] . "</b>.</p>"); }
?>
</body>
</html>