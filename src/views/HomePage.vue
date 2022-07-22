<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-title>Inbox</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true">
      <ion-refresher slot="fixed" @ionRefresh="refresh($event)">
        <ion-refresher-content></ion-refresher-content>
      </ion-refresher>

      <ion-button @click="scanDevice">
        Scan Devices
      </ion-button>

      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Inbox</ion-title>
        </ion-toolbar>
      </ion-header>

      <ion-list>
        <MessageListItem
          v-for="(device,index) in devices"
          :key="index"
          :message="device"
          @connect="connectToDevice"
        />
      </ion-list>
    </ion-content>
  </ion-page>
</template>

<script lang="ts">
import {
  IonContent,
  IonHeader,
  IonList,
  IonPage,
  IonRefresher,
  IonRefresherContent,
  IonTitle,
  IonToolbar,
  IonButton
} from '@ionic/vue';
import MessageListItem from '@/components/MessageListItem.vue';
import {defineComponent} from 'vue';
import {getMessages} from '@/data/messages';
// import {XSense} from '@capacitor/xsense';
import {IonicNativePluginExample} from '../plugins/IonicNativePluginExample'

export default defineComponent({
  name: 'HomePage',
  data() {
    return {
      messages: getMessages(),
      devices: [],
      int1: 0,
      int2: 0,
      answer: ""
    }
  },
  async mounted() {
    await this.connectionManager();
    this.addListeners()
  },
  methods: {
    addListeners() {
      IonicNativePluginExample.addListener("EVENT_LISTENER_NAMEQ", ({message}) => {
        console.log("Notifying->", message);
        this.devices = message
      });
    },

    async scanDevice() {
      console.log("calling scanDevice function from js")
      await IonicNativePluginExample.scanDevices()
    },

    async connectionManager() {
      console.log("calling connectionManager function from js")
      await IonicNativePluginExample.connectionManager()
    },
    async CoonectionScanStopWhenViewWillDisappear() {
      console.log("calling CoonectionScanStopWhenViewWillDisappear function from js")
      await IonicNativePluginExample.CoonectionviewWillDisappear()
    },
    async connectSpecifiDevice(udid: string) {
      console.log("calling CoonectionScanStopWhenViewWillDisappear function from js")
      await IonicNativePluginExample.connectSpecifiDevice({udid})
    },
    async connectToDevice(uuid: string) {
      await this.connectSpecifiDevice(uuid)
    },
    refresh: (ev: CustomEvent) => {
      setTimeout(() => {
        ev.detail.complete();
      }, 3000);
    },
  },
  components: {
    IonContent,
    IonHeader,
    IonList,
    IonPage,
    IonRefresher,
    IonRefresherContent,
    IonTitle,
    IonToolbar,
    MessageListItem,
    IonButton
  },
});
</script>
