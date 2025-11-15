package org.tuxpaint.stamps;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import androidx.appcompat.app.AppCompatActivity;


public class License extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_license);
        TextView tvlicense = findViewById(R.id.textViewLicense);

	     try {
	    	 InputStream in = getAssets().open("COPYING.txt");
             ByteArrayOutputStream baos = new ByteArrayOutputStream();

	         int i;
	         i = in.read();
while(i != -1) {
baos.write(i);
	         i = in.read();

}
tvlicense.setText(baos.toString());
	     }
	     catch(IOException e) {
	         e.printStackTrace();
	     }

	 	Button understoodButton = (Button)this.findViewById(R.id.Understood);

	understoodButton.setOnClickListener(new View.OnClickListener() {
		public void onClick(View buttonView) {
		    finish();
		}
	    });


    }
    }


