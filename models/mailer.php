<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

class mailer{
    public function send($values){
        $mail = new PHPMailer();
        // Settings
        $mail->IsSMTP();
        $mail->CharSet = 'UTF-8';
        $config = config();

        $mail->Host       = $config["mailServer"]; // SMTP server example
        $mail->Port       = 587;                    // set the SMTP port for the GMAIL server
        $mail->SMTPDebug  = 2;                     // enables SMTP debug information (for testing)
        $mail->SMTPAuth   = true;                  // enable SMTP authentication
        $mail->Username   = $config["mailUsername"]; // SMTP account username example
        $mail->Password   = $config["mailUserpass"];        // SMTP account password example
        //$mail->SMTPSecure = 'tls';

        // Content
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->Subject = $values["SupportQuestion"];
        $mail->Body    = $values["SupportDescription"];
        $mail->AltBody = $values["SupportDescription"];
        $mail->From = $config["mailFrom"];
        $mail->setFrom($config["mailFrom"], $config["mailFromTitle"]);
        $mail->addAddress($values["CustomerEmail"]);
        //echo(json_encode($values));
        try{
            $mail->send();
        } catch(Exception $e){
            echo $mail->ErrorInfo;
        }
    }
}
?>