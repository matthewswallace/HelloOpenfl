package;


import openfl.Assets;
import openfl.events.MouseEvent;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.VBox;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.skins.Paint;
import extension.facebook.LoginHelper;
import extension.facebook.AccessToken;


class Main  {
	var mHelper : LoginHelper;
  var mUserId : String;
  var loginButton:Button;
  var errorText:Text;
  var loggedIn:Bool = false;

	public function new() {
    var screenW = Lib.current.stage.stageWidth;
    var screenH = Lib.current.stage.stageHeight;

    UIBuilder.setTheme('ru.stablex.ui.themes.ios');
    UIBuilder.init();

    var vbox:VBox = cast(UIBuilder.create(VBox), VBox);
    vbox.w = screenW;
    vbox.h = screenH;


    loginButton = cast(UIBuilder.create(Button, {
      text : 'Login with Facebook',
      embedFonts:true,
      format: {
        font: Assets.getFont('fonts/OpenSans-Regular.ttf').name
    }
    }), Button);

    loginButton.addEventListener(MouseEvent.CLICK, onLoginClicked);


    vbox.addChild(loginButton);



    Lib.current.addChild(vbox);

    //fbook stuff
    mHelper = new LoginHelper(onLoggedIn, onLoggedOut, onLogginError, onLoginCancel);
    mHelper.init(); // this check if the user was loggedIn before, and trigger onLoggedIn if it was the case.

  }

	public static function main() {
		 new Main();
	}

	function onLoginClicked(e : MouseEvent) {
    if (loggedIn) {
      mHelper.logOut();
    } else {
      mHelper.logIn();
    }
  }


  function onLoggedIn(){
    mUserId = AccessToken.getCurrent().getUserId();
    trace("Your user id is : " + mUserId);
    loginButton.text = 'Logout';
    loggedIn = true;
  }

	function onLoggedOut() {
    loginButton.text = 'Login with Facebook';
		loggedIn = false;
  }

  function onLogginError(e : String) {
    trace("error : "  + e);
  }

  function onLoginCancel() {
    trace("You have to log in to use my awesome app.");
  }

}
