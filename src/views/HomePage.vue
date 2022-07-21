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

      <ion-button @click="getEchoCall">
        getEchoCall
      </ion-button>

      <ion-button @click="scanDevice">
        scanDevice
      </ion-button>

      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Inbox</ion-title>
        </ion-toolbar>
      </ion-header>

      <ion-list>
        <MessageListItem v-for="message in messages" :key="message.id" :message="message"/>
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
      int1: 0,
      int2: 0,
      answer: ""
    }
  },
  methods: {
    async getEchoCall() {
      // add a listener to native events which invokes some callback
      IonicNativePluginExample.addListener("EVENT_LISTENER_NAME", ({message}) => {
        console.log(message);
      });
      console.log("Listeneer added")

      try {
        const {message} = await IonicNativePluginExample.NativeMethod();

        console.log("response form NativeMethod", message)

        await IonicNativePluginExample.NotifyListeners();
      } catch (e: any) {
        console.log("An error", e)
      }
    },
    async scanDevice() {
      console.log("calling scanDevice function from js")
      await IonicNativePluginExample.scanDevices()
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
