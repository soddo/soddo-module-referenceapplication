<%
    ui.includeFragment("appui", "standardEmrIncludes")
    ui.includeCss("referenceapplication", "login.css")
%>

<!DOCTYPE html>
<html>
<head>
    <title>${ ui.message("referenceapplication.login.title") }</title>
    <link rel="shortcut icon" type="image/ico" href="/${ ui.contextPath() }images/openMrsLogo.png"/>
    <link rel="icon" type="image/png\" href="/${ ui.contextPath() }/images/openMrsLogo.png"/>
    ${ ui.resourceLinks() }
</head>
<body>
<script type="text/javascript">
    var OPENMRS_CONTEXT_PATH = '${ ui.contextPath() }';
</script>


${ ui.includeFragment("referenceapplication", "infoAndErrorMessages") }

<script type="text/javascript">
	jQuery(document).ready(function(){
		jQuery('#username').focus();
	});

    updateSelectedOption = function() {
        jQuery('#sessionLocation li').removeClass('selected');
        jQuery('#sessionLocation li[value|=' + jQuery('#sessionLocationInput').val() + ']').addClass('selected');

        var sessionLocationVal = jQuery('#sessionLocationInput').val();
        if(parseInt(sessionLocationVal, 10) > 0){
            jQuery('#login-button').removeClass('disabled');
            jQuery('#login-button').removeAttr('disabled');
        }else{
            jQuery('#login-button').addClass('disabled');
            jQuery('#login-button').attr('disabled','disabled');
        }
    };

    jQuery(function() {
        updateSelectedOption();

        jQuery('#sessionLocation li').click( function() {
            jQuery('#sessionLocationInput').val(jQuery(this).attr("value"));
            updateSelectedOption();
        });

        var cannotLoginController = emr.setupConfirmationDialog({
            selector: '#cannot-login-popup',
            actions: {
                confirm: function() {
                    cannotLoginController.close();
                }
            }
        });
        jQuery('a#cant-login').click(function() {
            cannotLoginController.show();
        })
    });
</script>

<header>
    <div class="logo">
        <a href="${ui.pageLink("referenceapplication", "home")}">
            <img src="${ui.resourceLink("referenceapplication", "images/openMrsLogo.png")}"/>
        </a>
    </div>
</header>

<div id="body-wrapper">
    <div id="content">
    
        <form id="login-form" method="post" autocomplete="off">
            <fieldset>

                <legend>
                    <i class="icon-lock small"></i>
                    ${ ui.message("referenceapplication.login.loginHeading") }
                </legend>

                <p class="left">
                    <label for="username">
                        ${ ui.message("referenceapplication.login.username") }:
                    </label>
                    <input id="username" type="text" name="username" placeholder="${ ui.message("referenceapplication.login.username.placeholder") }"/>
                </p>

                <p class="left">
                    <label for="password">
                        ${ ui.message("referenceapplication.login.password") }:
                    </label>
                    <input id="password" type="password" name="password" placeholder="${ ui.message("referenceapplication.login.password.placeholder") }"/>
                </p>

                <p class="clear">
                    <label for="sessionLocation">
                        ${ ui.message("referenceapplication.login.sessionLocation") }:
                    </label>
                    <ul id="sessionLocation" class="select">
                        <% locations.sort { ui.format(it) }.each { %>
                        <li id="${it.name}" value="${it.id}">${ui.format(it)}</li>
                        <% } %>
                    </ul>
                </p>

                <input type="hidden" id="sessionLocationInput" name="sessionLocation"
                    <% if (lastSessionLocation != null) { %> value="${lastSessionLocation.id}" <% } %> />

                <p></p>
                <p>
                    <input id="login-button" class="confirm" type="submit" value="${ ui.message("referenceapplication.login.button") }"/>
                </p>
                <p>
                    <a id="cant-login" href="javascript:void(0)">
                        <i class="icon-question-sign small"></i>
                        ${ ui.message("referenceapplication.login.cannotLogin") }
                    </a>
                </p>

            </fieldset>

    		<input type="hidden" name="redirectUrl" value="${redirectUrl}" />

        </form>

    </div>
</div>

<div id="cannot-login-popup" class="dialog" style="display: none">
    <div class="dialog-header">
        <i class="icon-info-sign"></i>
        <h3>${ ui.message("referenceapplication.login.cannotLogin") }</h3>
    </div>
    <div class="dialog-content">
        <p class="dialog-instructions">${ ui.message("referenceapplication.login.cannotLoginInstructions") }</p>

        <button class="confirm">${ ui.message("referenceapplication.okay") }</button>
    </div>
</div>

</body>
</html>