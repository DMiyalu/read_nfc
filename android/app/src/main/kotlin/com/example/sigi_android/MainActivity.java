package com.example.sigi_android;

import android.app.PendingIntent;
import android.content.Intent;
import android.content.IntentFilter;
import android.nfc.FormatException;
import android.nfc.NdefMessage;
import android.nfc.NdefRecord;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.tech.Ndef;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import android.util.Log;
import android.widget.Toast;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
   private String CHANNELREADNFC = "pnda/rna/nfc/read";
   private String CHANNELWRITENFC = "pnda/rna/nfc/write";
   String Error_Detected = "Carte NFC non détectée.";
   String Write_Success = "Ecriture bien effectuee !";
   String write_error = "Error during writing , try again!";
   String device_does_not_support_NFC = "Cet appareil ne supporte NFC";
   NfcAdapter mAdapter;
   PendingIntent mPendingIntent;
   IntentFilter writingTagFilters[];
   boolean writeMode;
   Tag myTag;

   @Override
   public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
      super.configureFlutterEngine(flutterEngine);
     GeneratedPluginRegistrant.registerWith(flutterEngine);

      mAdapter = NfcAdapter.getDefaultAdapter(this);
      if (mAdapter == null) {
         //nfc not support your device.
         Toast.makeText(this, device_does_not_support_NFC, Toast.LENGTH_LONG).show();
         finish();
         return;
      }
      reaFromIntent(getIntent());
      mPendingIntent = PendingIntent.getActivity(this, 0, new Intent(this,
              getClass()).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), 0);
      IntentFilter tagDetected = new IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED);
      writingTagFilters = new IntentFilter[] {tagDetected};
      setIntent(getIntent());
      reaFromIntent(getIntent());
      if (NfcAdapter.ACTION_TAG_DISCOVERED.equals(getIntent().getAction())){
         myTag = getIntent().getParcelableExtra(NfcAdapter.EXTRA_TAG);
      }
      // Read NFC tag ok
      new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNELREADNFC).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
         @Override
         public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
            if (call.method.equals("startBiometricNfc")) {
               if(myTag == null) {
                  result.success("pas de carte !");
               }
               String action = getIntent().getAction();
               if (NfcAdapter.ACTION_TAG_DISCOVERED.equals(action) || NfcAdapter.ACTION_TECH_DISCOVERED.equals(action)
                       ||  NfcAdapter.ACTION_NDEF_DISCOVERED.equals(action)) {
                  Parcelable[] rawMsgs = getIntent().getParcelableArrayExtra(NfcAdapter.EXTRA_NDEF_MESSAGES);
                  NdefMessage[] msgs = null;
                  if (rawMsgs != null){
                     msgs = new NdefMessage[rawMsgs.length];
                     for (int i = 0; i < rawMsgs.length; i++){
                        msgs[i] = (NdefMessage) rawMsgs[i];
                     }
                  }
                  result.success(buidTagViews(msgs));
               }
            }
         }
      });
      // Write NFC tag
      new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNELWRITENFC).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
         @Override
         public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
            if (call.method.equals("writeNfc")) {
               if(myTag == null){
                  result.success("pas de carte !");
               }else {
                  try {
                     write(call, myTag);
                     result.success("200");
                  } catch (IOException e) {
                     e.printStackTrace();
                     result.success("404");
                  } catch (FormatException e) {
                     e.printStackTrace();
                     result.success("500");
                  }
               }
            }
         }
      });
   }

   private void reaFromIntent(Intent intent) {
      String action = intent.getAction();
      if (NfcAdapter.ACTION_TAG_DISCOVERED.equals(action) || NfcAdapter.ACTION_TECH_DISCOVERED.equals(action) ||  NfcAdapter.ACTION_NDEF_DISCOVERED.equals(action)){
         Parcelable[] rawMsgs = intent.getParcelableArrayExtra(NfcAdapter.EXTRA_NDEF_MESSAGES);
         NdefMessage[] msgs = null;
         if (rawMsgs != null){
            msgs = new NdefMessage[rawMsgs.length];
            for (int i = 0; i < rawMsgs.length; i++){
               msgs[i] = (NdefMessage) rawMsgs[i];
            }
         }
         buidTagViews(msgs);
      }
   }

   private String buidTagViews(NdefMessage[] messages) {

      if (messages == null || messages.length == 0) return "404";
      String text = "";
      String tagId = new String(messages[0].getRecords()[0].getType());
      byte[] payload = messages[0].getRecords()[0].getPayload();
      String textEncoding = ((payload[0] & 128) == 0) ? "UTF-8" : "UTF-16"; // Get the text encoding
      int languageCodeLength = payload[0] & 0063; // get the language code , e.g "en"
      // String languageCode = new String(payload, 1, languageCodeLength, "US-ASCII");
      try {
         // get the text
         text = new String(payload, languageCodeLength + 1, payload.length - languageCodeLength - 1, textEncoding);
         return text;
      }catch (UnsupportedEncodingException e){
         Log.e("UnsupportedEncoding", e.toString());
         return "500";
      }
   }

   private void write(MethodCall call, Tag tag) throws IOException, FormatException {
      NdefRecord[] records = {createRecord(call)};
      NdefMessage message = new NdefMessage(records);
      Ndef ndef = Ndef.get(tag);
      // Enable I/O
      ndef.connect();
      // write the massage
      ndef.writeNdefMessage(message);
      ndef.close();
   }

   private NdefRecord createRecord(MethodCall call) throws UnsupportedEncodingException {
      String  text = call.argument("write");
      String lang = "en";
      byte[] textBytes = text.getBytes();
      Log.e("tag____3_", "write nfc success Java......... " +text);
      byte[] langBytes = lang.getBytes("US-ASCII");
      int langLength = langBytes.length;
      int textLength = textBytes.length;
      byte[] payLoad = new byte[1 + langLength + textLength];
      // set status byte (see NDEF spec for actual bits)
      payLoad[0] = (byte) langLength;
      // copy langbytes and textbytes into playload
      System.arraycopy(langBytes, 0, payLoad, 1, langLength);
      System.arraycopy(textBytes, 0, payLoad, 1+langLength, textLength);
      NdefRecord recordNFC = new NdefRecord(NdefRecord.TNF_WELL_KNOWN, NdefRecord.RTD_TEXT, new byte[0], payLoad);
      return recordNFC;
   }

   @Override
   protected void onNewIntent(Intent intent) {
      super.onNewIntent(intent);
      setIntent(intent);
      reaFromIntent(intent);
      if (NfcAdapter.ACTION_TAG_DISCOVERED.equals(intent.getAction())){
         myTag = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
      }
   }

   @Override
   protected void onResume() {
      super.onResume();
      mAdapter.enableForegroundDispatch(this, mPendingIntent, null, null);
      writeModeOn();
   }

   private void writeModeOn() {
      writeMode = true;
      mAdapter.enableForegroundDispatch(this, mPendingIntent, writingTagFilters, null);
   }

   @Override
   protected void onPause() {
      super.onPause();
      if (mAdapter != null) {
         mAdapter.disableForegroundDispatch(this);
      }
      writeModeOff();
   }
   private void writeModeOff() {
      writeMode = false;
      mAdapter.disableForegroundDispatch(this);
   }
}
