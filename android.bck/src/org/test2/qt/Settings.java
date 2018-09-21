package org.test2.qt;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.os.Handler;
import android.os.Message;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothServerSocket;
import android.bluetooth.BluetoothSocket;
import android.content.Context;
import android.content.Intent;
import android.net.wifi.WifiConfiguration;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.widget.Toast;


import android.os.PowerManager;
import android.os.PowerManager.WakeLock;

public class Settings extends org.qtproject.qt5.android.bindings.QtActivity {

/*	public BluetoothAdapter mBluetoothAdapter = null;
	private final String TAG = "BluetoothServer";

    //public Context mContext = null;
	private WifiAdmin mWifiAdmin;

	List<WifiConfiguration> listWCF;
	WifiConfiguration mWifiConfiguration;

	private Handler updateBarHandler = null;

	AcceptThread mAcceptThread;
    private WakeLock wakeLock = null;

    public void bluetoothSettings() {
		Intent mIntent = new Intent();
		ComponentName comp = new ComponentName("com.android.settings",
				"com.android.settings.bluetooth.BluetoothSettings");
		mIntent.setComponent(comp);
		mIntent.setAction("android.intent.action.VIEW");
		startActivity(mIntent);
	}

	public void startServer() {
//

        //mContext = this;

		// a();

		mWifiAdmin = new WifiAdmin(this);

		mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
		if (mBluetoothAdapter == null) {
            //Toast.makeText(this, "本机没有找到蓝牙硬件或驱动！", Toast.LENGTH_SHORT).show();
            //finish();
            Log.d("settings", "本机没有找到蓝牙硬件或驱动！");
		}
		// 如果本地蓝牙没有开启，则开启
        //if (!mBluetoothAdapter.isEnabled()) {
			// 我们通过startActivityForResult()方法发起的Intent将会在onActivityResult()回调方法中获取用户的选择，比如用户单击了Yes开启，
			// 那么将会收到RESULT_OK的结果，
			// 如果RESULT_CANCELED则代表用户不愿意开启蓝牙
            //Intent mIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            //startActivityForResult(mIntent, 1);
            //startActivity(mIntent);

			// 用enable()方法来开启，无需询问用户(实惠无声息的开启蓝牙设备),这时就需要用到android.permission.BLUETOOTH_ADMIN权限。


			// mBluetoothAdapter.disable();//关闭蓝牙
        //}
        Log.d("settings", "打开蓝牙硬件或驱动！");
        mBluetoothAdapter.enable();
        //屏蔽下面发现 重启报错
//		if (!mBluetoothAdapter.isDiscovering()) {
//			Intent mIntent = new Intent(
//					BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE);
//			mIntent.putExtra(BluetoothAdapter.EXTRA_DISCOVERABLE_DURATION, 0);
//            //startActivityForResult(mIntent, 2);
//            Log.d("settings", "蓝牙可被发现");
//            startActivity(mIntent);
//		}

		listWCF = mWifiAdmin.getConfiguration();

        mAcceptThread = new AcceptThread();
        mAcceptThread.start();

        acquireWakeLock();


//Log.d(TAG, "getConfiguration p");
//		updateBarHandler = new Handler() {
//			@Override
//			public void handleMessage(Message msg) {
//				switch (msg.what) {
//				case 111:
//					// Log.d(TAG, "message" + msg.obj.toString());
//					Toast.makeText(getApplicationContext(), msg.obj.toString(),
//							Toast.LENGTH_LONG).show();
//					break;
//				case 222:
//                    Log.d(TAG, "222" + msg.obj.toString());
//					mAcceptThread = new AcceptThread();
//					mAcceptThread.start();
//					break;
//				}
//			}
//		};
//Log.d(TAG, "getConfiguration");
//        Message msg = updateBarHandler.obtainMessage();// 使用Handler创建消息
//        msg.what = 222;
//        updateBarHandler.sendMessageDelayed(msg,3000);
        Log.d(TAG, "send message()");
	}


    private void acquireWakeLock() {
        if (null == wakeLock) {
            PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
            wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK
                    | PowerManager.ON_AFTER_RELEASE, getClass()
                    .getCanonicalName());
            if (null != wakeLock) {
                Log.i(TAG, "call acquireWakeLock");
                wakeLock.acquire();
            }
        }
    }

    // 释放设备电源锁
    private void releaseWakeLock() {
        if (null != wakeLock && wakeLock.isHeld()) {
            Log.i(TAG, "call releaseWakeLock");
            wakeLock.release();
            wakeLock = null;
        }
    }

	public void NetWorkConnect(String ssid, String psk) {
		// Log.i(TAG, ssid);

		listWCF = mWifiAdmin.getConfiguration();
		// listItem.clear();
		if (listWCF != null) {
			// listItem.clear();
			if (psk.equals("********")) {//
				// Log.i(TAG,"DFASDGFSDA");

				for (int i = 0; i < listWCF.size(); i++) {
					mWifiConfiguration = listWCF.get(i);

					if (mWifiConfiguration.SSID.equalsIgnoreCase("\"" + ssid
							+ "\"")) {

						mWifiAdmin.connetionConfiguration(i);
					}

				}
			} else if (psk == null || psk == "") {
				mWifiConfiguration = mWifiAdmin.CreateWifiInfo(ssid, psk,
						AccessPoint.SECURITY_NONE);
				mWifiAdmin.addNetWork(mWifiConfiguration);
				Log.i(TAG, "NO PASSWD CONNECT ");
			} else {
				mWifiConfiguration = mWifiAdmin.CreateWifiInfo(ssid, psk,
						AccessPoint.SECURITY_PSK);
				mWifiAdmin.addNetWork(mWifiConfiguration);
				// mWifiAdmin.reassociate();
				Log.i(TAG, "PASSWD CONNECT ");
			}
			// Log.i(TAG, " listWCF.size() = " + listWCF.size());

		} else {
			Log.i(TAG, "wifi configuration null");
		}
	}

	private class AcceptThread extends Thread {
		private final BluetoothServerSocket mmServerSocket;
		private ConnectedThread mConnectedThread = null;

		public AcceptThread() {
			// Use a temporary object that is later assigned to mmServerSocket,
			// because mmServerSocket is final
			BluetoothServerSocket tmp = null;
			try {
				// MY_UUID is the app's UUID string, also used by the client
				// code
				UUID uuid = UUID
						.fromString("00001101-0000-1000-8000-00805F9B34FB");
				tmp = mBluetoothAdapter.listenUsingRfcommWithServiceRecord(
						"ins.mirror", uuid);
			} catch (IOException e) {
			}
			mmServerSocket = tmp;
		}

		public void run() {
			BluetoothSocket socket = null;
			// Keep listening until exception occurs or a socket is returned
			while (true) {
				Log.d(TAG, "run accept");

				try {
					socket = mmServerSocket.accept();
				} catch (IOException e) {
					break;
				}
				Log.d(TAG, "run accepted");
				// If a connection was accepted
				if (socket != null) {
					// Do work to manage the connection (in a separate thread)
					// ManageConnectedSocket(socket);
					// Log.d(TAG, "START");

					mConnectedThread = new ConnectedThread(socket);
					mConnectedThread.start();
					// try {
					// mmServerSocket.close();
					// } catch (IOException e) {
					// // TODO Auto-generated catch block
					// e.printStackTrace();
					// }
					// break;
				}
			}
			// cancel();
			Log.d(TAG, "run exit");
		}

		public void cancel() {
			try {
				mmServerSocket.close();
			} catch (IOException e) {
			}

			mConnectedThread.cancel();
		}
	}

	private class ConnectedThread extends Thread {
		private final BluetoothSocket mmSocket;
		private final InputStream mmInStream;
		private final OutputStream mmOutStream;

		public ConnectedThread(BluetoothSocket socket) {
			mmSocket = socket;
			InputStream tmpIn = null;
			OutputStream tmpOut = null;
			// Get the input and output streams, using temp objects because
			// member streams are final
			try {
				tmpIn = socket.getInputStream();
				tmpOut = socket.getOutputStream();
			} catch (IOException e) {
			}
			mmInStream = tmpIn;
			mmOutStream = tmpOut;
		}

		public void run() {

			// Keep listening to the InputStream until an exception occurs
			// while (true) {
			// Read from the InputStream
			// int bytes = 0;
			// byte[] buffer = new byte[1024];
			// try {
			// bytes = mmInStream.read(buffer);
			// } catch (IOException e) {
			// // TODO Auto-generated catch block
			// e.printStackTrace();
			// }
			String s = null;

			try {
				s = inputStream2String(mmInStream);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// if (bytes > 0)
			Log.d(TAG, "" + s);
			// Toast.makeText(mContext, buffer.toString(), 2);
			// Send the obtained bytes to the UI activity
			String[] sArray = s.split(":");
			NetWorkConnect(sArray[0], sArray[1]);

//			Message msgTaskAddDone = updateBarHandler.obtainMessage();// 使用Handler创建消息
//			msgTaskAddDone.what = 111;
//			msgTaskAddDone.obj = s;

//			updateBarHandler.sendMessage(msgTaskAddDone);// 使用Handler发送消息
			// }
			cancel();
		}

		public String inputStream2String(InputStream in) throws IOException {
			StringBuffer out = new StringBuffer();
			byte[] b = new byte[4096];
			int n = in.read(b);
			out.append(new String(b, 0, n));

			return out.toString();
		}

		// Call this from the main activity to send data to the remote device
		public void write(byte[] bytes) {

			try {
				mmOutStream.write(bytes);
			} catch (IOException e) {
			}
		}

		// Call this from the main activity to shutdown the connection
		public void cancel() {
			try {
				mmSocket.close();
			} catch (IOException e) {
			}
		}
	}
	
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        // TODO Auto-generated method stub
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1) {
            if (resultCode == RESULT_OK) {
                Toast.makeText(this, "蓝牙已经开启", Toast.LENGTH_SHORT).show();

                Message msgTaskAddDone = updateBarHandler.obtainMessage();// 使用Handler创建消息
                msgTaskAddDone.what = 222;
                // msgTaskAddDone.obj = s;

                updateBarHandler.sendMessage(msgTaskAddDone);// 使用Handler发送消息
            } else if (resultCode == RESULT_CANCELED) {
                Toast.makeText(this, "不允许蓝牙开启", Toast.LENGTH_SHORT).show();
                finish();
            }
        }
        if (requestCode == 2) {
            if (resultCode == RESULT_OK) {
                Toast.makeText(this, "设备都周围可见", Toast.LENGTH_SHORT).show();
            } else if (resultCode == RESULT_CANCELED) {
                Toast.makeText(this, "", Toast.LENGTH_SHORT).show();
                finish();
            }
        }

    }
*/
}
