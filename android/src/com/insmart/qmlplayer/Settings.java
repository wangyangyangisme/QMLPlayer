package com.insmart.qmlplayer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.qtproject.qt5.android.bindings.QtApplication;

import android.annotation.TargetApi;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ExpandableListView;
import android.widget.ListView;
import android.widget.SeekBar;
import android.widget.SimpleAdapter;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;
import android.widget.SeekBar.OnSeekBarChangeListener;

@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
public class Settings extends org.qtproject.qt5.android.bindings.QtActivity {

    private final static String TAG = "Settings";
    private LeDeviceListAdapter mLeDeviceListAdapter;
    private BluetoothAdapter mBluetoothAdapter;
    private boolean mScanning;
    private Handler mHandler;
    private BluetoothLeService mBluetoothLeService;
    private boolean mConnected = false;
    private BluetoothGattCharacteristic mNotifyCharacteristic;

    private final static String UUID_KEY_DATA = "0783b03e-8535-b5a0-7140-a304d2495cba";
    private static final int REQUEST_ENABLE_BT = 1;
    // Stops scanning after 10 seconds.
    private static final long SCAN_PERIOD = 10000;

    // *********************************for
    // test**************************************
    /*
     * ArrayList<Map<String, Object>> mDevice_List = new ArrayList<Map<String,
     * Object>>(); ListView mListView = null; SimpleAdapter mDv_adapter;
     */
    // ***************************end of test
    // ****************************************

    private static void print(String msg) {
        Log.i(TAG, msg);
    }

    // Device scan callback.
    private BluetoothAdapter.LeScanCallback mLeScanCallback = new BluetoothAdapter.LeScanCallback() {

        @Override
        public void onLeScan(final BluetoothDevice device, int rssi,
                byte[] scanRecord) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    mLeDeviceListAdapter.addDevice(device);
                    mLeDeviceListAdapter.notifyDataSetChanged();
                }
            });
        }
    };

    private final ServiceConnection mServiceConnection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName componentName,
                IBinder service) {
            mBluetoothLeService = ((BluetoothLeService.LocalBinder) service)
                    .getService();
            if (!mBluetoothLeService.initialize()) {
                Log.e(TAG, "Unable to initialize Bluetooth");
                finish();
            }
        }

        @Override
        public void onServiceDisconnected(ComponentName componentName) {
            mBluetoothLeService = null;
        }
    };

	private final BroadcastReceiver mGattUpdateReceiver = new BroadcastReceiver() {
		@Override
		public void onReceive(Context context, Intent intent) {
			final String action = intent.getAction();
			if (BluetoothLeService.ACTION_GATT_CONNECTED.equals(action)) {
				mConnected = true;
				ble_connected_cb();
                print("connect");
				invalidateOptionsMenu();
			} else if (BluetoothLeService.ACTION_GATT_DISCONNECTED
					.equals(action)) {
				mConnected = false;
				ble_disconnect_cb();
                 print("disconnect");
				invalidateOptionsMenu();
			} else if (BluetoothLeService.ACTION_GATT_SERVICES_DISCOVERED
					.equals(action)) {

            } else if (BluetoothLeService.ACTION_DATA_AVAILABLE.equals(action)) {

            }
        }
    };

	private void scanLeDevice(final boolean enable) {
		if (enable) {
			// Stops scanning after a pre-defined scan period.
			mHandler.postDelayed(new Runnable() {
				@Override
				public void run() {
					mScanning = false;
					mBluetoothAdapter.stopLeScan(mLeScanCallback);
					scan_timeout_callback();
					invalidateOptionsMenu();
				}
			}, SCAN_PERIOD);

            mScanning = true;
            mBluetoothAdapter.startLeScan(mLeScanCallback);
        } else {
            mScanning = false;
            mBluetoothAdapter.stopLeScan(mLeScanCallback);

        }
        invalidateOptionsMenu();
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // ********************************for test
        // ***************************************
        /* setContentView(R.layout.mtest); */
        // ******************************end of test
        // **************************************
        mHandler = new Handler();
        print("onCreate");
        if (!getPackageManager().hasSystemFeature(
                PackageManager.FEATURE_BLUETOOTH_LE)) {
            print("have no ble device!");
            finish();
        }

        // 测试本机是否支持BLE
        final BluetoothManager bluetoothManager = (BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE);
        mBluetoothAdapter = bluetoothManager.getAdapter();
        // Checks if Bluetooth is supported on the device.
        if (mBluetoothAdapter == null) {
            print("not surport ble!!");
            finish();
            return;
        }
        print("success!!");
        mLeDeviceListAdapter = new LeDeviceListAdapter();
        registerReceiver(mGattUpdateReceiver, makeGattUpdateIntentFilter());
        Intent gattServiceIntent = new Intent(this, BluetoothLeService.class);
        bindService(gattServiceIntent, mServiceConnection, BIND_AUTO_CREATE);

        // ****************************************for
        // test*****************************************
        /******************************************************************************************/
        /*
         * Button bnt = (Button) findViewById(R.id.button1);
         * bnt.setOnClickListener(new OnClickListener() {
         *
         * @Override public void onClick(View v) { // TODO Auto-generated method
         * stub Button bnt = (Button) v; Log.e("Button", "jasdlfjkklsad"); if
         * (bnt.getText().equals("搜索")) { mLeDeviceListAdapter.clear();
         * scanLeDevice(true); } else if (bnt.getText().equals("停止")) {
         * scanLeDevice(false); } } });
         *
         * Button bnt1 = (Button) findViewById(R.id.button2);
         * bnt1.setOnClickListener(new OnClickListener() {
         *
         * @Override public void onClick(View v) { // TODO Auto-generated method
         * stub Button bnt = (Button) v; Log.e("Button bnt1", "jasdlfjkklsad");
         * if (bnt.getText().equals("连接")) {
         * connect2device("60:28:07:65:9E:2F"); bnt.setText("断开"); } else {
         * disconnect(); bnt.setText("连接"); } } });
         *
         * ToggleButton tbnt = (ToggleButton) findViewById(R.id.toggleButton1);
         * tbnt.setOnClickListener(new OnClickListener() {
         *
         * @Override public void onClick(View v) { // TODO Auto-generated method
         * stub ToggleButton tbnt_t = (ToggleButton) v;
         *
         * if (tbnt_t.isChecked()) { sendData("OFF"); Log.e("ToggleButton",
         * "jasdlfjkklsad"); } else { sendData("ON"); Log.e("ToggleButton",
         * "6546545454"); }
         *
         * } });
         *
         * SeekBar sp = (SeekBar) findViewById(R.id.seekBar1);
         * sp.setOnSeekBarChangeListener(new OnSeekBarChangeListener() {
         *
         * @Override public void onStopTrackingTouch(SeekBar seekBar) {
         *
         * }
         *
         * @Override public void onStartTrackingTouch(SeekBar seekBar) {
         *
         * }
         *
         * @Override public void onProgressChanged(SeekBar seekBar, int
         * progress, boolean fromUser) { Log.e("SeekBar",
         * String.valueOf(seekBar.getProgress()));
         * sendData("LIGHT:"+String.valueOf(seekBar.getProgress())); } });
         *
         * mListView = (ListView) findViewById(R.id.listView1); mDv_adapter =
         * new SimpleAdapter(this, mDevice_List,
         * android.R.layout.simple_list_item_2, new String[] { "Name", "Address"
         * }, new int[] { android.R.id.text1, android.R.id.text2 });
         *
         * mListView.setAdapter(mDv_adapter);
         */
        // ***************************************end of
        // test****************************************************

    }

    @Override
    protected void onStart() {
        super.onStart();
        print("onStart");
    }

    @Override
    protected void onResume() {
        super.onResume();
        print("onResume");
    }

    @Override
    protected void onPause() {
        super.onPause();
        print("onPause");
        unregisterReceiver(mGattUpdateReceiver);
    }

    // ---------------------------------------------------------------------------

    @Override
    protected void onStop() {
        super.onStop();
        print("onStop");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        print("onDestroy");
        unbindService(mServiceConnection);
        mBluetoothLeService = null;
    }

    private static IntentFilter makeGattUpdateIntentFilter() {
        final IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(BluetoothLeService.ACTION_GATT_CONNECTED);
        intentFilter.addAction(BluetoothLeService.ACTION_GATT_DISCONNECTED);
        intentFilter
                .addAction(BluetoothLeService.ACTION_GATT_SERVICES_DISCOVERED);
        intentFilter.addAction(BluetoothLeService.ACTION_DATA_AVAILABLE);
        return intentFilter;
    }

    // Adapter for holding devices found through scanning.
    private class LeDeviceListAdapter extends BaseAdapter {
        private ArrayList<BluetoothDevice> mLeDevices;

        public LeDeviceListAdapter() {
            super();
            mLeDevices = new ArrayList<BluetoothDevice>();
        }

        public void addDevice(BluetoothDevice device) {
            if (!mLeDevices.contains(device)) {
                mLeDevices.add(device);
                scan_callback(device.getName(), device.getAddress());

                // *********************** for test**************************
                /*
                 * print(device.getName() + "," + device.getAddress());
                 * Map<String, Object> item = new HashMap<String, Object>();
                 * item.put("Name", device.getName()); item.put("Address",
                 * device.getAddress()); mDevice_List.add(item);
                 * mDv_adapter.notifyDataSetChanged();
                 */
                // **********************end of test ************************

            }
        }

        public BluetoothDevice getDevice(int position) {
            return mLeDevices.get(position);
        }

        public void clear() {
            mLeDevices.clear();
        }

        @Override
        public int getCount() {
            return mLeDevices.size();
        }

        @Override
        public Object getItem(int i) {
            return mLeDevices.get(i);
        }

        @Override
        public long getItemId(int i) {
            return i;
        }

        @Override
        public View getView(int arg0, View arg1, ViewGroup arg2) {
            // TODO Auto-generated method stub
            return null;
        }

    }

    // API 扫描设备
    public void scanning4Device() {
        scanLeDevice(true);
    }

    public void stopScanning(){
        scanLeDevice(false);
    }


    // API 断开设备连接
    public void disconnect() {
        if (mBluetoothLeService != null) {
            mBluetoothLeService.disconnect();
            print("mBluetoothLeService.connect(address) ");
        }
    }

    // API 连接地址为address的设备
    public void connect2device(String address) {
        print("connect2device  " + address);

        if (mBluetoothLeService != null) {
            boolean result = mBluetoothLeService.connect(address);
            print("mBluetoothLeService.connect(address) ");
        }

    }
/*
    // API 获取第position个设备地址
    public String Get_Device_Addr(int position) {
        String res = null;
        res = mLeDeviceListAdapter.getDevice(position).getAddress();
        return res;
    }

    // API 获取第position个设备名称
    public String Get_Device_Name(int position) {
        String res = null;
        res = mLeDeviceListAdapter.getDevice(position).getName();
        return res;
    }

    // API 获取设备数量
    public int Get_Device_cnt() {
        int res = 0;
        res = mLeDeviceListAdapter.getCount();
        return res;
    }
*/
    // API 发送数据
    public int sendData(String str) {
        if (mConnected) {
            List<BluetoothGattService> gattServices = mBluetoothLeService
                    .getSupportedGattServices();
            if (gattServices == null)
                return -1;
            String uuid = null;
            for (BluetoothGattService gattService : gattServices) {
                uuid = gattService.getUuid().toString();
                List<BluetoothGattCharacteristic> gattCharacteristics = gattService
                        .getCharacteristics();
                for (BluetoothGattCharacteristic gattCharacteristic : gattCharacteristics) {
                    uuid = gattCharacteristic.getUuid().toString();
                    if (uuid.equals(UUID_KEY_DATA)) {
                        System.out.println("Send Data!");
                        mBluetoothLeService.mBluetoothGatt
                                .setCharacteristicNotification(
                                        gattCharacteristic, true);
                        gattCharacteristic.setValue(str);
                        mBluetoothLeService.mBluetoothGatt
                                .writeCharacteristic(gattCharacteristic);
                    }
                }
            }
            return str.length();
        } else {
            return -1;
        }
    }

    // CallBack 扫描回调 dev_name:设备名称 dev_addr: 设备地址
    //
    public void scan_callback(String dev_name, String dev_addr) {
        //if (mScanning) {
        //print("dev_name:"+dev_name);
        //if(dev_name.)
            FooJavaClass a = new FooJavaClass();
            a.callNativeDev(dev_name, dev_addr);
        //}else{

        //}

        //a.foo(100);
    }

    public void scan_timeout_callback() {
        FooJavaClass a = new FooJavaClass();
        a.callNativeEnd();
     }

     //连接成功
         public void ble_connected_cb() {
             FooJavaClass a = new FooJavaClass();
             a.callNativeConnectSuccess();
         }
         //断开连接
         public void ble_disconnect_cb() {
             FooJavaClass a = new FooJavaClass();
             a.callNativeConnectError();
         }


}

class FooJavaClass
{
    public void foo(int x)
    {
        if (x < 100)
            callNativeOne(x);
        else
            callNativeTwo(x);
    }

    private native void callNativeOne(int x);
    private native void callNativeTwo(int x);

    public native void callNativeDev(String dev_name, String dev_addr);
    public native void callNativeEnd();
    public native void callNativeConnectSuccess();
    public native void callNativeConnectError();

}
