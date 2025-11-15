package org.tuxpaint.stamps.downloader;

import android.app.DownloadManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;

import androidx.core.content.ContextCompat;
import androidx.appcompat.app.AppCompatActivity;

import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.Properties;

public class DownloadStampsActivity extends AppCompatActivity {
    private static final String TAG = DownloadStampsActivity.class.getSimpleName();
    String download_dirname = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS) + "/";
    ArrayList<Long> DownloadIDList = new ArrayList<>();
    Dictionary DownloadIDDict = new Hashtable();
    Resources res;
    String[] categories;
    String current_version;
    public int SIZE;
    private Properties props = null;
    private boolean keepzip = false;
    ToggleButton keepzipToggle = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.v(TAG, "onCreate()");
        super.onCreate(savedInstanceState);
        if (android.os.Build.VERSION.SDK_INT > 22) {
            if (this.checkSelfPermission(android.Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
                this.requestPermissions(new String[]{
                        android.Manifest.permission.WRITE_EXTERNAL_STORAGE},2);
            }
        }
        setContentView(R.layout.downloadstamps);
        registerReceiver(onComplete, new IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE));

        res = getResources();
        categories = res.getStringArray(R.array.categories);
        props = new Properties();
        current_version = "20200529";
        File external = getExternalFilesDir(null);
        File cfg = new File(external, "tuxpaint-stamps-downloader.cfg");
        try {
            InputStream in = new FileInputStream(cfg);
            props.load(in);
            in.close();
        } catch (FileNotFoundException el) {                /* do nothing, the file doesn't exists in the very first run. */
        } catch (Exception e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }

        count_children((CheckBox) findViewById(R.id.checkBox_stamps));
        set_view_size();

        keepzipToggle = (ToggleButton) this.findViewById(R.id.toggleButton_keepzip);
        keepzipToggle.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    keepzip = false;
                } else {
                    keepzip = true;
                }
            }
        }
        );
    }

    @Override
    protected void onDestroy() {
        Log.v(TAG, "onDestroy()");
        super.onDestroy();
    }

    public void set_visible(String str, Boolean visible) {
        int id;
        for (String category : categories) {
            id = res.getIdentifier("checkBox_" + str + "_" + category, "id", getPackageName());

            if (id > 0) {
                View vw = findViewById(id);
                CheckBox cbxx = (CheckBox) vw;
                if (visible) {
                    cbxx.setVisibility(View.VISIBLE);
                } else {
                    cbxx.setVisibility(View.GONE);
                }
            }
        }
    }

    /* Expand/collapse the node */

    public void button_clicked(View v) {
        Button btn = (Button) v;
        String str = new String(btn.getTag().toString());

        if (btn.getBackground().getConstantState().equals(ContextCompat.getDrawable(this, R.drawable.down).getConstantState()))
            /* Expand */ {
            btn.setBackground(ContextCompat.getDrawable(this, R.drawable.up));
            set_visible(str.replace("Button_", ""), true);
        } else
            /* Collapse */ {
            btn.setBackground(ContextCompat.getDrawable(this, R.drawable.down));
            set_visible(str.replace("Button_", ""), false);
        }
    }

    public void count_children(CheckBox cbx) {
        int id;
        String child;
        String str = new String(cbx.getTag().toString());

        for (String category : categories) {
            child = str + "_" + category;
            id = res.getIdentifier(child, "id", getPackageName());

            if (id > 0) {
                View vw = findViewById(id);
                CheckBox cbxx = (CheckBox) vw;
                String str_child = new String(cbxx.getTag().toString());
                String string_size_child0 = str_child.replaceAll(".* size ", "");
                String string_size_child = string_size_child0.replaceAll(" /size .*", "");
                int size_child = Integer.parseInt(string_size_child);

                if (cbx.isChecked()) {
                    if (!cbxx.isChecked())
                        SIZE = SIZE + size_child;
                    cbxx.setEnabled(false);

                } else {
                    if (!cbxx.isChecked())
                        SIZE = SIZE - size_child;
                    cbxx.setEnabled(true);
                }
            }
        }
    }

    public Boolean has_childs_checked(CheckBox cbx) {
        int id;
        View vw;
        CheckBox cbxx;

        String str = new String(cbx.getTag().toString());

        for (String category : categories) {
            id =
                    res.getIdentifier(str + "_" + category, "id", getPackageName());
            if (id > 0) {
                vw = findViewById(id);
                cbxx = (CheckBox) vw;
                if (cbxx.isChecked())
                    return true;
            }
        }
        return false;
    }

    public void check_parent(CheckBox cbx) {
        String str = new String(cbx.getTag().toString());
        String str_base = new String(str.replaceAll(" /parent.*", ""));
        str_base = str_base.replaceAll(".* parent ", "");

        for (String category : categories) {
            str_base = str_base.replace("_" + category, "");
        }

        int id = res.getIdentifier(str_base, "id", getPackageName());
        View vw = findViewById(id);
        CheckBox cbxx = (CheckBox) vw;
        if (has_childs_checked(cbxx)) {
            cbxx.setBackgroundColor(0X88888888);
        } else {
            cbxx.setBackgroundResource(0);
        }
    }

    public void checkbox_clicked(View v) {
        CheckBox cbx = (CheckBox) v;

        String str = new String(cbx.getTag().toString());
        String string_size0 = str.replaceAll(".* size ", "");
        String string_size1 = string_size0.replaceAll(" /size .*", "");
        String string_size = string_size1.replaceAll("[^0-9]", "");
        if (string_size.equals(""))
            count_children(cbx);
        else {
            int size = Integer.parseInt(string_size);
            if (cbx.isChecked())
                SIZE = SIZE + size;
            else
                SIZE = SIZE - size;
            check_parent(cbx);
        }

        String string_tag = new String(cbx.getTag().toString());
        Log.v(TAG, "string_tag " + string_tag);
        set_view_size();
    }

    public void set_view_size() {
        TextView textView_size = (TextView) findViewById(R.id.textView_size);

        if (SIZE > 1048576)
            textView_size.setText(getString(R.string.download_size) + " " + SIZE / 1048576 + " " + getString(R.string.mb));
        else if (SIZE > 1024)
            textView_size.setText(getString(R.string.download_size) + " " + SIZE / 1024 + " " + getString(R.string.kb));
        else
            textView_size.setText(getString(R.string.download_size) + " " + SIZE + " " + getString(R.string.bytes));
    }

    public boolean parent_isChecked(CheckBox cbx) {
        String str_parent = cbx.getTag().toString();
        str_parent = str_parent.replaceAll(" /parent.*", "");
        str_parent = str_parent.replaceAll(".* parent ", "");
        int id = res.getIdentifier(str_parent, "id", getPackageName());
        View v = findViewById(id);
        CheckBox cb = (CheckBox) v;
        return (cb.isChecked());
    }

    /* Check if the file contents are alredy on the destination dir */
    public boolean uncompressed(String zipfilename) {
        String filelist_name = zipfilename.replace(".zip", "");
        filelist_name = filelist_name.replaceAll("-", "_");
        filelist_name = filelist_name.replaceAll("_[0-9].*", "");

        int filelist_name_id =
                res.getIdentifier("org.tuxpaint.stamps.downloader:array/" +
                        filelist_name, "id", getPackageName());
        String[] listarray = res.getStringArray(filelist_name_id);

        EditText DestDir = (EditText) findViewById(R.id.destdir);
        String internal = DestDir.getText().toString();

        for (String fileitem : listarray) {
            String tokens[] = fileitem.split(" ");
            String fsize = tokens[0];
            String fname = tokens[1];


            File f = new File(internal + fname);
            Log.v(TAG, "F " + f + " Size " + fsize);
            if (!f.exists())
                return (false);
            Log.v(TAG, "F " + f + " Size " + fsize + " lenght " + f.length());
            if (!tokens[0].equals(Long.toString(f.length())))
                return (false);
        }

        /* Arrived here, that means all the filenames on the package are in place and have the same size. */
        Log.i(TAG, "Not downloading " + filelist_name + ", already has its files uncompressed in place.");
        return true;
    }

    /* Checks for the existence of the file to be uncompressed. */
    private boolean downloaded(String zipfilename) {
        String filename = download_dirname + zipfilename;
        File file = new File(filename);
        return file.exists();
    }

    /* Checks if the filename has ever been installed and if it matches the current version. */
    public boolean installed_version_matches(String zipfilename) {
        String stored_version = props.getProperty(zipfilename);
        return (current_version.equals(stored_version));
    }

    public void uncompress(String filename) {
        /* Unzip code adapted from the code made by Jianwei Zhang in GSoC 2015 */
        EditText DestDir = (EditText) findViewById(R.id.destdir);
        File internal = new File(DestDir.getText().toString());
        try {
            File zipfile = new File(filename);
            InputStream in = new FileInputStream(zipfile);
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
                    dir.mkdirs();
                    continue;
                }

                File file = new File(internal, name);
                file.createNewFile();
                FileOutputStream fout = new FileOutputStream(file);

                while ((count = zin.read(buffer)) != -1) {
                    fout.write(buffer, 0, count);
                }
                fout.flush();
                fout.close();
                zin.closeEntry();
            }

            zin.close();

	    /* Got strange crashes with this, need  a different way to notify users about what is happening */
	    // Toast toast = Toast.makeText(getApplicationContext(), filename + ": Files in place.", Toast.LENGTH_SHORT);
            // toast.show();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void download(View v) {
        int id;
        View vw;
        CheckBox cbx;
        String zipfilename;
        int id_list = res.getIdentifier("Button_list", "id", getPackageName());
        View vv = findViewById(id_list);
        Button button_list = (Button) vv;
        String str_base = button_list.getTag().toString();
        String str_tokens[] = str_base.split("\\s");
        int id_server = res.getIdentifier("texturl", "id", getPackageName());
        View vserver = findViewById(id_server);
        EditText edtext = (EditText) vserver;
        String server = edtext.getText().toString();
        ArrayList<String> Downloads = new ArrayList<String>();
        ArrayList<String> notDownloads = new ArrayList<String>();

        for (String strcbx : str_tokens) {
            id = res.getIdentifier(strcbx, "id", getPackageName());
            vw = findViewById(id);
            cbx = (CheckBox) vw;

            if (cbx.isChecked() || parent_isChecked(cbx)) {
                zipfilename = cbx.getTag().toString();
                zipfilename = zipfilename.replaceAll(".* zipfile ", "");
                zipfilename = zipfilename.replaceAll(" /zipfile.*", "");

                Log.v(TAG,
                        "server " + server + "     zipfilename " + zipfilename);

                if (installed_version_matches(zipfilename) && uncompressed(zipfilename)) {
                    /* Files are already in place and are from the target version. */
                    notDownloads.add(zipfilename);
                    continue;
                }
                if (!downloaded(zipfilename)) {
		/* Ask Android to download it for us. 
		   The callback that will be called on download complete will call to uncompress the file */

                    String url = server + zipfilename;

                    DownloadManager.Request request = new DownloadManager.Request(Uri.parse(url));
                    request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, zipfilename);

                    // get download service and enqueue file
                    DownloadManager manager = (DownloadManager) getSystemService(Context.DOWNLOAD_SERVICE);
                    Long download_id = manager.enqueue(request);
                    Log.v(TAG, "download_id " + download_id + " url " + url);
                    DownloadIDDict.put(download_id, zipfilename);
                    Downloads.add(zipfilename);
                } else
                    /* Zip files are already in the Download directory! */
                    uncompress(zipfilename);
            }
        }

        /* Feedback to the user */
        String toaststring = null;
        if (!Downloads.isEmpty())
            toaststring = getString(R.string.downloading_list) + Downloads.toString() + "\n\n";

        if (!notDownloads.isEmpty())
            if (!Downloads.isEmpty())
                toaststring =
                        toaststring + getString(R.string.not_downloading_list) + notDownloads.toString();
            else
                toaststring = "Not downloading: " + notDownloads.toString();

	/* Got strange crashes with this, need  a different way to notify users about what is happening */
        // Toast toast2 = Toast.makeText(getApplicationContext(), toaststring, Toast.LENGTH_SHORT);
	// toast2.show();
    }

    public void record_version(String filename) {
        File external = getExternalFilesDir(null);
        File cfg = new File(external, "tuxpaint-stamps-downloader.cfg");
        props.put(filename, current_version);
        try {
            OutputStream out = new FileOutputStream(cfg);
            props.store(out, "");
            out.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /* Callback that is called on each download finished */
    BroadcastReceiver onComplete = new BroadcastReceiver() {

        public void onReceive(Context ctxt, Intent intent) {

            // get the refid from the download manager
            long download_id = intent.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, -1);

            /* Not our download? */
            if (DownloadIDDict.get(download_id) == null) return;

            Log.v(TAG, "download_id " + download_id + "zipfilename " + DownloadIDDict.get(download_id) + " done.");
            String zipfilename = DownloadIDDict.get(download_id).toString();
            String filename = download_dirname + zipfilename;
            uncompress(filename);

            /* Save the filename and version of the uncompressed file for future reference. */
            record_version(zipfilename);

            // Already processed,remove the id from our dict
            DownloadIDDict.remove(download_id);

            /* Remove the downloaded zip file to save space unless asked to not do so. */
            if (!keepzip) {
                File filetoremove = new File(filename);
                filetoremove.delete();
            }
        }
    };
}
