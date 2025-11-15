package org.tuxpaint.stamps;
/*
import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

public class reqpermsActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reqperms);
    }
} */

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;


/* reqpermsActivity */
/* Only gets called from the tuxpaintActivity after having checked the lack of permissions
   and the SDK_INT version > 22, so no more barrier checks here */
public class reqpermsActivity extends Activity {
    private static final String TAG = reqpermsActivity.class.getSimpleName();
    Button understoodButton = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
	Log.v(TAG, "onCreate()");
	super.onCreate(savedInstanceState);

		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
			this.requestPermissions(new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 2);
		}
		setContentView(R.layout.reqperms);

	understoodButton = (Button)this.findViewById(R.id.buttonUnderstood);

	understoodButton.setOnClickListener(new View.OnClickListener() {
		public void onClick(View buttonView) {
		    finish();
		}
	    });
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
					   String[] permissions, int[] grantResults) {
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
			if (this.checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED) {
				finish();
			}
		}
	}

    protected void onDestroy() {
        Log.v(TAG, "onDestroy()");
        super.onDestroy();
    }
}
