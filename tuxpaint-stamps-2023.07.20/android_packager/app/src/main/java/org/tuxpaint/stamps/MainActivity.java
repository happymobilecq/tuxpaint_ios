package org.tuxpaint.stamps;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import androidx.appcompat.app.AppCompatActivity;
public class MainActivity extends AppCompatActivity {
TextView Feedback;
Button InstallButton;
ProgressBar progresbar;
Boolean action_not_running;
Button RemoveButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        action_not_running = true;
        /* Request permissions if lacking */
	    if (android.os.Build.VERSION.SDK_INT > 22) {
	        if (this.checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
		    Intent intent = new Intent(this, reqpermsActivity.class);
		    this.startActivity(intent);
	        }
	    }

        /* License button starts the License activity */
        Button LicenseButton = (Button) this.findViewById(R.id.license);
        LicenseButton.setOnClickListener(v -> startActivity(new Intent(MainActivity.this, License.class)));

        /* Install button */
        InstallButton = (Button) this.findViewById(R.id.install);
       	InstallButton.setOnClickListener(buttonView -> doAction("install"));

       	RemoveButton = (Button) this.findViewById(R.id.buttonuninstall);
       	RemoveButton.setOnClickListener(buttonView -> doAction("remove"));

        progresbar = findViewById(R.id.progressBar2);

        Feedback = this.findViewById(R.id.textViewstatus);
        Feedback.setText(getString(R.string.Start_tip));
    }

    public void doAction(String action) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (this.checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
		setFeedback(R.string.Needs_permissions);
		return;
            }
	}

        if(action_not_running) {
            action_not_running=false;

            InstallButton.setClickable(false);
            InstallButton.setEnabled(false);

            RemoveButton.setClickable(false);
            RemoveButton.setEnabled(false);

            if (action.equals("install"))
                setFeedback(R.string.Installing_files);
            else
                setFeedback(R.string.Removing_files);

            /* feedback to let users know we are running */
            progresbar.setIndeterminate(true);

            /* need to return from here as soon as possible to allow UI updates */
            /* the main work will be done in a thread */
            /* looks like killing flys with guns :( */

            new Thread(new Runnable() {
                @Override
                public void run() {
                    uncompress(action);
                    /* Main work done, reset some states */
                    runOnUiThread(
                            new Runnable(){
                                @Override
                                public void run() {
                                    progresbar.setIndeterminate(false);
                                    action_not_running=true;
                                    InstallButton.setClickable(true);
                                    InstallButton.setEnabled(true);
                                    RemoveButton.setClickable(true);
                                    RemoveButton.setEnabled(true);
                                }
                            }
                    );

                }
            }).start();
        }
    }



    public void uncompress(String action) {
        /* Unzip code adapted from the code made by Jianwei Zhang in GSoC 2015 */
        String filename = "stamps.zip";
        ArrayList<String> arraydir = new ArrayList<String>();

        EditText DestDir = (EditText) findViewById(R.id.destdir);
        File internal = new File(DestDir.getText().toString());
        try {
            File zipfile = new File(filename);
            InputStream in = getAssets().open(filename);
            ZipInputStream zin;
            String name;
            zin = new ZipInputStream(new BufferedInputStream(in));
            ZipEntry ze;
            byte[] buffer = new byte[1024];
            int count;



            while ((ze = zin.getNextEntry()) != null) {
                name = ze.getName();

                if (ze.isDirectory()) {
                    File dir = new File(internal, name);
                    if (action.equals("install"))
                        dir.mkdirs();
                    else
                        /* Can't remove the directories right now, storing them */
                        arraydir.add(name);
                    continue;
                }

                File file = new File(internal, name);
                if (action.equals("install")) {
                    file.createNewFile();
                    FileOutputStream fout = new FileOutputStream(file);

                    while ((count = zin.read(buffer)) != -1) {
                        fout.write(buffer, 0, count);
                    }
                    fout.flush();
                    fout.close();
                } else
                {
                    while ((count = zin.read(buffer)) != -1) {
                    }
                file.delete();
            }
                zin.closeEntry();
            }

            zin.close();


            if (action.equals("remove"))
            {
                /* Removing the stored directories in reverse order so the deeper ones gets removed first. */
                for (int i =  arraydir.size() - 1; i >= 0; i--)
                {
                    File file = new File(internal,  arraydir.get(i));
                    file.delete();
                }

            }

                if (action.equals("install"))
                    setFeedback(R.string.Files_installed);
                else {
                    setFeedback(R.string.Files_removed_succesful);
                }
        } catch (IOException e) {
            e.printStackTrace();
            if (action.equals("install"))
                setFeedback(R.string.Files_notinstalled);
            else
                setFeedback(R.string.Files_notremoved);
        }
    }

public void setFeedback(int feedback) {
       runOnUiThread(new Runnable() {
           @Override
           public void run() {
               Feedback.setText(feedback);
           }
       }
       );
    }

}
