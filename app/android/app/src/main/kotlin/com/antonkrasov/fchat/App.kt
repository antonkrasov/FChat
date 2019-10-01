package com.antonkrasov.fchat

import io.flutter.app.FlutterApplication
import android.content.Context
import android.support.multidex.MultiDex

class App : FlutterApplication() {

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }

}