<%@ page contentType="text/html" %>

<table style="margin: 0 auto; background-color:#FFFFFF; border:0; cellpadding:0; cellspacing:0;" id="emailBody">
    <tr>
        <td align="center" valign="top">
            <table style="background-color:#68A4C4; color:#fff; border:0; cellpadding:0; cellspacing:0; width:100%;">
                <tr>
                    <td align="center" valign="top">
                        <table style="border:0; cellpadding:0; cellspacing:0; width:500;" class="flexibleContainer">
                            <tr>
                                <td align="center" valign="top" width="500" class="flexibleContainerCell">
                                    <table style=" border:0; cellpadding:30; cellspacing:0; width:100%;">
                                        <tr>
                                            <td align="center" valign="top" class="textContent">
                                                <h1 style="/* color: #222; */ text-transform: uppercase; /* font-size: 24px; */ font-weight: 700;
                                                letter-spacing: -1px; margin-top: 30px; padding: 0 0 0 15px;color: #5F5F5F;
                                                line-height:100%;font-family: 'Open Sans', Arial, sans-serif;font-size:35px;/* font-weight:normal; */
                                                margin-bottom:5px;text-align:center; color: white;">LINKSHARING</h1>

                                                <h2 style="text-align:center;font-weight:normal;font-family:Helvetica,Arial,sans-serif;
                                                font-size:23px;margin-bottom:10px;color:#fff;line-height:135%;">Subscribe Topic</h2>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- // MODULE ROW -->
    <!-- MODULE ROW // -->
    <tr>
        <td align="center" valign="top">
            <!-- CENTERING TABLE // -->
            <table style="background-color:#F8F8F8; border:0; cellpadding:0; cellspacing:0; width:100%;">
                <tr>
                    <td align="center" valign="top">
                        <table style="border:0; cellpadding:0; cellspacing:0; width:500;" class="flexibleContainer">
                            <tr>
                                <td align="center" valign="top" width="500" class="flexibleContainerCell">
                                    <table style="border:0; cellpadding:30; cellspacing:0; width:500;">
                                        <tr>
                                            <td align="center" valign="top">
                                                <!-- CONTENT TABLE // -->
                                                <table style="border:0; cellpadding:0; cellspacing:0; width:100%;">
                                                    <tr>
                                                        <td valign="top" class="textContent">
                                                            <div style="text-align:left;font-family:Helvetica,Arial,sans-serif;font-size:14px;margin-bottom:0;color:#5F5F5F;line-height:135%;font-weight: 100;">
                                                                @${senderName} has invited you to subscribe topic ${topicName},
                                                                <br>
                                                                In order to subscribe, please click on the following link
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- // MODULE ROW -->
    <!-- MODULE ROW // -->
    <tr>
        <td align="center" valign="top">
            <table style="border:0; cellpadding:0; cellspacing:0; width:100%;">
                <tr style="padding-top:0;">
                    <td align="center" valign="top">
                        <table style="border:0; cellpadding:30; cellspacing:0; width:500;" class="flexibleContainer">
                            <tr>
                                <td style="padding-top:0;" align="center" valign="top" width="500"
                                    class="flexibleContainerCell">

                                    <!-- CONTENT TABLE // -->
                                    <table style="border:0; cellpadding:0; cellspacing:0; width:50%;"
                                           class="emailButton" style="background-color: #3498DB;">
                                        <tr>
                                            <td align="center" valign="middle" class="buttonContent"
                                                style="background-color:#68A4C4; padding-top:15px;padding-bottom:15px;padding-right:15px;padding-left:15px;">
                                                <a href="${inviteLink}" target="_blank"
                                                   style="color:#FFFFFF;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:20px;line-height:135%;"><span>Subscribe Topic</span>
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- // MODULE ROW -->
    <!-- // MODULE ROW -->
    <tr mc:hideable>
        <td align="center" valign="top">
            <table style="background-color:#F8F8F8;border:0; cellpadding:0; cellspacing:0; width:100%;">
                <tr>
                    <td align="center" valign="top">
                        <table style="border:0; cellpadding:0; cellspacing:0; width:500;" class="flexibleContainer">
                            <tr>
                                <td valign="top" width="500" class="flexibleContainerCell">
                                    <table style="align:left; border:0; cellpadding:0; cellspacing:0; width:100%;">
                                        <tr>
                                            <td align="left" valign="top" class="flexibleContainerBox">
                                            <td align="right" valign="middle" class="flexibleContainerBox">
                                                <table class="flexibleContainerBoxNext"
                                                       style="border:0; cellpadding:0; cellspacing:0; width:100%; max-width: 100%;">
                                                    <tr>
                                                        <td align="left" class="textContent">
                                                            <h3 style="color:#5F5F5F;line-height:125%;font-family:Helvetica,Arial,sans-serif;font-size:20px;font-weight:normal;margin-top:0;margin-bottom:3px;text-align:left;">Best Regards,</h3>

                                                            <div style="text-align:left;padding-bottom:8px;font-family:Helvetica,Arial,sans-serif;font-size:13px;margin-bottom:0;color:#5F5F5F;line-height:135%;">
                                                                Team Linksharing, <br>
                                                                <a style="color:blue;text-decoration: none;"
                                                                   href="http://www.linksharing.com">Linksharing</a>
                                                            </div>

                                                            <div style="text-align:left;padding-top:8px;font-family:Helvetica,Arial,sans-serif;font-size:12px;margin-bottom:0;color:#5F5F5F;line-height:135%;">
                                                                NOTE: This is an auto generated email message. Please do not reply to this mail.
                                                                In case you need any clarification, please contact support@linksharing.com quoting your above-mentioned details.</div>
                                                        </td>
                                                    </tr>
                                                </table>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- // MODULE ROW -->
</table>